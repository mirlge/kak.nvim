local M = {}

function M.setup(opts)
  local opts = opts or {}

  if not opts.disable_full then
    local movement = { "h", "j", "k", "l" }
    local word = { "w", "e", "b" }
    local ft = { "f", "t" }
    local around_inside = { "a", "i" }

    for _, key in ipairs(vim.list_extend(movement, word)) do
      local upper_key = string.upper(key)

      vim.keymap.set("n", upper_key, function()
        local count = vim.v.count
        if count < 1 then
          count = 1
        end
        vim.cmd("norm! v" .. count .. key)
      end)
      vim.keymap.set("x", upper_key, function()
        local count = vim.v.count
        if count < 1 then
          count = 1
        end
        vim.cmd("norm! " .. count .. key)
      end)
    end

    for _, key in ipairs(vim.list_extend(movement, around_inside)) do
      local upper_key = string.upper(key)

      vim.keymap.set("x", key, function()
        local count = vim.v.count
        if count < 1 then
          count = 1
        end
        local pre_count = "" .. count - 1 .. key
        if pre_count == "0" .. key then
          pre_count = ""
        end
        vim.cmd.norm(vim.keycode("<Esc>") .. pre_count .. "v" .. key)
      end)
      vim.keymap.set("n", upper_key, function()
        local count = vim.v.count
        if count < 1 then
          count = 1
        end
        vim.cmd("norm! v" .. count .. key)
      end)
    end

    for _, key in ipairs(vim.list_extend(word, ft)) do
      vim.keymap.set("n", key, function()
        local count = vim.v.count
        if count < 1 then
          count = 1
        end
        vim.cmd.norm("v" .. count .. key)
      end)
      vim.keymap.set("x", key, function()
        local count = vim.v.count
        if count < 1 then
          count = 1
        end
        local pre_count = "" .. count - 1 .. key
        if pre_count == "0" .. key then
          pre_count = ""
        end
        vim.cmd("norm! " .. vim.keycode("<Esc>") .. pre_count .. "v" .. key)
      end)
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
        local count = vim.v.count
        if count < 1 then
          count = 1
        end
        vim.cmd("norm! " .. count .. key .. vim.fn.input("v" .. key))
      end)
    end
  end

  for _, key in ipairs({ "d", "c", "y" }) do
    vim.keymap.set({ "n" }, key, "v" .. key)
  end
  vim.keymap.set({ "n", "x" }, "x", "V")
  --vim.keymap.set({ "n", "x" }, "%", "gg<Esc>VG")
end

return M
