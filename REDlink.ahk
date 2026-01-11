; =========================
; REDlink (AutoHotkey v1)
; Neurolink: PDF sheet (web) -> Discord dice bot
;
; Trigger contract:
;   Clipboard starts with: "[REDlink] "
;   Everything after that is the BASE COMMAND (opaque text)
;
; Discord safety:
;   Will only send if the active Discord window title
;   contains:  game<digits> dice
;   (examples: "game1 dice", "game12 dice")
; =========================
global RL_SheetURL := "https://ryan-cs.github.io/RED-Winter-Sheet-Roller/?redlink=true"
#NoEnv
#SingleInstance Force
#Persistent
SetBatchLines, -1
SendMode, Input
SetTitleMatchMode, 2
TrayTip, REDlink Debug, % "Startup OK (" . A_ScriptName . ")", 2, 17
global RL_SheetURL
Run, % RL_SheetURL

RL_Log("Startup OK: " . A_ScriptName)

; -------------------------
; CONFIG
; -------------------------
global RL_Enabled := true

; Optional: open your sheet on launch (URL should include ?redlink=true)
global RL_SheetURL := "https://ryan-cs.github.io/RED-Winter-Sheet-Roller/?redlink=true"
global RL_AutoOpenSheetOnStart := true

; Discord window targeting (title match, SetTitleMatchMode 2)
global RL_DiscordWinTitle := "Discord"

; Require channel match in window title
global RL_RequireChannelMatch := true

; UX/safety
global RL_ReturnFocus := true
global RL_DebounceMs := 350
global RL_PasteDelayMs := 60
global RL_Debug := true
global RL_UsePoller := true
global RL_ClipPollIntervalMs := 250
global RL_PollerCount := 0
global RL_VersionTag := "poller-debug-1"
global RL_PollerEnabled := false
global RL_LogFile := A_ScriptDir . "\\redlink-debug.log"

; Sentinel prefix
global RL_Prefix := "[REDlink] "

; -------------------------
; STATE
; -------------------------
global RL_LastClip := ""      ; rolling backup of user's clipboard (ClipboardAll)
global RL_LastClipText := ""
global RL_Sending := false
global RL_LastFireTick := 0
global RL_PrevWinID := ""

; -------------------------
; TRAY UI
; -------------------------
Menu, Tray, NoStandard
Menu, Tray, Add, Toggle REDlink (On/Off), RL_Toggle
Menu, Tray, Add, Toggle Channel Check (On/Off), RL_ToggleChannelCheck
Menu, Tray, Add, Open Sheet, RL_OpenSheet
Menu, Tray, Add, Toggle Poller (On/Off), RL_TogglePoller
Menu, Tray, Add
Menu, Tray, Add, Exit, RL_Exit
Menu, Tray, Default, Open Sheet

; Optional custom icon:
; Menu, Tray, Icon, redlink.ico

; startup code
RL_LastClipText := Clipboard
RL_LastClip := ClipboardAll
SetTimer, RL_ClipboardPoller, % RL_ClipPollIntervalMs

return   ; <-- force auto-execute to end here




; Hotkeys
^!r::RL_Toggle()
^!c::RL_ToggleChannelCheck()
^!o::RL_OpenSheet()
^!p::RL_TogglePoller()
F12::TrayTip, REDlink Debug, % "Hotkey OK - AHK running", 2, 17
F11::RL_ToggleDebug()
F10::RL_DebugClipboard()
F9::RL_DebugPoller()
F8::Gosub, RL_ClipboardPoller
F7::RL_DebugFlags()

RL_LastClipText := Clipboard
RL_LastClip := ClipboardAll
RL_UpdateTrayTip()

if (RL_AutoOpenSheetOnStart) {
    SetTimer, RL_OpenSheet_Once, -250
}

