# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [2.0.1] - 2023-12-27

### Fixed

- Go back to Visual mode when pressing `<Esc>` in Insert mode, if Visual only mode is enabled

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

- Keybinds for backwards f and t keybinds (`<A-f>` and `<A-t>`)

## [1.0.0] - 2023-12-25

Initial release
