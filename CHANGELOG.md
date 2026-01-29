# Changelog

## 2026-01-29

### Summary
- Reset Death Save to critical-injury-only total whenever HP recovers above 0.

### User-Facing Changes
- Death Save now clears back to the critical injury total when HP rises above 0 and the control hides.

### Technical Changes
- Reset Death Save when the control transitions from visible to hidden and recompute from critical injuries.

### Integration Notes
- REDlink prefix/format: unchanged.
- Clipboard handling or focus behavior: unchanged.
- Dependencies/tooling: unchanged.

### Testing
- [ ] PDF parse and roll copy
- [ ] Luck adjustments and displays
- [ ] Save/load skills JSON
- [ ] REDlink clipboard -> Discord flow (if applicable)

## 2026-01-29

### Summary
- Forced Death Save controls to fully hide via inline display when HP is above 0.

### User-Facing Changes
- Death Save controls are now hidden reliably when HP is greater than 0.

### Technical Changes
- Death Save visibility now toggles `hidden` plus an inline `display: none` safeguard.

### Integration Notes
- REDlink prefix/format: unchanged.
- Clipboard handling or focus behavior: unchanged.
- Dependencies/tooling: unchanged.

### Testing
- [ ] PDF parse and roll copy
- [ ] Luck adjustments and displays
- [ ] Save/load skills JSON
- [ ] REDlink clipboard -> Discord flow (if applicable)

## 2026-01-29

### Summary
- Fixed Death Save visibility to reflect HUD HP value.

### User-Facing Changes
- Death Save controls now hide/show based on the HP displayed in the HUD, even before committing edits.

### Technical Changes
- Death Save visibility now falls back to the HUD HP text when the hidden input is stale.

### Integration Notes
- REDlink prefix/format: unchanged.
- Clipboard handling or focus behavior: unchanged.
- Dependencies/tooling: unchanged.

### Testing
- [ ] PDF parse and roll copy
- [ ] Luck adjustments and displays
- [ ] Save/load skills JSON
- [ ] REDlink clipboard -> Discord flow (if applicable)

## 2026-01-29

### Summary
- Hid Death Save controls until HP reaches 0.

### User-Facing Changes
- Death Save label/input/roll button stay hidden unless current HP is 0 or below.

### Technical Changes
- Added visibility toggle for the Death Save UI tied to HP updates.

### Integration Notes
- REDlink prefix/format: unchanged.
- Clipboard handling or focus behavior: unchanged.
- Dependencies/tooling: unchanged.

### Testing
- [ ] PDF parse and roll copy
- [ ] Luck adjustments and displays
- [ ] Save/load skills JSON
- [ ] REDlink clipboard -> Discord flow (if applicable)

## 2026-01-29

### Summary
- Added a Death Save control with roll button, auto-increments, and critical injury integration.

### User-Facing Changes
- Added a Death Save input above the Damage control with a !r roll button that copies `1d10+<Death Save>` and increments after each roll.
- Death Save now increases by +1 when adding critical injuries that raise the death save penalty.

### Technical Changes
- Introduced new Death Save UI elements, state storage, and save/load support.
- Wired Death Save updates to critical injury add/remove flows and new roll action.

### Integration Notes
- REDlink prefix/format: unchanged.
- Clipboard handling or focus behavior: unchanged.
- Dependencies/tooling: unchanged.

### Testing
- [ ] PDF parse and roll copy
- [ ] Luck adjustments and displays
- [ ] Save/load skills JSON
- [ ] REDlink clipboard -> Discord flow (if applicable)

## 2026-01-29

### Summary
- Added HUD warning markers for seriously/mortally wounded HP states.

### User-Facing Changes
- The HP bar now shows a midline marker and a warning icon at half HP (rounded up) or a skull at 0 HP.
- Seriously/Mortally Wounded modifier toggles get a red outline when the HP state applies but the toggle is not checked.

### Technical Changes
- Added HUD overlay elements and state-driven toggling for warning icons.
- Added a helper to compute HP thresholds and outline relevant modifier toggles without toggling them on.

### Integration Notes
- REDlink prefix/format: unchanged.
- Clipboard handling or focus behavior: unchanged.
- Dependencies/tooling: unchanged.

### Testing
- [ ] PDF parse and roll copy
- [ ] Luck adjustments and displays
- [ ] Save/load skills JSON
- [ ] REDlink clipboard -> Discord flow (if applicable)

## 2026-01-29

### Summary
- Added a REDlink handshake check from the toggle with a not-found modal and setup link.

