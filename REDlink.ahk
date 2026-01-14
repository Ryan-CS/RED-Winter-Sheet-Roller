; =========================
; REDlink (AutoHotkey v1)
; Neurolink: PDF sheet (web) -> Discord dice bot
;
; Trigger contract:
;   Clipboard starts with: "[REDlink] "
;   Everything after that is the BASE COMMAND (opaque text)
;   Optional: "channel:<name>||<command>"
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

; -------------------------
; AUTO-UPDATE
; -------------------------
; IMPORTANT:
;   This build intentionally uses a "compile on the client" update pipeline.
;   On startup (or via tray menu), REDlink pulls the latest REDlink.ahk from GitHub,
;   downloads the official AutoHotkey ahk.zip bundle, extracts Ahk2Exe, compiles a
;   staged REDlink.new.exe, and then uses a small updater batch to swap the running
;   EXE (Windows locks a running executable, so the swap must happen out-of-process).
;
; Version marker. MUST exist in the GitHub raw file too.
; Use dot-separated numeric segments so comparisons are deterministic.
; Example: "2026.01.13.1" or "1.2.3"
global RL_VERSION := "999.0.0-test"


; Remote sources
global RL_UPDATE_RAW_URL := "https://raw.githubusercontent.com/Ryan-CS/RED-Winter-Sheet-Roller/refs/heads/update-test/REDlink.ahk"

global RL_AHK_ZIP_URL    := "https://www.autohotkey.com/download/ahk.zip"

; Where to stage update artifacts
global RL_UPDATER_DIR    := A_Temp "\redlink_update"


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
global RL_ChannelPrefix := "channel:"
global RL_ChannelSeparator := "||"



; -------------------------
; INACTIVITY TIMEOUT
; -------------------------
; Auto-exit after 4 hours without receiving a [REDlink] command
global RL_InactivityTimeoutMs := 4 * 60 * 60 * 1000  ; 4h in ms
global RL_LastCommandTick := A_TickCount
global RL_InactivityCheckIntervalMs := 60000         ; check every 60s

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
Menu, Tray, Add, Check for Updates, RL_MenuCheckUpdates
Menu, Tray, Add, Toggle Poller (On/Off), RL_TogglePoller
Menu, Tray, Add
Menu, Tray, Add, Exit, RL_Exit
Menu, Tray, Default, Open Sheet

; Optional custom icon:
; Menu, Tray, Icon, redlink.ico

; startup code
; Auto-update check (silent on startup). If an update is found, REDlink will
; stage + compile a new EXE in %TEMP% and then exit so the updater can swap files.
; You can also trigger this manually via the tray menu.
RL_CheckForUpdate(true)

RL_LastClipText := Clipboard
RL_LastClip := ClipboardAll
SetTimer, RL_ClipboardPoller, % RL_ClipPollIntervalMs
SetTimer, RL_InactivityWatchdog, % RL_InactivityCheckIntervalMs

return   ; <-- force auto-execute to end here





; -------------------------
; TRAY MENU HANDLERS
; -------------------------
RL_MenuCheckUpdates:
    ; Manual (non-silent) update check.
    RL_CheckForUpdate(false)
return

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

}

RL_ToggleChannelCheck() {
    global RL_RequireChannelMatch
    RL_RequireChannelMatch := !RL_RequireChannelMatch
    RL_UpdateTrayTip()
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
    global RL_LastCommandTick

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

    ; Extract payload (optional channel + base command)
    payload := SubStr(curText, StrLen(RL_Prefix) + 1)
    if (payload = "")
        return

    channelName := ""
    baseCmd := ""
    RL_ParsePayload(payload, baseCmd, channelName)
    if (baseCmd = "")
        return

    ; mark activity on valid command
    RL_LastCommandTick := A_TickCount

    RL_SendToDiscord(baseCmd, channelName)
}

