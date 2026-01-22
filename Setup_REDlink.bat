@echo off
setlocal EnableExtensions EnableDelayedExpansion

set "SCRIPT_DIR=%~dp0"
set "BUILD_DIR=%TEMP%\redlink_build_%RANDOM%%RANDOM%"
set "ZIP_URL=https://www.autohotkey.com/download/ahk.zip"
set "ZIP_FILE=%BUILD_DIR%\ahk.zip"
set "REDLINK_URL=https://raw.githubusercontent.com/Ryan-CS/RED-Winter-Sheet-Roller/main/REDlink.ahk"

set "SRC_AHK=%BUILD_DIR%\REDlink.ahk"
set "EXIT_CODE=0"
set "SUCCESS=0"
set "PUSHD_DONE=0"

echo Step A: Preflight / Setup
if exist "%BUILD_DIR%" (
    rmdir /s /q "%BUILD_DIR%" >nul 2>&1
)
mkdir "%BUILD_DIR%" >nul 2>&1
if errorlevel 1 (
    echo Error: Failed to create temporary working directory "%BUILD_DIR%"
    set "EXIT_CODE=1"
    goto exit
)
pushd "%BUILD_DIR%" >nul 2>&1
if errorlevel 1 (
    echo Error: Failed to change into "%BUILD_DIR%"
    set "EXIT_CODE=1"
    goto exit
)
set "PUSHD_DONE=1"

echo Step B: Acquire AutoHotkey
call :download "%ZIP_URL%" "%ZIP_FILE%"
if errorlevel 1 (
    echo Error: Download failed
    set "EXIT_CODE=1"
    goto exit
)

echo Extracting AutoHotkey
tar -xf "%ZIP_FILE%" >nul 2>&1
if errorlevel 1 (
    powershell -NoProfile -Command "Expand-Archive -LiteralPath '%ZIP_FILE%' -DestinationPath '%BUILD_DIR%'" >nul 2>&1
    if errorlevel 1 (
        echo Error: Failed to extract "%ZIP_FILE%"
        set "EXIT_CODE=1"
        goto exit
    )
)

powershell -NoProfile -Command "Get-ChildItem -Recurse . | Unblock-File" >nul 2>&1

echo Step C: Download REDlink.ahk
call :download "%REDLINK_URL%" "%SRC_AHK%"
if errorlevel 1 (
    echo Error: Failed to download REDlink.ahk
    set "EXIT_CODE=1"
    goto exit
)
if not exist "%SRC_AHK%" (
    echo Error: REDlink.ahk was not downloaded correctly
    set "EXIT_CODE=1"
    goto exit
)

echo Step D: Prompt for REDlink output path
set "OUT_EXE="
for /f "usebackq delims=" %%O in (`powershell -NoProfile -Command "Add-Type -AssemblyName System.Windows.Forms; $dlg = New-Object System.Windows.Forms.SaveFileDialog; $dlg.Filter = 'Executable (*.exe)|*.exe'; $dlg.Title = 'Save REDlink'; $dlg.FileName = 'REDlink.exe'; if ($dlg.ShowDialog() -eq [System.Windows.Forms.DialogResult]::OK) { Write-Output $dlg.FileName }"`) do (
    set "OUT_EXE=%%O"
)

if not defined OUT_EXE (
    echo Cancelled
    goto exit
)

for %%D in ("%OUT_EXE%") do set "OUT_DIR=%%~dpD"
if not exist "%OUT_DIR%" (
    mkdir "%OUT_DIR%" >nul 2>&1
    if errorlevel 1 (
        echo Error: Could not create directory "%OUT_DIR%"
        set "EXIT_CODE=1"
        goto exit
    )
)

echo Step E: Locate compiler and runtime
set "AHK_COMPILER="
for /f "usebackq delims=" %%C in (`where /R "%CD%" Ahk2Exe.exe 2^>nul`) do (
    set "AHK_COMPILER=%%C"
    goto compiler_found
)
echo Error: Ahk2Exe.exe not found in the extracted archive
set "EXIT_CODE=1"
goto exit

:compiler_found
set "AHK_RUNTIME="
for %%R in (AutoHotkey64.exe AutoHotkeyU64.exe AutoHotkey32.exe AutoHotkeyU32.exe) do (
    for /f "usebackq delims=" %%F in (`where /R "%CD%" %%R 2^>nul`) do (
        set "AHK_RUNTIME=%%F"
        goto runtime_found
    )
)
goto missing_runtime

:runtime_found
echo Step E: Compiling REDlink.ahk
if not defined AHK_RUNTIME (
    echo Error: No AutoHotkey runtime was found
    set "EXIT_CODE=1"
    goto exit
)

echo Using compiler "%AHK_COMPILER%"
echo Using runtime "%AHK_RUNTIME%"
"%AHK_COMPILER%" /in "%SRC_AHK%" /out "%OUT_EXE%" /bin "%AHK_RUNTIME%" /compress 0
if errorlevel 1 (
    echo Error: Compilation failed with exit code %ERRORLEVEL%
    set "EXIT_CODE=1"
    goto exit
)

set "SUCCESS=1"

:missing_runtime
if not defined AHK_RUNTIME (
    echo Error: No AutoHotkey runtime (32-bit or 64-bit) was discovered
    set "EXIT_CODE=1"
    goto exit
)

goto exit

:download
setlocal
set "URL=%~1"
set "OUT=%~2"
where curl >nul 2>&1
if not errorlevel 1 (
    curl -fSL "%URL%" -o "%OUT%" >nul 2>&1
    set "DL_ERR=%ERRORLEVEL%"
    endlocal & exit /b %DL_ERR%
)
where bitsadmin >nul 2>&1
if not errorlevel 1 (
    bitsadmin /transfer "REDlinkDownload" /priority normal "%URL%" "%OUT%" >nul 2>&1
    set "DL_ERR=%ERRORLEVEL%"
    endlocal & exit /b %DL_ERR%
)
echo Error: No supported download tool (curl or bitsadmin) is available
endlocal & exit /b 1

:exit
if "%PUSHD_DONE%"=="1" (
    popd >nul 2>&1
)
if exist "%SRC_AHK%" (
    del /f /q "%SRC_AHK%" >nul 2>&1
    if exist "%SRC_AHK%" (
        echo Warning: Failed to delete "%SRC_AHK%"
    )
)
if exist "%BUILD_DIR%" (
    rmdir /s /q "%BUILD_DIR%" >nul 2>&1
    if exist "%BUILD_DIR%" (
        echo Warning: Failed to delete "%BUILD_DIR%"
    )
)
if "%SUCCESS%"=="1" (
    echo Build completed: "%OUT_EXE%"
) else if "%EXIT_CODE%"=="0" (
    rem nothing, probably user cancelled
) else (
    echo Build failed; see above for details
)
endlocal
exit /b %EXIT_CODE%
