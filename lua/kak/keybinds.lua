for _, key in ipairs({ "h", "j", "k", "l", "i", "a" }) do
  vim.keymap.set({ "x" }, key, "<esc>" .. key)
end

local word_fFtT = { "w", "e", "b", "W", "E", "B", "f", "F", "t", "T" }

for _, key in ipairs({ "h", "j", "k", "l", "i", "a" }) do
  vim.keymap.set({ "x" }, "<A-" .. key .. ">", function() vim.cmd("norm! " .. key) end)
  vim.keymap.set({ "n" }, "<A-" .. key .. ">", function() vim.cmd("norm! v" .. key) end)
end

for _, key in ipairs(word_fFtT) do
  vim.keymap.set({ "n", "x" }, key, "<esc>v" .. key)
end

--vim.keymap.set({ "n", "x" }, "%", "gg<esc>VG")
