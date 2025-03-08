local M = {
  keymap = {
    defaults = {
      countable = true,   -- if set to false, it doesn't use the count that you give to the keybind
      opts = {},          -- same as the last argument to vim.keymap.set() function
      getcharstr = false, -- append the next inputted key (the result of vim.fn.getcharstr()) to the end of the resulting key
      presets = { "reselect" },
    },
  },
  _keymap = {
    defaults = {
      countable = true,
      pre_count = false,
      mode = "n",
      opts = {},
      post_first_str_extra_str = "",
      pre_key_str = "",
      getcharstr = false,
    },
  },
}

---Sets a keybind using one or more keys, a preset and some more options
---@param keys string | (table | string)[] The base key(s) to use. If it's a table, all the keys inside that table will be used, and the tables inside it will be treated as { input_key, resulting_key } and therefore not perform Lhs_key_func or Rhs_key_func of the chosen preset on those keys.
---@param opts { countable: boolean?, opts: table?, getcharstr: boolean?, presets: table? }?
function M.keymap.set(keys, opts)
  local opts_new = vim.tbl_extend("force", M.keymap.defaults, opts or {})
  for _, preset in ipairs(opts_new.presets) do
    local keymap_preset = vim.tbl_extend("force", M.keymap.presets.Defaults, M.keymap.presets[preset])
    for _, mode in ipairs(keymap_preset.Modes) do
      local preset_opts = vim.tbl_extend("force", keymap_preset, keymap_preset[mode])
      local keys = keys
      -- if `keys` isn't a table, wrap it in a table
      if type(keys) ~= "table" then
        keys = { keys }
      end
      for _, key in ipairs(keys) do
        preset_opts = vim.tbl_extend("force", preset_opts, preset_opts.Extra_opts_func(key))
        if opts.getcharstr ~= nil then
          preset_opts.getcharstr = opts_new.getcharstr
        end
        if opts.countable ~= nil then
          preset_opts.countable = opts_new.countable
        end

        local lhs_key
        local rhs_key
        -- if `key` is a table, don't perform Lhs_key_func and Rhs_key_func
        -- on the 2 keys
        if type(key) == "table" then
          if preset_opts.Lhs_key_func_force then
            lhs_key = preset_opts.Lhs_key_func(key[1])
          else
            lhs_key = key[1]
          end
          if preset_opts.Rhs_key_func_force then
            rhs_key = preset_opts.Rhs_key_func(key[2])
          else
            rhs_key = key[2]
          end
        else
          lhs_key = preset_opts.Lhs_key_func(key)
          rhs_key = preset_opts.Rhs_key_func(key)
        end
        M._keymap.set(lhs_key, rhs_key, preset_opts)
      end
    end
  end
end

function M._keymap.set(key, resulting_key, opts)
  local opts = vim.tbl_extend("force", M._keymap.defaults, opts or {})
  opts.second_resulting_key = opts.second_resulting_key or resulting_key

  local rhs = function()
    local char = ""
    if opts.getcharstr then
      char = vim.fn.getcharstr() or ""
    end
    local resulting_resulting_key = resulting_key .. char

    local count = ""
    if opts.countable then
      if vim.v.count >= 1 then
        count = "" .. vim.v.count
      end
    end
    local pre_count = count
    if opts.pre_count then
      local count = vim.v.count
      pre_count = "" .. count - 1 .. resulting_resulting_key
      if count <= 1 then
        pre_count = ""
      else
        resulting_resulting_key = opts.second_resulting_key .. char
      end
    end

    vim.cmd("norm! " .. opts.post_first_str_extra_str .. pre_count .. opts.pre_key_str .. resulting_resulting_key)
  end

  vim.keymap.set(opts.mode, key, rhs, opts.opts)
end

function M.keycode(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

---Wraps the specified key with a modifier
---@param key string
---@param mod string? The modifier ("A" (ALT) by default)
---@return string
function M.wrap_key(key, mod)
  local mod = mod or "A" -- "A" for ALT
  return "<" .. mod .. "-" .. key .. ">"
end

M.keymap.presets = {
  Defaults = {
    Modes = { "Normal_mode", "Visual_mode" },
    Lhs_key_func = function(key) return key end,
    Rhs_key_func = function(key) return key end,
    Lhs_key_func_force = false, -- makes `[LR]hs_key_func` be applied to
    Rhs_key_func_force = false, -- lhs_key even if the specified key is a table
    Normal_mode = { mode = "n" },
    Visual_mode = { mode = "x" },
    Extra_opts_func = function(key) return {} end,
  },

  -- exit Visual mode and then reenter Visual mode before performing the movement
  reselect = {
    pre_count = true,
    pre_key_str = "v",
    Visual_mode = {
      mode = "x",
      post_first_str_extra_str = M.keycode("<Esc>"),
    },
  },
  -- exit Visual mode before performing the movement
  noselect = {
    Visual_mode = {
      mode = "x",
      post_first_str_extra_str = M.keycode("<Esc>"),
    },
  },
  -- extend the selection when entering the uppercase key
  extend = {
    Lhs_key_func = string.upper,
    Normal_mode = {
      mode = "n",
      post_first_str_extra_str = "v",
    },
  },
  -- exit Visual mode, and if the key contains an uppercase letter, go to the
  -- left end of the selection. otherwise, go to the right end of the selection
  put = {
    Modes = { "Visual_mode" },
    Visual_mode = {
      mode = "x",
      Extra_opts_func = function(key)
        local post_first_str_extra_str_base = M.keycode("<Esc>") .. "`"
        if string.match(key, "%u") then
          return {
            post_first_str_extra_str = post_first_str_extra_str_base .. "<",
            second_resulting_key = "p",
          }
        end
        return { post_first_str_extra_str = post_first_str_extra_str_base .. ">" }
      end,
    },
  },
  -- actually called for example *a* word and *inner* word, but
  -- "around_inside" is more understandable
  around_inside = {
    Lhs_key_func = M.wrap_key,
    getcharstr = true,
    countable = false,
    Normal_mode = {
      mode = "n",
      Rhs_key_func = function(key) return "v" .. key end,
    },
    Visual_mode = {
      mode = "x",
      Rhs_key_func = function(key) return M.keycode("<Esc>") .. "v" .. key end,
    },
  },
  -- rhs_key works like normal
  none = {},
}

---Create a new preset based on an already existing preset
---@param parent_preset string The preset to inherit from
---@param new_name string Name of the new preset
---@param overrides table Overrides of the parent preset
function M.keymap.presets:Extend(parent_preset, new_name, overrides)
  self[new_name] = vim.tbl_extend("force", self[parent_preset], overrides)
end

-- reselect/extend presets, but the alternate (backwards for f/t and for
-- example WORD instead of word for w) and the key the user inputs is ALT + the key
local alternate_override = {
  Lhs_key_func = M.wrap_key,
  Rhs_key_func = string.upper,
}
M.keymap.presets:Extend("reselect", "alternate", alternate_override)
M.keymap.presets:Extend("extend", "alternate_extend", alternate_override)

M.keymap.presets:Extend("extend", "goto_extend", {
  Lhs_key_func_force = true,
  Lhs_key_func = function(key) return string.gsub(key, "^%l", string.upper) end,
})


return M
