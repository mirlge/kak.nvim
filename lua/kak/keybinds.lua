local movement_ai = { "h", "j", "k", "l", "i", "a" }

for _, key in ipairs(movement_ai) do
  vim.keymap.set({ "x" }, key, "<esc>" .. key)
end

local word_fFtT = { "w", "e", "b", "W", "E", "B", "f", "F", "t", "T" }

for _, keytbl in ipairs({ movement_ai, word_fFtT }) do
  for _, key in ipairs(keytbl) do
    vim.keymap.set({ "n", "x" }, "<A-" .. key .. ">", function() vim.cmd("norm! v" .. key) end)
  end
end

for _, key in ipairs(word_fFtT) do
  vim.keymap.set({ "n", "x" }, key, "<esc>v" .. key)
end

--vim.keymap.set({ "n", "x" }, "%", "gg<esc>VG")
