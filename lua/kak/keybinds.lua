local M = {}

local utils = require("kak.utils")

function M.setup(opts)
  local opts = opts or {}

  if opts.full then
    local movement = { "h", "j", "k", "l" }
    local word = { "w", "e", "b" }
    local ft = { "f", "t" }
    local around_inside = { "a", "i" }

    for _, key in ipairs(vim.list_extend(movement, word)) do
      local upper_key = string.upper(key)

      utils.keymap.set(upper_key, key, { post_first_str_extra_str = "v" })
      utils.keymap.set(upper_key, key, { mode = "x" })
    end

    for _, key in ipairs(movement) do
      local upper_key = string.upper(key)

      utils.keymap.set(key, key, { mode = "x", post_first_str_extra_str = vim.keycode("<Esc>") })
      utils.keymap.set(upper_key, key, { post_first_str_extra_str = "v" })
    end

    for _, key in ipairs(word) do
      utils.keymap.set(key, key, { pre_count = true, pre_key_str = "v" })
      utils.keymap.set(
        key,
        key,
        { mode = "x", pre_count = true, post_first_str_extra_str = vim.keycode("<Esc>"), pre_key_str = "v" }
      )

      local wrapped_key = "<A-" .. key .. ">"
      local upper_key = string.upper(key)
      utils.keymap.set(wrapped_key, upper_key, { pre_count = true, pre_key_str = "v" })
      utils.keymap.set(
        wrapped_key,
        upper_key,
        { mode = "x", post_first_str_extra_str = vim.keycode("<Esc>"), pre_count = true, pre_key_str = "v" }
      )
    end

    for _, key in ipairs(around_inside) do
      local key_wrapped = "<A-" .. key .. ">"
      utils.keymap.set(key_wrapped, key, { post_first_str_extra_str = "v", countable = false, getcharstr = true })
      utils.keymap.set(key_wrapped, key, {
        mode = "x",
        countable = false,
        post_first_str_extra_str = vim.keycode("<Esc>") .. "v",
        getcharstr = true,
      })

      vim.keymap.set("x", key, "<Esc>" .. key)

      local upper_key = string.upper(key)
      vim.keymap.set("x", upper_key, "<Esc>" .. upper_key)
    end
    for _, key in ipairs(ft) do
      utils.keymap.set(key, key, { pre_count = true, pre_key_str = "v", getcharstr = true })
      utils.keymap.set(key, key, {
        post_first_str_extra_str = vim.keycode("<Esc>"),
        pre_key_str = "v",
        pre_count = true,
        mode = "x",
        getcharstr = true,
      })

      local upper_key = string.upper(key)

      utils.keymap.set(upper_key, key, { post_first_str_extra_str = "v", getcharstr = true })
      utils.keymap.set(upper_key, key, { mode = "x", getcharstr = true })

      local key_wrapped = "<A-" .. key .. ">"
      utils.keymap.set(key_wrapped, upper_key, { post_first_str_extra_str = "v", getcharstr = true })
      utils.keymap.set(key_wrapped, upper_key, { mode = "x", getcharstr = true })
    end

    utils.keymap.set("<A-h>", "v0", { countable = false })
    utils.keymap.set("<A-h>", "0", { mode = "x", countable = false })
    utils.keymap.set("<A-l>", "v$", { countable = false })
    utils.keymap.set("<A-l>", "$", { mode = "x", countable = false })
    utils.keymap.set("gh", "0", { countable = false })
    utils.keymap.set("gh", vim.keycode("<Esc>") .. "0", { mode = "x", countable = false })
    utils.keymap.set("gl", "$", { countable = false })
    utils.keymap.set("gl", vim.keycode("<Esc>") .. "$", { mode = "x", countable = false })
    utils.keymap.set("ge", "G$", { countable = false })
    utils.keymap.set("ge", vim.keycode("<Esc>") .. "G$", { mode = "x", countable = false })
    utils.keymap.set("gj", "G", { countable = false })
    utils.keymap.set("gj", vim.keycode("<Esc>") .. "G", { mode = "x", countable = false })
    utils.keymap.set("gg", "gg0", { countable = false })
    utils.keymap.set("gg", vim.keycode("<Esc>") .. "gg0", { mode = "x", countable = false })
    utils.keymap.set("gk", "gg", { countable = false })
    utils.keymap.set("gk", vim.keycode("<Esc>") .. "gg", { mode = "x", countable = false })

    utils.keymap.set("<A-j>", "J", { mode = { "n", "v" }, opts = { desc = "Join lines" } })

    utils.keymap.set("gt", "H", { countable = false })
    utils.keymap.set("gc", "M", { countable = false })
    utils.keymap.set("gb", "L", { countable = false })

    utils.keymap.set(
      "p",
      "p",
      { mode = "x", post_first_str_extra_str = vim.keycode("<Esc>") .. "`>", pre_count = true }
    )
    utils.keymap.set("R", "p", { mode = "x", pre_count = true })
    utils.keymap.set("P", "P", {
      mode = "x",
      post_first_str_extra_str = vim.keycode("<Esc>") .. "`<",
      pre_count = true,
      second_resulting_key = "p",
    })
    utils.keymap.set("R", "vp", { mode = "x" })
  end

  for _, key in ipairs({ "d", "c", "y" }) do
    vim.keymap.set({ "n" }, key, "v" .. key)
  end
  vim.keymap.set({ "n", "x" }, "x", "V")
  --vim.keymap.set({ "n", "x" }, "%", "gg<Esc>VG")
end

return M