; Force poller on at startup to avoid relying on manual toggle
RL_UsePoller := true
RL_PollerEnabled := true
OnClipboardChange("RL_OnClipboardChange", 0)
SetTimer, RL_ClipboardPoller, % RL_ClipPollIntervalMs
SetTimer, RL_ClipboardPoller, -1
RL_Log("Init: " . A_ScriptFullPath . " | Poller started")
ToolTip, REDlink init: poller ON
SetTimer, RL_ClearTooltip, -1200
return

RL_OpenSheet_Once:
RL_OpenSheet()
return

RL_ClearTooltip:
ToolTip
return

; -------------------------
; TRAY ACTIONS
; -------------------------
RL_Toggle() {
    global RL_Enabled
    RL_Enabled := !RL_Enabled
    RL_UpdateTrayTip()
    SoundBeep, % (RL_Enabled ? 880 : 440), 80
}

RL_ToggleChannelCheck() {
    global RL_RequireChannelMatch
    RL_RequireChannelMatch := !RL_RequireChannelMatch
    RL_UpdateTrayTip()
    SoundBeep, % (RL_RequireChannelMatch ? 820 : 520), 80
}

RL_OpenSheet() {
    global RL_SheetURL
    Run, % RL_SheetURL
}

RL_TogglePoller() {
    global RL_UsePoller
    RL_UsePoller := !RL_UsePoller
    RL_SetPoller(RL_UsePoller)
}

RL_SetPoller(enabled) {
    global RL_PollerEnabled, RL_ClipPollIntervalMs, RL_VersionTag, RL_UsePoller
    RL_UsePoller := enabled
    if (enabled) {
        SetTimer, RL_ClipboardPoller, % RL_ClipPollIntervalMs
        OnClipboardChange("RL_OnClipboardChange", 0)
        RL_PollerEnabled := true
    ;    TrayTip, REDlink Debug, % "Poller timer enabled (" . RL_VersionTag . ")", 2, 17
        RL_Log("Poller timer enabled")
    } else {
        SetTimer, RL_ClipboardPoller, Off
        OnClipboardChange("RL_OnClipboardChange", 1)
        RL_PollerEnabled := false
    ;    TrayTip, REDlink Debug, % "Poller disabled (OnClipboardChange active)", 2, 17
        RL_Log("Poller disabled; OnClipboardChange active")
    }
}

RL_Exit() {
    ExitApp
}

RL_UpdateTrayTip() {
    global RL_Enabled, RL_RequireChannelMatch
    state := RL_Enabled ? "ON" : "OFF"
    check := RL_RequireChannelMatch ? "Check: game# dice" : "NoCheck"
    Menu, Tray, Tip, % "REDlink - " . state . " | " . check
}

RL_ToggleDebug() {
    global RL_Debug
    RL_Debug := !RL_Debug
;    TrayTip, REDlink Debug, % "Debug " . (RL_Debug ? "ON" : "OFF"), 2, 17
}

RL_DebugTip(msg) {
    global RL_Debug
    if (!RL_Debug)
        return
;    TrayTip, REDlink Debug, % msg, 1, 17
}

RL_Log(msg) {
    global RL_LogFile
    FileAppend, % A_Now . " | " . msg . "`n", % RL_LogFile
}

RL_DebugClipboard() {
    global RL_Prefix
    text := Clipboard
    preview := SubStr(text, 1, 60)
    hasPrefix := (SubStr(text, 1, StrLen(RL_Prefix)) = RL_Prefix) ? "yes" : "no"
;    TrayTip, REDlink Debug, % "Clip len: " . StrLen(text) . " | prefix: " . hasPrefix . "`n" . preview, 3, 17
}

RL_DebugPoller() {
    global RL_PollerCount, RL_LastClipText, RL_PollerEnabled
    if (!RL_PollerEnabled) {
    ;    TrayTip, REDlink Debug, % "Poller disabled | last len: " . StrLen(RL_LastClipText), 3, 17
        return
    }
;    TrayTip, REDlink Debug, % "Poller count: " . RL_PollerCount . " | last len: " . StrLen(RL_LastClipText), 3, 17
}

