# Changelog

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
