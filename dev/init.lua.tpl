local path = vim.fn.expand("<sfile>:h") .. "/.."
vim.cmd.cd(path)
vim.opt.runtimepath:append(path)

vim.opt.number = true
vim.opt.relativenumber = true

require("kak").setup({
  experimental = {
    rebind_visual_aiAI = true,
  },
})
-- vim: ft=lua
