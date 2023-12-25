local M = {}

function M.setup(opts)
  local opts = opts or {}

  if not opts.disable_full then
    local movement = { "h", "j", "k", "l" }
    local word = { "w", "e", "b" }
    local ft = { "f", "t" }
    local around_inside = { "a", "i" }

    for _, key in ipairs(vim.tbl_deep_extend(movement, word)) do
      local upper_key = string.upper(key)

      vim.keymap.set("x", upper_key, function()
        vim.cmd("norm! " .. key)
      end)
    end

    for _, key in ipairs(vim.tbl_deep_extend(movement, around_inside)) do
      local upper_key = string.upper(key)

      vim.keymap.set("x", key, "<esc>" .. key)
      vim.keymap.set("n", upper_key, function()
        vim.cmd("norm! v" .. key)
      end)
    end

    for _, key in ipairs(vim.tbl_deep_extend(word, ft)) do
      vim.keymap.set("n", key, "v" .. key)
      vim.keymap.set("x", key, "<esc>v" .. key)
    end

    for _, key in ipairs(around_inside) do
      vim.keymap.set("n", "<A-" .. key .. ">", function()
        vim.cmd("norm! v" .. key .. vim.fn.input("v" .. key))
      end)
      vim.keymap.set("x", "<A-" .. key .. ">", function()
        vim.cmd("norm! " .. key .. vim.fn.input("v" .. key))
      end)
    end
    for _, key in ipairs(ft) do
      local upper_key = string.upper(key)

      vim.keymap.set("x", upper_key, function()
        vim.cmd("norm! " .. key .. vim.fn.input("v" .. key))
      end)
    end
  end

  for _, key in ipairs({ "d", "c", "y" }) do
    vim.keymap.set({ "n" }, key, "v" .. key)
  end
  vim.keymap.set({ "n", "x" }, "x", "V")
  --vim.keymap.set({ "n", "x" }, "%", "gg<esc>VG")
end

return M
