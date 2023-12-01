local M = {}

function M.setup(opts)
  local opts = opts or {}

  require("kak.keybinds").setup(opts)
end

return M
