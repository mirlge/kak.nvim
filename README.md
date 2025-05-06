# kak.nvim - Kakoune-like keybinds for Neovim

Changes keybinds in Neovim to use the Kakoune workflow

## Prerequisites

- Neovim 0.7+

## Installation

### [💤 lazy.nvim](https://github.com/folke/lazy.nvim)

#### From [the Codeberg repo](https://codeberg.org/mirge/kak.nvim) (recommended)

```lua
{
  "kak.nvim",
  url = "https://codeberg.org/mirge/kak.nvim.git",
  --version = "^6", -- if you don't want breaking changes
  event = "VeryLazy", -- load after other plugins, to avoid conflicts
  opts = {
    -- your configuration here
  },
}
```

#### From [the GitHub repo](https://github.com/mirlge/kak.nvim)

```lua
{
  "mirlge/kak.nvim",
  --version = "^6", -- if you don't want breaking changes
  event = "VeryLazy", -- load after other plugins, to avoid conflicts
  opts = {
    -- your configuration here
  },
}
```

#### [WhichKey](https://github.com/folke/which-key.nvim) integration

Add this to the plugin spec:

```lua
dependencies = { "folke/which-key.nvim" },
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
  full = true,     -- if set to false, it disables all keybinds except Normal mode c, d, x, y
  which_key_integration = true, -- which-key text objects integration

  experimental = { -- experimental features
    rebind_visual_aiAI = false, -- if set to true, rebinds Visual mode `[aiAI]` keybinds to act like they do in Normal mode,
  }                             -- except that `[ai]` goes to the corresponding end of the selection. however, this
}                               -- makes it so you can only use the default keybinds with `<A-[ai]>`
```

## Usage

### Rebound keybinds

#### Normal mode

- `c` -> `vc`
- `d` -> `vd`
- `x` -> `V`
- `y` -> `vy`

#### Full mode

- `<A-[ft]>`: Extend selection backwards with the key
- `[HJKLWBEFT]`: Extend selection with the lowercase key
- `<A-[ai]>`: Around/inside
- `[hjkl]`: Exit Visual mode first
- `[wbeft]`: Create new selection with key
- `<A-[wbe]>`: Extend selection with the key
- `<A-j>`: Join lines
- `<A-[hl]>`: Extend selection all the way to the corresponding end of the line
- `g[hl]`: Go all the way to the corresponding end of the line
- `g[ge]`: Jump to buffer start/end
- `g[tcb]`: \<key at the same place in `[HML]`>, but exit Visual mode first
- `g[jk]`: Jump to buffer bottom/top
- `G[hl]`: Same as `<A-[hl]>`, currently
- `G[ge]`: Extend selection to buffer start/end
- `G[tcb]`: \<key at the same place in `[HML]`>, but extend selection
- `G[jk]`: Extend selection to buffer bottom/top
- `<A-[oO]>`: Do the same as `[oO]`, except that they move the cursor to the
  same position that it was in before they were executed, or, in Visual mode,
  reselect the previous Visual mode selection

##### Normal mode

- `R`: Replace the character which the cursor is on with yanked content

##### Visual mode

- `[ai]`: If experimental option `rebind_visual_aiAI` is enabled, append/insert
  (to Insert mode) on the corresponding end of the selection
- `[pP]`: Paste at the corresponding end of the selection
- `R`: Replace selection with yanked content
- `<A-;>`: Goes to the other end of the selection
- `[oO]`: Do the same thing as they do in Normal mode, on their corresponding
  end of the selection

## TODO

- [X] Readd `<A-[ai]>` keybinds
  - [X] Readd only the `<A-[ai]>` keybinds
  - [X] Readd key rebind of Visual mode `[aiAI]` keybinds, but as experimental opt-in
- [X] Add `G` keybinds (`g`, but extends selection), as experimental opt-in
  - [X] Make all `g` keybinds leave Visual mode before executing them

## Contributing

Pull requests are welcome. For major changes, please open an issue first
to discuss what you would like to change.

## License

[GPL-3.0](https://choosealicense.com/licenses/gpl-3.0/)
