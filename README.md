# This project is now only available in the Codeberg repo

# kak.nvim - Kakoune-like keybinds for Neovim

Changes keybinds in Neovim to use the Kakoune workflow

## Prerequisites

- Neovim 0.7+

## Installation

### [💤 lazy.nvim](https://github.com/folke/lazy.nvim)

#### From [the Codeberg repo](https://codeberg.org/mirge/kak.nvim)

```lua
{
  "kak.nvim",
  url = "https://codeberg.org/mirge/kak.nvim.git",
  --version = "^4", -- if you don't want breaking changes
  event = "VeryLazy", -- load after other plugins, to avoid conflicts
  opts = {
    -- your configuration here
  },
}
```

## Setup (if necessary)

```lua
-- you don't have to pass in the table to the setup function
require("kak").setup({
  -- your configuration here
})
```

## Default options

```lua
{
  full = true, -- if set to false, it disables all keybinds except Normal mode c, d, x, y
}
```

## Usage

### Rebound keybinds

#### Normal mode

- `c` -> `vc`
- `d` -> `vd`
- `x` -> `V`
- `y` -> `vy`

#### Full mode

- `<A-[ft]`: Extend selection backwards with the key
- `[HJKLWBEFT]`: Extend selection with the lowercase key
- `<A-[ai]>`: Around/inside
- `[hjkl]`: Remove current selection
- `[wbeft]`: Create new selection with key
- `[ai]`: Append/insert (to Insert mode)
- `<A-[wbe]>`: Create new selection backwards with the key
- `<A-j>`: Join lines
- `<A-[hl]>`: Extend selection all the way to \<motion> of the line
- `g[hl]`: Go all the way to \<motion> of the line
- `g[ge]`: Go to buffer start/end
- `g[tcb]`: \<key at the same place in \[HML]>
- `g[jk]`: Go to buffer bottom/top

##### Visual mode

- `gg`: Go back to Normal mode first
