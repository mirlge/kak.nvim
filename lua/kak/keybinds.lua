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
        --vim.keymap.set("i", "<Esc>", function()
        --  vim.cmd("norm! " .. vim.keycode("<Esc>") .. "v")
        --end, { desc = "Exit Insert mode" })
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
      vim.keymap.set("n", key_wrapped, function()
        vim.cmd("norm! v" .. key .. vim.fn.getcharstr())
      end)
      vim.keymap.set("x", key_wrapped, function()
        vim.cmd("norm! " .. vim.keycode("<Esc>") .. "v" .. key .. vim.fn.getcharstr())
      end)

      vim.keymap.set("x", key, "<Esc>" .. key)

      local upper_key = string.upper(key)
      vim.keymap.set("x", upper_key, "<Esc>" .. upper_key)
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

    vim.keymap.set("n", "<A-h>", function()
      vim.cmd("norm! v0")
    end)
    vim.keymap.set("x", "<A-h>", function()
      vim.cmd("norm! 0")
    end)
    vim.keymap.set("n", "<A-l>", function()
      vim.cmd("norm! v$")
    end)
    vim.keymap.set("x", "<A-l>", function()
      vim.cmd("norm! $")
    end)
    vim.keymap.set("n", "gh", function()
      vim.cmd("norm! 0")
    end)
    vim.keymap.set("x", "gh", function()
      vim.cmd("norm! " .. vim.keycode("<Esc>") .. "0")
    end)
    vim.keymap.set("n", "gl", function()
      vim.cmd("norm! $")
    end)
    vim.keymap.set("x", "gl", function()
      vim.cmd("norm! " .. vim.keycode("<Esc>") .. "$")
    end)

    utils.keybind.set("<A-j>", "J", { mode = { "n", "v" }, opts = { desc = "Join lines" } })

    if opts.visual_only then
      vim.keymap.set("x", "<Esc>", function()
        vim.cmd("norm! " .. vim.keycode("<Esc>") .. "v")
      end)
      vim.keymap.set("x", "<A-Esc>", function()
        vim.cmd("norm! " .. vim.keycode("<Esc>"))
      end)

      for _, key in ipairs({ "d", "c", "y" }) do
        vim.keymap.set("x", key, function()
          vim.cmd("norm! " .. key .. "v")
        end)
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
