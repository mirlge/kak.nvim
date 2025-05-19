local utils = require("kak.utils")
local wk = require("which-key")

local wk_add_base = { mode = { "n", "x" } }
local function wk_base_add_key(key)
  wk.add(vim.list_extend(wk_add_base, { key }))
end

local function text_objects()
  local wk_text_objects = require("which-key.plugins.presets").text_objects
  table.insert(wk_text_objects.mode, "n")

  for _, keybind in ipairs(wk_text_objects) do
    local keybind_str = keybind[1]
    if string.len(keybind_str) == 1 then
      keybind[1] = "<A-" .. keybind_str .. ">"
    else
      keybind[1] = "<A-" .. string.sub(keybind_str, 1, 1) .. ">" .. string.sub(keybind_str, 2)
    end
  end
end

local function goto_extend()
  local wk = require("which-key")
  local wk_motions = require("which-key.plugins.presets").motions
  local idx = 0
  for i, val in ipairs(wk_motions) do
    if val[1] == "G" then
      idx = i
    end
  end
  wk_motions[idx].desc = nil
  wk_motions[idx].group = "Goto extend"
  wk_motions[idx][2] = function()
    require("which-key").show({ keys = "G" })
  end

  local keys = {
    { "gg", desc = "Go to buffer start" },
    { "ge", desc = "Go to buffer end" },
    { "gj", desc = "Go to first line of buffer" },
    { "gk", desc = "Go to last line of buffer" },
    { "gt", desc = "Go to top of view" },
    { "gc", desc = "Go to center of view" },
    { "gb", desc = "Go to bottom of view" },
    { "gh", desc = "Go all the way to the left of the current line" },
    { "gl", desc = "Go all the way to the right of the current line" },
  }
  for _, key in ipairs(keys) do
    wk_base_add_key(key)
    local key_extend = vim.tbl_extend("keep", key, {})
    local key_extend_str = utils.keymap.presets.goto_extend.Lhs_key_func(key[1])
    key_extend[1] = key_extend_str
    wk_base_add_key(key_extend)
    --[[table.insert(wk_motions, { key })
    table.insert(wk_motions, { utils.keymap.presets.goto_extend.Lhs_key_func(key) })]]
  end
end

text_objects()
goto_extend()
