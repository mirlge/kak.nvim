local M = {
  keymap = {
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

function M.keymap.set(key, resulting_key, opts)
  local opts = vim.tbl_extend("force", M.keymap.defaults, opts or {})
  opts.second_resulting_key = opts.second_resulting_key or resulting_key

  local rhs = function()
    local char = ""
    if opts.getcharstr then
      char = vim.fn.getcharstr() or ""
    end
    local resulting_resulting_key = resulting_key .. char

    local count = ""
    if opts.countable then
      if vim.v.count >= 1 then
        count = "" .. vim.v.count
      end
    end
    local pre_count = count
    if opts.pre_count then
      local count = vim.v.count
      pre_count = "" .. count - 1 .. resulting_resulting_key
      if count <= 1 then
        pre_count = ""
      else
        resulting_resulting_key = opts.second_resulting_key .. char
      end
    end

    vim.cmd("norm! " .. opts.post_first_str_extra_str .. pre_count .. opts.pre_key_str .. resulting_resulting_key)
  end

  vim.keymap.set(opts.mode, key, rhs, opts.opts)
end

function M.keycode(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

return M
