# Changelog

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [🗿 Epoch Semantic Versioning](https://antfu.me/posts/epoch-semver).

## [Unreleased]

### Added

- New and much better `kak.utils.keymap` module with a new preset system
  and ability to iterate over a list of keys, but it still uses the old
  `kak.utils._keymap.set()` function
- Goto extend keybinds (like previous goto keybinds, but with the prefix `G`
  instead of `g`)

### Changed

- Old `kak.utils.keymap` module is now `kak.utils._keymap`
- Updated all keybinds that used the old function to use the new and improved
  `kak.utils.keymap.set()` function
- Normal goto keybinds now no longer extend the selection at all, for that
  there now are goto extend keybinds
- Updated "Rebound keybinds" section in README.md

### Fixed

- If a count was given to the Normal mode `<A-[ai]>` keybinds, that amount of
  characters would get selected instead of selecting the specified text object.
  This bug is however only fixed if you have the experimental option
  `rebind_visual_aiAI` enabled.

## [6.4.0] - 2025-01-18

### Added

- Partial WhichKey integration for Normal mode `<A-[ai]>` keybinds
- Contributing and license section in README.md

### Fixed

- The WhichKey integration being enabled without `full` option enabled - it's now disabled in that case

## [6.3.2] - 2025-01-17

### Fixed

- A bunch of debug messages were sent because of a `print` statement, which has now been removed

## [6.3.1] - 2025-01-16

### Fixed

- A variable not defined called `main` was used in the WhichKey integration,
  which has now been replaced with "which-key"

## [6.3.0] - 2025-01-16

### Added

- WhichKey text objects integration (see [README](README.md) for details)

### Changed

- Reuse Visual mode `<A-[ai]>` keybinds for Normal mode `<A-[ai]>` keybinds
  if experimental option `rebind_visual_aiAI` is enabled

## [6.2.1] - 2025-01-15

### Fixed

- Visual mode `[AI]` keybinds weren't rebound to what they do in Normal mode, when experimental option `rebind_visual_aiAI` was set to true

## [6.2.0] - 2025-01-14

### Added

- `<A-[ai]>` keybinds
- Option to rebind Visual mode `[aiAI]` keybinds to make them work like they do in Kakoune - see [README.md](./README.md) for details

## [6.1.0] - 2024-11-19

### Added

- `pkg.json` file (see [neovim/packspec](https://github.com/neovim/packspec) for info)

## [6.0.0] - 2024-08-20

### Added

- Testing script (`dev.sh`)

### Removed

- `[ai]` key rebinds in Visual mode
- `<A-i>` keybinds

## [5.0.0] - 2024-02-02

### Changed

- `[ai]` keybinds in Visual mode now do it on their corresponding end of the selection
- `g[jkeg]` keybinds in Visual mode now don't leave Visual mode

## [4.2.1] - 2024-01-06

### Fixed

- Normal mode `R` keybind

## [4.2.0] - 2024-01-05

### Added

- `utils.keycode()` as a replacement for `vim.keycode()`, making full mode work in older versions of Neovim

### Changed

- Minimum Neovim version for full mode is now the same as for basic mode

## [4.1.0] - 2024-01-04

### Added

- `R` keybind which replaces selection with the yanked content
- `second_resulting_key` option for `utils.keymap.set()`

### Changed

- `[pP]` keybinds in Visual mode has been remapped to do what they do in Kakoune

## [4.0.1] - 2024-01-03

### Fixed

- Keybinds using `pre_count` feature of `utils.keymap.set()`, for example `[ft]` keybinds

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
