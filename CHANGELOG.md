# Changelog

## 2026-01-21

### Summary
- Normalized multi-roll modifier input so space-separated values roll correctly.

### User-Facing Changes
- Multi-roll modifier entries like `+2 -1` now apply both modifiers in the roll command.

### Technical Changes
- Stripped whitespace from the multi-roll modifier string before combining roll modifiers.

### Integration Notes
- REDlink prefix/format: unchanged.
- Clipboard handling or focus behavior: unchanged.
- Dependencies/tooling: unchanged.

### Testing
- [ ] PDF parse and roll copy
- [ ] Luck adjustments and displays
- [ ] Save/load skills JSON
- [ ] REDlink clipboard -> Discord flow (if applicable)

## 2026-01-20

### Summary
- Added a pop-out Stats drawer showing core character stats parsed from the Test_Sheet PDF.

### User-Facing Changes
- New STATS side tab slides out a panel with core stat values (including LUCK and EMP current/max).
- Stats drawer now docks on the left edge with the tab on the right side of the panel.
- Stat tiles now show the label above a square numeric box to match the sheet styling.
- Stat labels now overlap the box border with tighter tiles and larger label text.
- Stats drawer is narrower, values align to uniform boxes, and BODY shows current/chargen values.
- EMP/BODY chargen values now render smaller/dimmer, and Humanity current/max is shown.
- HUM current is editable with a temp adjustment box, and EMP current now derives from HUM (tens digit).
- HUM temp input now preserves +/- entries when typed.
- HUM total now appears next to the current value when a temp adjustment is entered.
- Stats auto-populate from PDF imports and update alongside Luck changes.

### Technical Changes
- Parsed INT/REF/DEX/TECH/COOL/WILL/MOVE/BODY plus EMP current/max from Test_Sheet acroform fields.
- Persisted stats in saved/local state payloads and added a stats drawer render path.

### Integration Notes
- REDlink prefix/format: unchanged.
- Clipboard handling or focus behavior: unchanged.
- Dependencies/tooling: unchanged.

### Testing
- [ ] PDF parse and roll copy
- [ ] Luck adjustments and displays
- [ ] Save/load skills JSON
- [ ] REDlink clipboard -> Discord flow (if applicable)

## 2026-01-20

### Summary
- Mapped the Test_Sheet character name field to the PDF import.

### User-Facing Changes
- Character name now loads from the Test_Sheet name field containing "Sanaa".

### Technical Changes
- Added a direct field-name fallback for the Test_Sheet character name acroform value.

### Integration Notes
- REDlink prefix/format: unchanged.
- Clipboard handling or focus behavior: unchanged.
- Dependencies/tooling: unchanged.

### Testing
- [ ] PDF parse and roll copy
- [ ] Luck adjustments and displays
- [ ] Save/load skills JSON
- [ ] REDlink clipboard -> Discord flow (if applicable)

## 2026-01-20

### Summary
- Compacted the Luck panel layout to reduce its vertical footprint.

### User-Facing Changes
- Luck controls now take up less vertical space with tighter spacing and smaller typography.
- Luck use/starting inputs have slightly wider fields to avoid horizontal clipping.
- !rr multi-rolls ignore Luck, and the modal calls this out when Luck is set.
- !rr modal now includes a modifiers input above the roll count.

### Technical Changes
- Tuned Luck panel CSS spacing, sizing, and typography for a denser layout.
- Widened the luck use/starting input width overrides.
- Added a multi-roll modal modifier input and Luck warning, and kept Luck out of !rr formulas.

### Integration Notes
- REDlink prefix/format: unchanged.
- Clipboard handling or focus behavior: unchanged.
- Dependencies/tooling: unchanged.

### Testing
- [ ] PDF parse and roll copy
- [ ] Luck adjustments and displays
- [ ] Save/load skills JSON
- [ ] REDlink clipboard -> Discord flow (if applicable)

## 2026-01-20

### Summary
- Synced weapon attack modifiers with skill and global modifiers.

### User-Facing Changes
- Weapon attack rows now show skill modifiers (and global modifiers when set) alongside base values.
- Weapon attack rolls now include skill + global modifiers in addition to attack-specific modifiers.
- Weapon attack rolls now spend and apply Luck like skill rolls.
- Weapon attack previews now show compact roll math without totals.

### Technical Changes
- Added helpers to read weapon skill modifiers from the main skills list.
- Weapons panels rerender when skill base/mod or global modifier changes.

### Testing
- [ ] PDF parse and roll copy
- [ ] Luck adjustments and displays
- [ ] Save/load skills JSON
- [ ] REDlink clipboard -> Discord flow (if applicable)

## 2026-01-20

### Summary
- Added a combat HUD with automated damage handling and refreshed status layout.
- Added automatic local state persistence so reloads restore the current sheet.
- Loading a PDF now clears prior sheet state before applying new data.