### User-Facing Changes
- Turning REDlink on now pings the REDlink helper and shows a setup modal if it is not detected, but still enables REDlink mode.
- The not-found modal links to the project page and explains what REDlink does.

### Technical Changes
- Implemented a clipboard request + F21 response handshake for REDlink activation checks.
- Added a dedicated modal and UI handlers for REDlink detection failures.

### Integration Notes
- REDlink prefix/format: unchanged.
- Clipboard handling or focus behavior: REDlink toggle writes a handshake request and waits 1s for an F21 key response.
- Dependencies/tooling: unchanged.

### Testing
- [ ] PDF parse and roll copy
- [ ] Luck adjustments and displays
- [ ] Save/load skills JSON
- [ ] REDlink clipboard -> Discord flow (if applicable)

## 2026-01-28

### Summary
- Added control to hide weapon damage buttons per attack mode, including a zero-dice shortcut.

### User-Facing Changes
- Attack modes now include a "Show damage button" checkbox in the modal (default on).
- Setting attack damage dice to 0 hides the damage button in weapon attack rows.
- Hidden damage buttons also hide the autofire multiplier and solo damage controls.

### Technical Changes
- Stored per-attack `showDamageButton` flags and derived visibility from the flag plus normalized dice.
- Allowed 0 damage dice values in attack normalization and modal input.
- Persisted the per-attack damage-button setting in save files and local state.

### Integration Notes
- REDlink prefix/format: unchanged.
- Clipboard handling or focus behavior: unchanged.
- Dependencies/tooling: unchanged.

### Testing
- [ ] PDF parse and roll copy
- [ ] Luck adjustments and displays
- [ ] Save/load skills JSON
- [ ] REDlink clipboard -> Discord flow (if applicable)

## 2026-01-28

### Summary
- Fixed save/load for custom rolls and martial arts attack skill selections.

### User-Facing Changes
- Saved states now restore custom quick bar rolls with their command strings.
- Weapon attack modes now keep martial arts sub-skill selections after reload.

### Technical Changes
- Persisted custom roll command data in state payloads and restores.
- Reordered state hydration so weapon attack skill IDs resolve after skills load.

### Integration Notes
- REDlink prefix/format: unchanged.
- Clipboard handling or focus behavior: unchanged.
- Dependencies/tooling: unchanged.

### Testing
- [ ] PDF parse and roll copy
- [ ] Luck adjustments and displays
- [ ] Save/load skills JSON
- [ ] REDlink clipboard -> Discord flow (if applicable)

## 2026-01-25

### Summary
- Made modifier toggles reorderable and surfaced active modifier names in roll labels.

### User-Facing Changes
- Modifier toggles can be dragged to reorder with drop hints in the list.
- Skill and weapon roll labels now append active modifier names in parentheses.
- Stats drawer tab styling/positioning was refined for clearer visibility.

### Technical Changes
- Added drag/drop handlers plus reorder helpers for modifier toggles and persisted the new order.
- Added modifier-name helpers for skill/attack/stat scopes and included them in roll-label builders.
- Tuned stats drawer tab CSS and background accents.

### Integration Notes
- REDlink prefix/format: unchanged.
- Clipboard handling or focus behavior: unchanged.
- Dependencies/tooling: unchanged.

### Testing
- [ ] PDF parse and roll copy
- [ ] Luck adjustments and displays
- [ ] Save/load skills JSON
- [ ] REDlink clipboard -> Discord flow (if applicable)

## 2026-01-24

### Summary
- Added weapon attack damage rolls with solo and autofire controls.

### User-Facing Changes
- Weapon attack rows now include a damage roll button, solo toggle/input, and autofire multiplier when enabled.
- Attack modal includes damage dice and autofire settings that drive the damage button label.

### Technical Changes
- Extended weapon attack state to store damage dice, autofire flags, solo damage settings, and autofire multipliers.
- Added damage roll command builders and logging for weapon attack damage buttons.

### Integration Notes
- REDlink prefix/format: unchanged.
- Clipboard handling or focus behavior: unchanged.
- Dependencies/tooling: unchanged.

### Testing
- [ ] PDF parse and roll copy
- [ ] Luck adjustments and displays
- [ ] Save/load skills JSON
- [ ] REDlink clipboard -> Discord flow (if applicable)

## 2026-01-24

### Summary
- Refined attack damage controls layout and removed number spinners.

### User-Facing Changes
- Damage row labels now sit above their checkbox/input controls.
- Damage dice, solo, and autofire number inputs no longer show spinner buttons.

### Technical Changes
- Adjusted attack damage row markup/CSS for stacked labels and spinnerless number inputs.

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
