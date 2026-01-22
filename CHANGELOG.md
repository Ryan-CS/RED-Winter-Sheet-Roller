# Changelog

## 2026-01-21

### Summary
- Hide empty scope previews in Edit Modifiers when the modifier value is zero/blank.

### User-Facing Changes
- Scope preview text no longer shows "ALL" when no modifier value is set.

### Technical Changes
- Scope preview helper now returns an empty string when the normalized value is blank.

### Integration Notes
- REDlink prefix/format: unchanged.
- Clipboard handling or focus behavior: unchanged.
- Dependencies/tooling: unchanged.

### Testing
- [ ] PDF parse and roll copy
- [ ] Luck adjustments and displays
- [ ] Save/load skills JSON
- [ ] REDlink clipboard -> Discord flow (if applicable)

## 2026-01-21

### Summary
- Added modifier value previews to the Edit Modifiers scope selections.

### User-Facing Changes
- Edit Modifiers now shows value + selection previews like "-2 ALL" or "+2 COOL, WILL" under each scope selector.

### Technical Changes
- Added a scope preview helper to combine normalized modifier values with selection summaries.

### Integration Notes
- REDlink prefix/format: unchanged.
- Clipboard handling or focus behavior: unchanged.
- Dependencies/tooling: unchanged.

### Testing
- [ ] PDF parse and roll copy
- [ ] Luck adjustments and displays
- [ ] Save/load skills JSON
- [ ] REDlink clipboard -> Discord flow (if applicable)

## 2026-01-21

### Summary
- Removed per-modifier global input and shifted default global modifiers into all-skills selections.

### User-Facing Changes
- Edit Modifiers no longer shows a Global +/- input field.
- Default modifiers (Seriously Wounded, Mortally Wounded, In a Grapple) now live under Select Skills -> All Skills.
- Existing modifier globals migrate to All Skills on load.

### Technical Changes
- Dropped per-modifier global values from modifier state persistence and roll math.
- Migrated legacy modifier globals into the skills scope during normalization.

### Integration Notes
- REDlink prefix/format: unchanged.
- Clipboard handling or focus behavior: unchanged.
- Dependencies/tooling: unchanged.

### Testing
- [ ] PDF parse and roll copy
- [ ] Luck adjustments and displays
- [ ] Save/load skills JSON
- [ ] REDlink clipboard -> Discord flow (if applicable)

## 2026-01-21

### Summary
- Show stat modifiers inside the stat boxes.

### User-Facing Changes
- Stats drawer stat boxes now show modifier totals with the + or - styling.

### Technical Changes
- Render stat modifiers for INT/DEX/TECH using the same stat box modifier formatting.

### Integration Notes
- REDlink prefix/format: unchanged.
- Clipboard handling or focus behavior: unchanged.
- Dependencies/tooling: unchanged.

### Testing
- [ ] PDF parse and roll copy
- [ ] Luck adjustments and displays
- [ ] Save/load skills JSON
- [ ] REDlink clipboard -> Discord flow (if applicable)

## 2026-01-21

### Summary
- Added a confirmation modal before clearing the sheet state.

### User-Facing Changes
- Clear Sheet now prompts with a warning and explicit confirm/cancel buttons.

### Technical Changes
- Added a clear-sheet confirmation modal and routed the clear action through it.

### Integration Notes
- REDlink prefix/format: unchanged.
- Clipboard handling or focus behavior: unchanged.
- Dependencies/tooling: unchanged.

### Testing
- [ ] PDF parse and roll copy
- [ ] Luck adjustments and displays
- [ ] Save/load skills JSON
- [ ] REDlink clipboard -> Discord flow (if applicable)

## 2026-01-21

### Summary
- Enabled dragging any master-list skill into the pinned quick bar.

### User-Facing Changes
- Unpinned skills can now be dragged from the all-skills list into the pinned quick bar.

### Technical Changes
- Treat master-list drags as column moves so pinned drops accept them.

### Integration Notes
- REDlink prefix/format: unchanged.
- Clipboard handling or focus behavior: unchanged.
- Dependencies/tooling: unchanged.