### User-Facing Changes
- Replaced HP/SP numeric inputs with a combat HUD (HP bar + Head/Body SP ticks) and editable HUD numbers.
- Reworked the combat row layout for damage, modes, and fire controls.
- Added headshot and no-ablate toggles; wedge buttons now apply damage directly.
- Added hover previews to show expected HP/SP loss from damage/fire actions.
- Fire readout click applies HP loss and logs the change.
- Split Luck/Global Modifier into a separate panel from Character Status.
- Added a Reload control for weapon ammo rows.
- Updated skill list typography and roll button accent styling.
- Page reloads now restore your last local state without requiring a manual load.
- Loading a new PDF clears previous logs, injuries, weapons, and modifiers first.

### Technical Changes
- Added HUD render/sync helpers, contenteditable bindings, and SP tick scaling logic.
- Implemented damage application (including headshots/bypass/ablation) with log entries.
- Persisted `damageHeadshot`/`damageNoAblate` and stopped persisting `damageCrit`.
- Added Jost font loading via Google Fonts.
- Added localStorage autosave/load for the state payload with a debounced write.
- Reset sheet state before parsing PDF fields to avoid stale data leakage.

### Testing
- [ ] HUD edit sync + save/load
- [ ] Damage wedges + headshot/AP/no-ablate behaviors
- [ ] Fire readout click + log entry
- [ ] Weapon reload button
- [ ] PDF parse and roll copy
- [ ] Reload page after edits to confirm local state restore

## 2026-01-16

### Summary
- Expanded Character Status with fire tracking, critical injuries, and a weapons panel.

### User-Facing Changes
- Added On Fire severity control next to HP.
- Moved the -5 HP control next to the fire slider.
- Added a Critical Injuries list with add and -5 HP controls.
- Added a Weapons panel with weapon cards and attack mode listings.
- Moved Situational Modifiers (global modifier + luck) into the Character Status column.
- Split Weapons into its own panel to match the layout sketch.
- Narrowed the Situational Modifiers block and aligned its input widths.

### Technical Changes
- Added fire slider UI and readout elements.
- Wired critical injuries list rendering in the status panel.
- Added weapons list rendering functions for the new weapons panel.
- Rendered weapons list as a dedicated panel instead of inside Character Status.
- Noted PDF weapon name placeholders map to WeaponTxt1/6/11/16/21/26/31/35 (WeaponTxt35 breaks the +5 pattern).
- Parsed HP and luck totals/current from the PDF and mapped weapon names to the correct WeaponTxt fields.
- Parsed body/head SP from the PDF into total/current fields.
- Added a debug HTML page to inspect WeaponTxt fields.

### Testing
- [ ] PDF parse and roll copy
- [ ] Luck adjustments and displays
- [ ] Save/load skills JSON (including log field)
- [ ] REDlink clipboard -> Discord flow (if applicable)

## 2026-01-14

### Summary
- Aligned the Character Status layout with the preview styling.

### User-Facing Changes
- Matched current HP/SP field styling to the preview (solid panels, typography).
- Updated damage ramps, toggles, and input alignment to the preview layout.
- Added a log preview line beneath the Log button.
- Moved BODY/HEAD legends to current inputs and added HP/SP labels above current fields.
- Added spacing between HP and Body current rows to separate the stacks.

### Technical Changes
- Added a log preview element and render hook.
- Refined Character Status CSS to mirror the preview layout.
- Updated UI smoke test to timestamp screenshots, create user-sketch copies, and open Photoshop.

### Testing
- [ ] PDF parse and roll copy
- [ ] Luck adjustments and displays
- [ ] Save/load skills JSON (including log field)
- [ ] REDlink clipboard -> Discord flow (if applicable)

## 2026-01-13

### Summary
- Introduced the character status layout and log scaffold.

### User-Facing Changes
- New status panel shows the character name input alongside a log panel.
- Log panel displays an empty-state message when no entries exist.
- Log opens a modal with entries plus clear/save controls.
- Log button sits without a boxed container in the status panel.
- Status panel no longer shows log empty-state text next to the button.
- Added tight HP/SP current + total boxes under Character Status.
- Tightened Character Status spacing to align the name field with the log button.
- Widened HP/SP total fields to avoid text clipping.
- Enlarged current HP/SP fields and aligned them to the top of their total labels.
- Adjusted HP/SP spacing and set test values for layout checks.
- Tuned current HP/SP typography to prevent clipping at narrow widths.
- Swapped current HP/SP borders to inset shadows to avoid text clipping.
- Added the damage control block with FULL/HALF/IGNR ramps, CRIT/AP toggles, and damage input.
- Character Status and Situational Modifiers now sit side by side.
- Situational Modifiers includes the former global modifier + luck block.

### Technical Changes
- Stored `characterLog` alongside `characterName` in the saved state payload.
- Rendered the log panel during main UI renders.
- UI smoke test now captures a screenshot artifact.
- Rewrapped the status + global modifier sections into a shared grid container.
- Added a log modal view and text export support.
- Persisted HP/SP current/total fields in saved state.

### Integration Notes
- REDlink prefix/format: unchanged.
- Clipboard handling or focus behavior: unchanged.
- Dependencies/tooling: unchanged.

### Testing
- [ ] PDF parse and roll copy
- [ ] Luck adjustments and displays
- [ ] Save/load skills JSON (including log field)
- [ ] REDlink clipboard -> Discord flow (if applicable)
