local M = {}

function M.setup(opts)
  local opts = opts or {}

  if not opts.disable_full then
    local movement_ai = { "h", "j", "k", "l", "i", "a" }
    local word_fFtT = { "w", "e", "b", "W", "E", "B", "ge", "gE", "f", "F", "t", "T" }

    for _, keytbl in ipairs({ movement_ai, word_fFtT }) do
      for _, key in ipairs(keytbl) do
        vim.keymap.set("x", "<A-" .. key .. ">", function()
          vim.cmd("norm! " .. key)
        end)
      end
    end

    for _, key in ipairs(movement_ai) do
      vim.keymap.set("x", key, "<esc>" .. key)
      vim.keymap.set("n", "<A-" .. key .. ">", function()
        vim.cmd("norm! v" .. key)
      end)
    end

    for _, key in ipairs(word_fFtT) do
      vim.keymap.set({ "n", "x" }, key, "<esc>v" .. key)
    end
  end

  for _, key in ipairs({ "d", "c", "y" }) do
    vim.keymap.set({ "n" }, key, "v" .. key)
  end
  vim.keymap.set({ "n", "x" }, "x", "V")
  --vim.keymap.set({ "n", "x" }, "%", "gg<esc>VG")
end

return M
