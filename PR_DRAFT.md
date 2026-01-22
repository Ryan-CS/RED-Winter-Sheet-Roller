# Pull Request

## Summary
- Expand the character HUD with stats drawer, combat tooling, and roll quality-of-life updates.

## Changes
- Added a combat HUD with HP bar plus Head/Body SP tick tracks, and hid the legacy numeric HP/SP inputs.
- Made HUD numbers editable, synced them to state/inputs, and added hover previews for damage/fire deltas.
- Rebuilt the combat row layout (HUD, damage, modes, flags, fire), added headshot/no-ablate toggles, and wired wedge buttons to apply damage.
- Made the fire readout clickable to apply HP loss and log the change.
- Logged damage/fire changes into the character log with tags and deltas.
- Split Luck/Global Modifier into its own panel and compacted the Luck panel layout.
- Added a stats side drawer populated from PDF fields (INT/REF/DEX/TECH/COOL/WILL/MOVE/BODY/EMP/HUM), including HUM temp handling.
- Synced weapon attack modifiers with skill/global modifiers and included them in weapon roll math.
- Normalized multi-roll modifier input so space-separated entries are respected in roll commands.
- Added local state persistence on reload and clear state before new PDF imports.
- Mapped the Test_Sheet character name field to the PDF import.
- Updated skill list styling and roll button accent styling.
- Switched the UI font to Jost via Google Fonts.
- Saved/restored new damage flags (headshot/no-ablate) and stopped persisting damage crit.

## Testing
- [ ] HUD edits sync HP/SP values and persist on save/load
- [ ] Damage wedges apply HP/SP changes (headshot/AP/no-ablate)
- [ ] Fire readout click applies HP loss and logs it
- [ ] PDF parse and roll copy output format
- [ ] Luck adjustments and displays
- [ ] Save/load skills JSON
- [ ] Multi-roll modifier input applies space-separated modifiers
- [ ] Stats drawer loads from Test_Sheet PDF and updates with Luck
- [ ] Weapon rolls include skill/global modifiers

## Notes
- REDlink prefix/format: unchanged.
- Dependencies/tooling: none.
