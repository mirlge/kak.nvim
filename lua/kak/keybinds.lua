local M = {}

local utils = require("kak.utils")

function M.setup(opts)
  local opts = opts or {}

  if opts.full then
    local movement = { "h", "j", "k", "l" }
    local word = { "w", "e", "b" }
    local ft = { "f", "t" }
    local around_inside = { "a", "i" }
    local window_positions = { "t", "c", "b" }

    for _, key in ipairs(vim.list_extend(movement, word)) do
      local upper_key = string.upper(key)

      utils.keybind.set(upper_key, key, { post_first_str_extra_str = "v" })
      utils.keybind.set(upper_key, key, { mode = "x" })
    end

    for _, key in ipairs(movement) do
      local upper_key = string.upper(key)

      utils.keybind.set(key, key, { mode = "x", post_first_str_extra_str = vim.keycode("<Esc>") })
      utils.keybind.set(upper_key, key, { post_first_str_extra_str = "v" })

      if opts.visual_only then
        utils.keybind.set(key, key .. "v", { mode = "x", post_first_str_extra_str = vim.keycode("<Esc>") })
        utils.keybind.set(key, key .. "v")
        --utils.keybind.set("<Esc>", vim.keycode("<Esc>") .. "v" , { mode = "i", opts = { desc = "Exit Insert mode" }, countable = false })
      end
    end

    for _, key in ipairs(word) do
      utils.keybind.set(key, key, { pre_count = true, pre_key_str = "v" })
      utils.keybind.set(
        key,
        key,
        { mode = "x", pre_count = true, post_first_str_extra_str = vim.keycode("<Esc>"), pre_key_str = "v" }
      )

      local wrapped_key = "<A-" .. key .. ">"
      local upper_key = string.upper(key)
      utils.keybind.set(wrapped_key, upper_key, { pre_count = true, pre_key_str = "v" })
      utils.keybind.set(
        wrapped_key,
        upper_key,
        { mode = "x", post_first_str_extra_str = vim.keycode("<Esc>"), pre_count = true, pre_key_str = "v" }
      )
    end

    for _, key in ipairs(around_inside) do
      local key_wrapped = "<A-" .. key .. ">"
      utils.keybind.set(
        key_wrapped,
        key,
        { post_first_str_extra_str = "v", countable = false, getcharstr = true }
      )
      utils.keybind.set(key_wrapped, key, {
        mode = "x",
        countable = false,
        post_first_str_extra_str = vim.keycode("<Esc>") .. "v",
        getcharstr = true,
      })

      utils.keybind.set(key, vim.keycode("<Esc>") .. key, { countable = false, mode = "x" })

      local upper_key = string.upper(key)
      utils.keybind.set(upper_key, vim.keycode("<Esc>") .. upper_key, { mode = "x", countable = false })
    end
    for _, key in ipairs(ft) do
      utils.keybind.set(key, key, { pre_count = true, pre_key_str = "v", getcharstr = true })
      utils.keybind.set(key, key, {
        post_first_str_extra_str = vim.keycode("<Esc>"),
        pre_key_str = "v",
        pre_count = true,
        mode = "x",
        getcharstr = true,
      })

      local upper_key = string.upper(key)

      utils.keybind.set(upper_key, key, { post_first_str_extra_str = "v", getcharstr = true })
      utils.keybind.set(upper_key, key, { mode = "x", getcharstr = true })

      local key_wrapped = "<A-" .. key .. ">"
      utils.keybind.set(key_wrapped, upper_key, { post_first_str_extra_str = "v", getcharstr = true })
      utils.keybind.set(key_wrapped, upper_key, { mode = "x", getcharstr = true })
    end

    utils.keybind.set("<A-h>", "v0", { countable = false })
    utils.keybind.set("<A-h>", "0", { mode = "x", countable = false })
    utils.keybind.set("<A-l>", "v$", { countable = false })
    utils.keybind.set("<A-l>", "$", { mode = "x", countable = false })
    utils.keybind.set("gh", "0", { countable = false })
    utils.keybind.set("gh", vim.keycode("<Esc>") .. "0", { mode = "x", countable = false })
    utils.keybind.set("gl", "$", { countable = false })
    utils.keybind.set("gl", vim.keycode("<Esc>") .. "$", { mode = "x", countable = false })
    utils.keybind.set("ge", "G$", { countable = false })
    utils.keybind.set("ge", vim.keycode("<Esc>") .. "G$", { mode = "x", countable = false })
    utils.keybind.set("gj", "G", { countable = false })
    utils.keybind.set("gj", vim.keycode("<Esc>") .. "G", { mode = "x", countable = false })
    utils.keybind.set("gg", "gg0", { countable = false })
    utils.keybind.set("gg", vim.keycode("<Esc>") .. "gg0", { mode = "x", countable = false })
    utils.keybind.set("gk", "gg", { countable = false })
    utils.keybind.set("gk", vim.keycode("<Esc>") .. "gg", { mode = "x", countable = false })

    utils.keybind.set("<A-j>", "J", { mode = { "n", "v" }, opts = { desc = "Join lines" } })

    utils.keybind.set("gt", "H", { countable = false })
    utils.keybind.set("gc", "M", { countable = false })
    utils.keybind.set("gb", "L", { countable = false })

    if opts.visual_only then
      utils.keybind.set("<Esc>", vim.keycode("<Esc>") .. "v", { mode = "x", countable = false })
      utils.keybind.set("<A-Esc>", vim.keycode("<Esc>"), { mode = "x", countable = false })

      for _, key in ipairs({ "d", "c", "y" }) do
        utils.keybind.set(key, key .. "v", { mode = "x", countable = false })
      end
    end
  end

  for _, key in ipairs({ "d", "c", "y" }) do
    vim.keymap.set({ "n" }, key, "v" .. key)
  end
  vim.keymap.set({ "n", "x" }, "x", "V")
  --vim.keymap.set({ "n", "x" }, "%", "gg<Esc>VG")
end

return M