### Testing
- [ ] PDF parse and roll copy
- [ ] Luck adjustments and displays
- [ ] Save/load skills JSON
- [ ] REDlink clipboard -> Discord flow (if applicable)

## 2026-01-21

### Summary
- Added a Clear Sheet utility action to reset the page and wipe stored state.

### User-Facing Changes
- New Clear Sheet button clears local storage and reloads the page to a fresh start.

### Technical Changes
- Hooked a utility-bar button to clear localStorage and reset modifiers/templates.

### Integration Notes
- REDlink prefix/format: unchanged.
- Clipboard handling or focus behavior: unchanged.
- Dependencies/tooling: unchanged.

### Testing
- [ ] PDF parse and roll copy
- [ ] Luck adjustments and displays
- [ ] Save/load skills JSON
- [ ] REDlink clipboard -> Discord flow (if applicable)

## 2026-01-21

### Summary
- Expanded the character log to capture rolls, modifiers, and key state changes.

### User-Facing Changes
- Skill and weapon rolls now log the applied modifiers (skill, global, toggle, weapon, luck, multi-roll).
- Ammo changes (reloads, manual edits, roll consumption) appear in the log.
- HP, SP, luck, global mod, and key toggles now log on blur or button actions.

### Technical Changes
- Added shared log helpers for roll detail formatting and value-change tracking.
- Weapon ammo consumption now returns usage details for logging.

### Integration Notes
- REDlink prefix/format: unchanged.
- Clipboard handling or focus behavior: unchanged.
- Dependencies/tooling: unchanged.

### Testing
- [ ] PDF parse and roll copy
- [ ] Luck adjustments and displays
- [ ] Save/load skills JSON
- [ ] REDlink clipboard -> Discord flow (if applicable)

## 2026-01-21

### Summary
- Modifier toggles edit button now sits next to the label.

### User-Facing Changes
- The Modifier Toggles "Edit" button hugs the section label instead of the far edge.

### Technical Changes
- Adjusted modifier toggle header flex alignment and spacing.

### Integration Notes
- REDlink prefix/format: unchanged.
- Clipboard handling or focus behavior: unchanged.
- Dependencies/tooling: unchanged.

### Testing
- [ ] PDF parse and roll copy
- [ ] Luck adjustments and displays
- [ ] Save/load skills JSON
- [ ] REDlink clipboard -> Discord flow (if applicable)

## 2026-01-21

### Summary
- Luck remaining now shows 0 instead of an empty field.

### User-Facing Changes
- The Luck "Remaining" input displays 0 when the pool is empty.

### Technical Changes
- Always render the luck pool value in the remaining input display.

### Integration Notes
- REDlink prefix/format: unchanged.
- Clipboard handling or focus behavior: unchanged.
- Dependencies/tooling: unchanged.

### Testing
- [ ] PDF parse and roll copy
- [ ] Luck adjustments and displays
- [ ] Save/load skills JSON
- [ ] REDlink clipboard -> Discord flow (if applicable)

## 2026-01-21

### Summary
- Separated modifier toggle values in roll strings and attack skill expressions for clearer output.

### User-Facing Changes
- Skill and weapon rolls now list each active modifier toggle value instead of collapsing them into totals.
- Weapon attack skill expressions now include active skill/global modifier toggles with the base + skill mod display.
- Attack modifier hints now show only attack-scoped toggle values.

### Technical Changes
- Added modifier-part helpers to keep toggle values distinct through roll building and UI hints.

### Integration Notes
- REDlink prefix/format: unchanged.
- Clipboard handling or focus behavior: unchanged.
- Dependencies/tooling: unchanged.

### Testing
- [ ] PDF parse and roll copy
- [ ] Luck adjustments and displays
- [ ] Save/load skills JSON
- [ ] REDlink clipboard -> Discord flow (if applicable)

## 2026-01-21

### Summary
- Skill-scoped modifier toggles now apply to weapon attack rolls that use the same skill.

### User-Facing Changes
- Weapon attack modifier hints and roll strings now include active skill-scoped modifiers when the attack uses that skill.