; -------------------------
; SEND ROUTINE
; -------------------------
RL_SendToDiscord(baseCmd, channelName) {
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
        RL_Restore()
        return
    }

    WinWaitActive, ahk_id %discordID%, , 1.0
    WinGetTitle, activeTitle, A
    RL_DebugTip("Active: " . activeTitle)
    if !WinActive("ahk_id " . discordID) {
        RL_Restore()
        return
    }

    ; Verify channel name pattern: configured channel name, fallback to game<digits> dice
    if (RL_RequireChannelMatch) {
        WinGetTitle, title, A
        if (channelName != "") {
            if (!RL_ChannelMatchesTitle(channelName, title)) {
                if (!RL_QuickSwitchToChannel(channelName)) {
                    TrayTip, REDlink, % "Not sending: could not quickswitch.`nChannel: " . channelName, 3, 17
                    RL_Restore()
                    return
                }
                if (!RL_WaitForChannelTitle(channelName, 1500, title)) {
                    TrayTip, REDlink, % "Not sending: Discord not in channel.`nChannel: " . channelName . "`nTitle: " . title, 3, 17
                    RL_Restore()
                    return
                }
            }
        } else if !RegExMatch(title, "i)game\d+[-\s]+dice") {
            TrayTip, REDlink, % "Not sending: Discord not in a game# dice channel.`nTitle: " . title, 3, 17
            RL_Restore()
            return
        }
    }
	SetKeyDelay, 50, 50


    Sleep, 120
    SendEvent, ^a

    Sleep, 50
	

    SendEvent, ^v
    Sleep, % RL_PasteDelayMs
	
;   SendInput, {Enter}    <==== Do not use this line unless you know what it is.

    Sleep, % (RL_PasteDelayMs + 40)

    RL_Restore()
}

RL_Restore() {
    global RL_LastClip, RL_ReturnFocus, RL_PrevWinID, RL_Sending

    if (RL_LastClip != "")
        Clipboard := RL_LastClip


    RL_Sending := false
}

; -------------------------
; CHANNEL PARSING & MATCHING
; -------------------------
RL_ParsePayload(payload, ByRef baseCmd, ByRef channelName) {
    global RL_ChannelPrefix, RL_ChannelSeparator
    baseCmd := payload
    channelName := ""
    prefixLen := StrLen(RL_ChannelPrefix)
    if (SubStr(payload, 1, prefixLen) = RL_ChannelPrefix) {
        sepPos := InStr(payload, RL_ChannelSeparator)
        if (sepPos) {
            channelName := SubStr(payload, prefixLen + 1, sepPos - (prefixLen + 1))
            baseCmd := SubStr(payload, sepPos + StrLen(RL_ChannelSeparator))
        } else {
            channelName := SubStr(payload, prefixLen + 1)
            baseCmd := ""
        }
    }
    channelName := Trim(channelName)
    baseCmd := Trim(baseCmd)
}

RL_ChannelMatchesTitle(channelName, title) {
    words := RL_GetChannelWords(channelName)
    if (!IsObject(words) || words.MaxIndex() = "")
        return false
    pattern := "i)"
    for index, word in words {
        pattern .= ".*" . RL_EscapeRegex(word)
    }
    pattern .= ".*"
    return RegExMatch(title, pattern) ? true : false
}

RL_GetChannelWords(channelName) {
    cleaned := RegExReplace(channelName, "[^A-Za-z0-9]+", " ")
    cleaned := Trim(RegExReplace(cleaned, "\s+", " "))
    if (cleaned = "")
        return []
    return StrSplit(cleaned, " ")
}

