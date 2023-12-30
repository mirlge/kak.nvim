local M = {
  keybind = {
    defaults = {
      countable = true,
      pre_count = false,
      mode = "n",
      opts = {},
      post_first_str_extra_str = "",
      pre_key_str = "",
      getcharstr = false,
    },
  },
}

function M.keybind.set(key, resulting_key, opts)
  local opts = vim.tbl_extend("force", M.keybind.defaults, opts or {})

  local rhs = function()
    local char = ""
    if opts.getcharstr then
      char = vim.fn.getcharstr() or ""
    end
    local resulting_resulting_key = resulting_key .. char

    local count = 1
    if opts.countable then
      count = vim.v.count
      if count < 1 then
        count = 1
      end
    end
    local pre_count = count
    if opts.pre_count then
      pre_count = "" .. count - 1 .. resulting_key
      if pre_count == "0" .. resulting_key then
        pre_count = ""
      end
    end

    vim.cmd("norm! " .. opts.post_first_str_extra_str .. pre_count .. opts.pre_key_str .. resulting_resulting_key)
  end

  vim.keymap.set(opts.mode, key, rhs, opts.opts)
end

return M
