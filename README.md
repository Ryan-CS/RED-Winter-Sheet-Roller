# RED Winter Character Sheet Roller

A fast, zero-friction roller for **Cyberpunk RED (Winter / REDice)** character sheets.

This project lets you:
- Load an **M.K. Bergins RED Winter character sheet**
- Click roll buttons directly on the sheet
- Generate correct REDice roll commands instantly

You can use it **entirely in your browser**, or optionally pair it with **REDlink (AutoHotkey)** for one-key rolling directly into REDice.

---

## Live Version (No Install Required)

**GitHub Pages:**  
https://ryan-cs.github.io/RED-Winter-Sheet-Roller/

This version works immediately in any modern browser.

---

## Two Ways to Use This Tool

### 1. Browser-Only Mode (No AHK, No Setup)
✔ Recommended for most users  
✔ Works on any OS  
✔ Nothing to install  

### 2. REDlink Mode (AutoHotkey Integration)
✔ Windows only  
✔ One-key roll → paste into REDice  
✔ Optional but powerful  

Both modes use the **same page**. The difference is whether REDlink is running.

---

## Browser-Only Mode (Default)

### What This Mode Does
- Loads your RED Winter character sheet
- Builds the correct roll command
- Copies it to your clipboard

### How to Use
1. Open the site  
2. Load your character sheet (`.pdf`)  
3. Click any **Roll** button  
4. Paste (`Ctrl+V`) into REDice  

That’s it.

---

## REDlink Mode (AutoHotkey Integration)

REDlink is an **optional Windows helper** that listens for roll commands from the page and automatically pastes them into REDice.

### What Changes When REDlink Is Running
- Clicking **Roll** immediately sends the roll to REDice
- No manual copy/paste
- Visual feedback confirms the handoff

If REDlink is **not running**, the page safely falls back to clipboard mode.

---

## System Requirements (REDlink)

- Windows 10 or newer
- AutoHotkey v1.1 (32-bit)
- REDice running (any windowed mode)

---

## Installing AutoHotkey

1. Download AutoHotkey v1.1 (NOT v2):  
   https://www.autohotkey.com/download/

2. Choose:
   - **AutoHotkey 1.1 (32-bit)**

3. Install with default options.

> REDlink is written for AHK v1.1.  
> AutoHotkey v2 will **not** work.

---

## Running REDlink (No Compilation)

1. Install AutoHotkey  
2. Double-click `REDlink.ahk`  
3. Look for the green **H** icon in the system tray  

REDlink is now active.

---

## Compiling REDlink to an EXE (Optional)

1. Right-click `REDlink.ahk`  
2. Select **Compile Script**  
3. This creates `REDlink.exe`  

You can now run the EXE directly.

---

## Using the Page With REDlink Active

1. Start REDice  
2. Run `REDlink.ahk` or `REDlink.exe`  
3. Open the Sheet Roller page  
4. Load your character  
5. Click **Roll**  

If REDlink is connected:
- The roll is sent instantly to REDice

If REDlink is not detected:
- The roll is copied to clipboard instead

---

## Safe Fallback Behavior

| Situation | Result |
|---------|--------|
| REDlink running | Auto-send to REDice |
| REDlink closed | Clipboard copy |
| REDice not focused | Roll still generated |
| Browser refresh | No data loss |

---

## Security & Privacy

- Runs fully client-side
- No uploads leave your machine
- REDlink listens only for roll messages
- No keystroke logging
- No background hooks

---

## Credits

- Character Sheet: **M.K. Bergins**
- Page Tooling & Integration: Ryan "Rysk" S
- Cyberpunk RED © R. Talsorian Games