RL_EscapeRegex(text) {
    static chars := "\.^$|?*+()[]{}"
    Loop, Parse, chars
        text := StrReplace(text, A_LoopField, "\" . A_LoopField)
    return text
}

RL_BuildQuickswitchQuery(channelName) {
    return Trim(channelName)
}
RL_QuickSwitchToChannel(channelName) {
    query := RL_BuildQuickswitchQuery(channelName)
    if (query = "")
        return false


    SetKeyDelay, 10, 10

    ; 1) Open Quick Switcher
    Sleep, 50
    SendEvent, ^k
    Sleep, 50
	

    ; 2) Type query
    SendEvent, %query%
    Sleep, 75

    ; 3) Enter to go to channel
    SendEvent, {Enter}
    Sleep, 250
    SendEvent, {Esc} ; to make sure laggy quick switcher is closed 
    Sleep, 250
	

	SendEvent, {Esc} 
    Sleep, 250
	

	
    SetKeyDelay, 50, 50
    ; 4) ensure message box focus
    SendEvent, {backspace}
    Sleep, 250
	


    return true
}




RL_WaitForChannelTitle(channelName, timeoutMs, ByRef lastTitle) {
    startTick := A_TickCount
    lastTitle := ""
    Loop {
        WinGetTitle, title, A
        lastTitle := title
        if (RL_ChannelMatchesTitle(channelName, title))
            return true
        if (A_TickCount - startTick > timeoutMs)
            break
        Sleep, 75
    }
    return false
}


; -------------------------
; INACTIVITY WATCHDOG
; -------------------------
RL_InactivityWatchdog:
    global RL_LastCommandTick, RL_InactivityTimeoutMs
    if (A_TickCount - RL_LastCommandTick >= RL_InactivityTimeoutMs) {
        RL_Log("Inactivity timeout reached; exiting.")
        ExitApp
    }
return

; =========================
; AUTO-UPDATE IMPLEMENTATION
; =========================
; Design notes:
;   - The running EXE cannot overwrite/delete itself due to Windows file locks.
;     Therefore, we compile a staged EXE and then launch a helper batch file that:
;       1) waits for this process to exit,
;       2) renames the old EXE to .old,
;       3) moves the new EXE into place,
;       4) relaunches REDlink,
;       5) performs cleanup.
;
;   - The update decision is based on RL_VERSION, parsed from the remote REDlink.ahk.
;     Ensure the GitHub file includes:  global RL_VERSION := "x.y.z"
;
;   - This intentionally avoids paid code signing. The trust model is:
;       "I trust my GitHub repo + HTTPS + AutoHotkey official download."
;     If that trust model changes, add hashing/signing later.

RL_CheckForUpdate(silent := true) {
    global RL_VERSION, RL_UPDATE_RAW_URL

    ; Fetch the remote script text in-memory so we can parse its version quickly.
    remoteText := RL_HttpGetText(RL_UPDATE_RAW_URL)
    if (remoteText = "") {
        if (!silent)
            MsgBox, 48, REDlink, Update check failed (could not fetch remote script).
        return
    }

    remoteVer := RL_ParseVersionFromScript(remoteText)
    if (remoteVer = "") {
        if (!silent)
            MsgBox, 48, REDlink, Update check failed (remote RL_VERSION marker not found).
        return
    }

    ; Compare versions (dot-separated numeric segments).
    if (RL_CompareVersions(remoteVer, RL_VERSION) <= 0) {
        if (!silent)
            MsgBox, 64, REDlink, Already up to date.`nLocal: %RL_VERSION%`nRemote: %remoteVer%
        return
    }

    ; Silent startup mode auto-updates without prompting.
    if (!silent) {
        MsgBox, 36, REDlink, Update available.`nLocal: %RL_VERSION%`nRemote: %remoteVer%`n`nUpdate now?
        IfMsgBox, No
            return
    }

    RL_DoUpdate(remoteVer)
}

