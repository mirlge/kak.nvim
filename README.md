# kak.nvim - Kakoune-like keybinds for Neovim

Changes keybinds in Neovim to use the Kakoune workflow

## Installation

### [💤 lazy.nvim](https://github.com/folke/lazy.nvim)

#### From [the GitHub repo](https://github.com/mirlge/kak.nvim) (shorter)

```lua
{
  "mirlge/kak.nvim",
  --version = "^3", -- if you don't want breaking changes
  event = "VeryLazy", -- load after other plugins, to avoid conflicts
  opts = {
    -- your configuration here
  },
}
```

#### From [the Codeberg repo](https://codeberg.org/mirge/kak.nvim)

```lua
{
  "kak.nvim",
  url = "https://codeberg.org/mirge/kak.nvim.git",
  --version = "^3", -- if you don't want breaking changes
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
  visual_only = false, -- makes it be in Visual mode by default
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

##### Visual only mode

- `[hjkl]` Create new selection with key

###### Insert mode

- `<Esc>`: Back to Visual mode

###### Visual mode

- `[cdy]`: Back to Visual mode after action
- `<Esc>`: Create new selection
- `<A-Esc>`: To Normal mode
