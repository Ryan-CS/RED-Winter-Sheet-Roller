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

#NoEnv
#SingleInstance Force
#Persistent
SetBatchLines, -1
SendMode, Input
SetTitleMatchMode, 2

; -------------------------
; CONFIG
; -------------------------
global RL_Enabled := true

; Optional: open your sheet on launch (URL should include ?redlink=true)
global RL_SheetURL := "https://ryan-cs.github.io/RED-Winter-Sheet-Roller/?redlink=true"
global RL_AutoOpenSheetOnStart := true

; Discord window targeting
global RL_DiscordWin := "ahk_exe Discord.exe"

; Require channel match in window title
global RL_RequireChannelMatch := true

; UX/safety
global RL_ReturnFocus := true
global RL_DebounceMs := 350
global RL_PasteDelayMs := 60

; Sentinel prefix
global RL_Prefix := "[REDlink] "

; -------------------------
; STATE
; -------------------------
global RL_LastClip := ""      ; rolling backup of user's clipboard (ClipboardAll)
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
Menu, Tray, Add
Menu, Tray, Add, Exit, RL_Exit
Menu, Tray, Default, Open Sheet

; Optional custom icon:
; Menu, Tray, Icon, redlink.ico

; Hotkeys
^!r::RL_Toggle()
^!c::RL_ToggleChannelCheck()
^!o::RL_OpenSheet()

OnClipboardChange("RL_OnClipboardChange")
RL_UpdateTrayTip()

if (RL_AutoOpenSheetOnStart) {
    SetTimer, RL_OpenSheet_Once, -250
}
return

RL_OpenSheet_Once:
RL_OpenSheet()
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

RL_Exit() {
    ExitApp
}

RL_UpdateTrayTip() {
    global RL_Enabled, RL_RequireChannelMatch
    state := RL_Enabled ? "ON" : "OFF"
    check := RL_RequireChannelMatch ? "Check: game# dice" : "NoCheck"
    Menu, Tray, Tip, % "REDlink – " . state . " | " . check
}

; -------------------------
; CLIPBOARD WATCHER
; -------------------------
RL_OnClipboardChange(Type) {
    global RL_Enabled, RL_Prefix, RL_LastClip, RL_Sending
    global RL_LastFireTick, RL_DebounceMs

    if (!RL_Enabled)
        return

    if (RL_Sending)
        return

    curText := Clipboard

    ; Update rolling backup on normal clipboard changes
    if (SubStr(curText, 1, StrLen(RL_Prefix)) != RL_Prefix) {
        RL_LastClip := ClipboardAll
        return
    }

    ; Debounce
    now := A_TickCount
    if (now - RL_LastFireTick < RL_DebounceMs)
        return
    RL_LastFireTick := now

    ; Extract opaque base command
    baseCmd := LTrim(SubStr(curText, StrLen(RL_Prefix) + 1))
    if (baseCmd = "")
        return

    RL_SendToDiscord(baseCmd)
}

; -------------------------
; SEND ROUTINE
; -------------------------
RL_SendToDiscord(baseCmd) {
    global RL_DiscordWin, RL_RequireChannelMatch
    global RL_ReturnFocus, RL_PrevWinID
    global RL_LastClip, RL_Sending, RL_PasteDelayMs

    RL_Sending := true

    if (RL_ReturnFocus)
        RL_PrevWinID := WinExist("A")

    Clipboard := baseCmd
    ClipWait, 0.5

    if !WinExist(RL_DiscordWin) {
        SoundBeep, 600, 120
        RL_Restore()
        return
    }

    WinActivate, % RL_DiscordWin
    WinWaitActive, % RL_DiscordWin, , 1.0

    if !WinActive(RL_DiscordWin) {
        SoundBeep, 600, 120
        RL_Restore()
        return
    }

    ; Verify channel name pattern: game<digits> dice
    if (RL_RequireChannelMatch) {
        WinGetTitle, title, % RL_DiscordWin
        if !RegExMatch(title, "i)game\d+\s+dice") {
            SoundBeep, 500, 140
            TrayTip, REDlink, % "Not sending: Discord not in a game# dice channel.`nTitle: " . title, 3, 17
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

    if (RL_ReturnFocus && RL_PrevWinID)
        WinActivate, ahk_id %RL_PrevWinID%

    RL_Sending := false
}