RL_DoUpdate(remoteVer) {
    global RL_UPDATE_RAW_URL, RL_AHK_ZIP_URL, RL_UPDATER_DIR

    ; Clean staging dir
    FileRemoveDir, %RL_UPDATER_DIR%, 1
    FileCreateDir, %RL_UPDATER_DIR%
    if (!FileExist(RL_UPDATER_DIR)) {
        MsgBox, 48, REDlink, Update failed: could not create temp dir.`n%RL_UPDATER_DIR%
        return
    }

    zipPath := RL_UPDATER_DIR "\ahk.zip"
    srcPath := RL_UPDATER_DIR "\REDlink.ahk"
    outNew  := RL_UPDATER_DIR "\REDlink.new.exe"
    batPath := RL_UPDATER_DIR "\redlink_swap.bat"

    exePath := A_ScriptFullPath
    pid := DllCall("GetCurrentProcessId")

    ; Download official AHK bundle + latest script
    if (!RL_DownloadFile(RL_AHK_ZIP_URL, zipPath)) {
        MsgBox, 48, REDlink, Update failed: could not download ahk.zip
        return
    }
    if (!RL_DownloadFile(RL_UPDATE_RAW_URL, srcPath)) {
        MsgBox, 48, REDlink, Update failed: could not download REDlink.ahk
        return
    }

    ; Extract the zip (PowerShell Expand-Archive is available on Win10+)
    if (!RL_ExtractZip(zipPath, RL_UPDATER_DIR)) {
        MsgBox, 48, REDlink, Update failed: could not extract ahk.zip
        return
    }

    ; Locate compiler and runtime within extracted archive
    compiler := RL_FindFileRecursive(RL_UPDATER_DIR, "Ahk2Exe.exe")
    if (compiler = "") {
        MsgBox, 48, REDlink, Update failed: Ahk2Exe.exe not found after extract.
        return
    }

    runtime := ""
    ; Prefer Unicode 64-bit if present, then fall back.
    for _, candidate in ["AutoHotkeyU64.exe","AutoHotkey64.exe","AutoHotkeyU32.exe","AutoHotkey32.exe"] {
        runtime := RL_FindFileRecursive(RL_UPDATER_DIR, candidate)
        if (runtime != "")
            break
    }
    if (runtime = "") {
        MsgBox, 48, REDlink, Update failed: AutoHotkey runtime not found after extract.
        return
    }

    ; Compile staged EXE
    FileDelete, %outNew%
    cmd := """" compiler """ /in """ srcPath """ /out """ outNew """ /bin """ runtime """ /compress 0"
    RunWait, %ComSpec% /c %cmd%,, Hide

    if (!FileExist(outNew)) {
        MsgBox, 48, REDlink, Update failed: compilation did not produce output.
        return
    }

    ; Create updater batch and hand off the swap
    RL_WriteUpdaterBat(batPath, pid, exePath, outNew)

    ; Start updater and exit so the swap can happen.
    ; Note: We pass PID and full paths as args.
    Run, %ComSpec% /c """" batPath """ " pid " """ exePath """ """ outNew """",, Hide
    ExitApp
}

; ---- Parsing + comparison ----

RL_ParseVersionFromScript(text) {
    ; Expects a line like:
    ;   global RL_VERSION := "1.2.3"
    if RegExMatch(text, "m)^\s*global\s+RL_VERSION\s*:=\s*""([^""]+)""", m)
        return m1
    return ""
}

RL_CompareVersions(a, b) {
    ; Dot-separated numeric comparison.
    ; Missing segments are treated as 0.
    pa := StrSplit(a, ".")
    pb := StrSplit(b, ".")
    n := (pa.Length() > pb.Length()) ? pa.Length() : pb.Length()

    Loop, %n% {
        i := A_Index
        va := (i <= pa.Length()) ? pa[i] : "0"
        vb := (i <= pb.Length()) ? pb[i] : "0"
        va := va + 0
        vb := vb + 0
        if (va > vb)
            return 1
        if (va < vb)
            return -1
    }
    return 0
}

; ---- Network + filesystem helpers ----

RL_DownloadFile(url, outPath) {
    ; Simple downloader using UrlDownloadToFile.
    ; Returns true if the file exists and has non-trivial size.
    FileDelete, %outPath%
    UrlDownloadToFile, %url%, %outPath%
    if (!FileExist(outPath))
        return false
    FileGetSize, sz, %outPath%
    return (sz > 100)
}

RL_HttpGetText(url) {
    ; Fetches text via WinHTTP so we can parse the remote version without saving to disk.
    try {
        whr := ComObjCreate("WinHttp.WinHttpRequest.5.1")
        whr.Open("GET", url, false)
        whr.Send()
        if (whr.Status != 200)
            return ""
        return whr.ResponseText
    } catch e {
        return ""
    }
}

RL_ExtractZip(zipPath, destDir) {
    ; Uses PowerShell Expand-Archive for speed/simplicity.
    ps := "powershell -NoProfile -Command ""Try { Expand-Archive -LiteralPath '" zipPath "' -DestinationPath '" destDir "' -Force; exit 0 } Catch { exit 1 }"""
    RunWait, %ComSpec% /c %ps%,, Hide
    return (ErrorLevel = 0)
}

RL_FindFileRecursive(rootDir, fileName) {
    ; Recursively search for a file in a folder tree.
    Loop, Files, % rootDir "\*", R
    {
        if (A_LoopFileName = fileName)
            return A_LoopFileFullPath
    }
    return ""
}

RL_WriteUpdaterBat(batPath, pid, oldExe, newExe) {
    ; Writes a self-deleting updater batch that swaps the EXE after this process exits.
    ;
    ; Why this is written this way (AHK v1 note):
    ; - Continuation sections are extremely sensitive to formatting/indentation and can break parsing.
    ; - To avoid "illegal character" parse errors, we build the .bat content via incremental concatenation.
    ; - This is robust in both compiled and uncompiled execution.

    bat := ""
    bat .= "@echo off`r`n"
    bat .= "setlocal EnableExtensions EnableDelayedExpansion`r`n"
    bat .= "`r`n"
    bat .= "set ""PID=%1""`r`n"
    bat .= "set ""OLD=%~2""`r`n"
    bat .= "set ""NEW=%~3""`r`n"
    bat .= "`r`n"
    bat .= "rem Wait for the original process to exit`r`n"
    bat .= "powershell -NoProfile -Command ""try { Wait-Process -Id %PID% -ErrorAction SilentlyContinue } catch {}"" >nul 2>&1`r`n"
    bat .= "`r`n"
    bat .= "rem Try to rename OLD -> OLD.old until unlocked`r`n"
    bat .= "set ""OLD_BAK=%OLD%.old""`r`n"
    bat .= "if exist ""%OLD_BAK%"" del /f /q ""%OLD_BAK%"" >nul 2>&1`r`n"
    bat .= "`r`n"
    bat .= ":retry`r`n"
    bat .= "move /y ""%OLD%"" ""%OLD_BAK%"" >nul 2>&1`r`n"
    bat .= "if errorlevel 1 (`r`n"
    bat .= "    timeout /t 1 >nul`r`n"
    bat .= "    goto retry`r`n"
    bat .= ")`r`n"
    bat .= "`r`n"
    bat .= "rem Move NEW into place`r`n"
    bat .= "move /y ""%NEW%"" ""%OLD%"" >nul 2>&1`r`n"
    bat .= "if errorlevel 1 (`r`n"
    bat .= "    rem restore original if something went wrong`r`n"
    bat .= "    move /y ""%OLD_BAK%"" ""%OLD%"" >nul 2>&1`r`n"
    bat .= "    exit /b 1`r`n"
    bat .= ")`r`n"
    bat .= "`r`n"
    bat .= "rem Relaunch updated exe`r`n"
    bat .= "start """" ""%OLD%""`r`n"
    bat .= "`r`n"
    bat .= "rem Cleanup (best-effort)`r`n"
    bat .= "timeout /t 2 >nul`r`n"
    bat .= "del /f /q ""%OLD_BAK%"" >nul 2>&1`r`n"
    bat .= "del /f /q ""%NEW%"" >nul 2>&1`r`n"
    bat .= "del /f /q ""%~f0"" >nul 2>&1`r`n"
    bat .= "endlocal`r`n"

    FileDelete, %batPath%
    FileAppend, %bat%, %batPath%
}