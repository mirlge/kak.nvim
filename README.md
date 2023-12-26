# kak.nvim - Kakoune-like keybinds for Neovim

Changes keybinds in Neovim to use the Kakoune workflow

## Installation

### [💤 lazy.nvim](https://github.com/folke/lazy.nvim)

#### From [the GitHub repo](https://github.com/mirlge/kak.nvim) (shorter)

```lua
{
  "mirlge/kak.nvim",
  --version = "^1", -- if you don't want breaking changes
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
  --version = "^1", -- if you don't want breaking changes
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

### `full` as a table

```lua
{
  enabled = true, -- same as `full = true` in the top level options
  visual_only = false, -- makes it be in Visual mode by default
}
```

## Usage

### Keybinds

It's a mix of Neovim's and Kakoune's keybinds, see the code for them
