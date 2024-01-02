# Changelog

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).


## [4.0.0] - 2024-01-02

### Added

- `g[jk]` keybinds

### Changed

- `g[ge]` keybinds now has the behaviour that they actually have in Kakoune
- Rename `utils.keybind` to `utils.keymap`

### Removed

- Visual only mode
- Unused `window_positions` table

### Fixed

- `g[ge]` keybinds
- Visual mode to Insert mode keybinds

## [3.2.0] - 2024-01-01

### Added

- `gg` key rebind in Visual mode to go to Normal mode first
- `ge` keybind
- `g[tcb]` keybinds
- Utility function to reuse keybinds' rhs (`require("kak.utils").keybinds.set`)

### Changed

- Use `utils.keybinds.set()` to reuse keybinds' rhs

### Deprecated

- Visual only mode, to be removed in 4.0.0

## [3.1.0] - 2023-12-29

### Added

- `<A-[hl]>` keybinds (extend selection all the way in the direction in the current line)
- `g[hl]` keybinds (go all the way in the direction in the current line)

## [3.0.1] - 2023-12-28

### Changed

- Disable Insert mode key rebind `<Esc>` -> `<Esc>v`, because it didn't work

### Fixed

- `[IA]` keybinds in Visual mode

## [3.0.0] - 2023-12-28

### Changed

- `visual_only` option is moved to top level (`opts.visual_only` instead of `opts.full.visual_only`)

### Removed

- `full` option as a table

## [2.0.2] - 2023-12-28

### Fixed

- Fix `<A-j>` keybind

## [2.0.1] - 2023-12-27

### Fixed

- Go back to Visual mode when pressing `<Esc>` in Insert mode, if visual only mode is enabled

## [2.0.0] - 2023-12-27

### Added

- Visual only mode, see README.md for details
- `full` option can now be set to a table, see README.md for details
- Defaults file

### Changed

- `disable_full` becomes `full`, `disable_full = true` becomes `full = false`

## [1.2.0] - 2023-12-26

### Changed

- Changed single-char `input()`s to `getcharstr()`s

## [1.1.1] - 2023-12-26

### Fixed

- Around and inside keybinds extended the current selection if any, they were supposed to create a new selection

## [1.1.0] - 2023-12-25

### Added

- Keybinds for backwards `f` and `t` keybinds (`<A-f>` and `<A-t>`)

## [1.0.0] - 2023-12-25

Initial release