RL_DebugFlags() {
    global RL_UsePoller, RL_PollerEnabled, RL_Debug, RL_ClipPollIntervalMs
;    TrayTip, REDlink Debug, % "UsePoller: " . RL_UsePoller . " | Enabled: " . RL_PollerEnabled . " | Debug: " . RL_Debug . " | Interval: " . RL_ClipPollIntervalMs, 3, 17
}

; -------------------------
; CLIPBOARD WATCHER
; -------------------------
RL_OnClipboardChange(Type) {
    global RL_Sending, RL_LastClipText
    if (RL_Sending)
        return
    curText := Clipboard
    if (curText == RL_LastClipText)
        return
    RL_LastClipText := curText
    RL_HandleClipboardText(curText)
}

RL_ClipboardPoller:
    global RL_LastClipText, RL_Sending, RL_PollerCount
    RL_PollerCount += 1
    curText := Clipboard
    if (RL_Sending)
        return
    if (curText == RL_LastClipText)
        return
    RL_LastClipText := curText
    RL_HandleClipboardText(curText)
return

RL_HandleClipboardText(curText) {
    global RL_Enabled, RL_Prefix, RL_LastClip
    global RL_LastFireTick, RL_DebounceMs

    RL_DebugTip("Clipboard change seen")

    ; Update rolling backup on normal clipboard changes
    if (SubStr(curText, 1, StrLen(RL_Prefix)) != RL_Prefix) {
        RL_LastClip := ClipboardAll
        RL_DebugTip("Clipboard stored (no prefix)")
        return
    }

    if (!RL_Enabled)
        return

    ; Debounce
    now := A_TickCount
    if (now - RL_LastFireTick < RL_DebounceMs)
        return
    RL_LastFireTick := now

    ; Extract opaque base command
    baseCmd := SubStr(curText, StrLen(RL_Prefix) + 1)
    if (baseCmd = "")
        return

    RL_SendToDiscord(baseCmd)
}

; -------------------------
; SEND ROUTINE
; -------------------------
RL_SendToDiscord(baseCmd) {
    global RL_DiscordWinTitle, RL_RequireChannelMatch
    global RL_ReturnFocus, RL_PrevWinID
    global RL_LastClip, RL_Sending, RL_PasteDelayMs

    RL_Sending := true

    if (RL_ReturnFocus)
        RL_PrevWinID := WinExist("A")

    Clipboard := baseCmd
    ClipWait, 0.5

    WinGet, discordID, ID, % RL_DiscordWinTitle
    if (discordID) {
        WinActivate, ahk_id %discordID%
    } else {
        SoundBeep, 600, 120
        RL_Restore()
        return
    }

    WinWaitActive, ahk_id %discordID%, , 1.0
    WinGetTitle, activeTitle, A
    RL_DebugTip("Active: " . activeTitle)
    if !WinActive("ahk_id " . discordID) {
        SoundBeep, 600, 120
        RL_Restore()
        return
    }

    ; Verify channel name pattern: game<digits> dice
    if (RL_RequireChannelMatch) {
        WinGetTitle, title, A
        if !RegExMatch(title, "i)game\d+[-\s]+dice") {
            SoundBeep, 500, 140
        ;    TrayTip, REDlink, % "Not sending: Discord not in a game# dice channel.`nTitle: " . title, 3, 17
            RL_Restore()
            return
        }
    }

    SendInput, ^v
    Sleep, % RL_PasteDelayMs
    SendInput, {Enter}
    Sleep, % (RL_PasteDelayMs + 40)

    RL_Restore()
}

RL_Restore() {
    global RL_LastClip, RL_ReturnFocus, RL_PrevWinID, RL_Sending

    if (RL_LastClip != "")
        Clipboard := RL_LastClip


    RL_Sending := false
}
