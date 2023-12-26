local M = {}

local defaults = require("kak.defaults")

function M.setup(opts)
  local opts = vim.tbl_deep_extend("force", defaults, opts or {})

  require("kak.keybinds").setup(opts)
end

return M