### Technical Changes
- Added skill-scope modifier totals to weapon attack modifier calculations.

### Integration Notes
- REDlink prefix/format: unchanged.
- Clipboard handling or focus behavior: unchanged.
- Dependencies/tooling: unchanged.

### Testing
- [ ] PDF parse and roll copy
- [ ] Luck adjustments and displays
- [ ] Save/load skills JSON
- [ ] REDlink clipboard -> Discord flow (if applicable)

## 2026-01-21

### Summary
- Refined weapon ammo controls to remove spinners and tighten layout.

### User-Facing Changes
- Ammo count inputs no longer show spinner buttons and still support typing and arrow-key adjustments.
- Reload now sits directly to the left of the current ammo input, with Max aligned tightly to its field.
- Arrow key adjustments now update current/max ammo in weapon panels immediately.
- Weapon ammo inputs no longer drop focus on click.
- Weapon ammo inputs now keep focus across arrow key adjustments before clamping on blur.
- Luck, HUD numeric fields, skill levels, and modifier amount inputs now defer heavy re-renders until blur.
- Arrow keys now increment/decrement luck, damage, skill levels, HUD values, and modifier amounts without defocus.

### Technical Changes
- Reworked ammo count DOM layout into grouped controls for tighter spacing.
- Added ammo input styling to hide native number spinners.
- Updated weapon ammo inputs to persist on `input` events.

### Integration Notes
- REDlink prefix/format: unchanged.
- Clipboard handling or focus behavior: unchanged.
- Dependencies/tooling: unchanged.

### Testing
- [ ] PDF parse and roll copy
- [ ] Luck adjustments and displays
- [ ] Save/load skills JSON
- [ ] REDlink clipboard -> Discord flow (if applicable)

## 2026-01-21

### Summary
- Added modifier toggles with a dedicated editor, selection modals, and stat modifier displays.

### User-Facing Changes
- Luck & Modifiers panel now shows quick modifier toggles plus an Edit modal for detailed setups.
- Added preset modifier templates (wounded states, grapple, smash, synthcoke, primetime).
- Stat drawer now shows modifier deltas and totals for REF, COOL, WILL, and MOVE when active.
- Skill rows display active toggle modifiers alongside global and luck hints.
- Modifier effects apply to skill rolls, attack rolls, and stat displays based on their targeting.
- Modifier editor now includes selection modals for skills, stats, and attack modes.
- Weapon attack rows now show active toggle modifier totals next to attack modifiers.

### Technical Changes
- Added modifier model state with persistence in save/load and local storage.
- Integrated modifier totals into roll building for skills and weapons.
- Added modal rendering logic to add/edit/delete modifier templates.
- Expanded stats rendering to include modifier totals and deltas.
- Added scoped selection modal rendering for skills, stats, and weapon attack modes.

### Integration Notes
- REDlink prefix/format: unchanged.
- Clipboard handling or focus behavior: unchanged.
- Dependencies/tooling: unchanged.

### Testing
- [ ] PDF parse and roll copy
- [ ] Luck adjustments and displays
- [ ] Save/load skills JSON
- [ ] REDlink clipboard -> Discord flow (if applicable)

## 2026-01-21

### Summary
- Added skill level parsing and updated skill row layout to show LVL/Base/Mod separately.

### User-Facing Changes
- Skill rows now include a LVL column and show BASE derived from LVL + stat while MOD remains editable.
- Group headers align with the new LVL/BASE/MOD/PIN layout.
- Add-skill dialog now includes a LVL field and can auto-calc BASE when omitted.

### Technical Changes
- Parsed LVL fields from Test_Sheet acroform data and persisted skill levels in saved state.
- Updated skill-row grid templates and DOM construction to include level cells.

### Integration Notes
- REDlink prefix/format: unchanged.
- Clipboard handling or focus behavior: unchanged.
- Dependencies/tooling: unchanged.

### Testing
- [ ] PDF parse and roll copy
- [ ] Luck adjustments and displays
- [ ] Save/load skills JSON
- [ ] REDlink clipboard -> Discord flow (if applicable)

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
