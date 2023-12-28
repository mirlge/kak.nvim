local M = {}

function M.setup(opts)
  local opts = opts or {}

  if opts.full then
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

    for _, key in ipairs(movement) do
      local upper_key = string.upper(key)

      vim.keymap.set("x", key, function()
        local count = vim.v.count
        if count < 1 then
          count = 1
        end

        vim.cmd("norm! " .. vim.keycode("<Esc>") .. count .. key)
      end)
      vim.keymap.set("n", upper_key, function()
        local count = vim.v.count
        if count < 1 then
          count = 1
        end

        vim.cmd("norm! v" .. count .. key)
      end)

      if opts.visual_only then
        vim.keymap.set("x", key, function()
          local count = vim.v.count
          if count < 1 then
            count = 1
          end

          vim.cmd("norm! " .. vim.keycode("<Esc>") .. count .. key .. "v")
        end)
        vim.keymap.set("n", key, function()
          local count = vim.v.count
          if count < 1 then
            count = 1
          end

          vim.cmd("norm! " .. count .. key .. "v")
        end)
        vim.keymap.set("i", "<Esc>", function()
          vim.cmd("norm! " .. vim.keycode("<Esc>") .. "v")
        end, { desc = "Exit Insert mode" })
      end
    end

    for _, key in ipairs(word) do
      vim.keymap.set("n", key, function()
        local count = vim.v.count
        if count < 1 then
          count = 1
        end
        local pre_count = "" .. count - 1 .. key
        if pre_count == "0" .. key then
          pre_count = ""
        end

        vim.cmd("norm! " .. pre_count .. "v" .. key)
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

      local wrapped_key = "<A-" .. key .. ">"
      local upper_key = string.upper(key)
      vim.keymap.set("n", wrapped_key, function()
        local count = vim.v.count
        if count < 1 then
          count = 1
        end
        local pre_count = "" .. count - 1 .. upper_key
        if pre_count == "0" .. upper_key then
          pre_count = ""
        end
        vim.cmd("norm! " .. pre_count .. "v" .. upper_key)
      end)
      vim.keymap.set("x", wrapped_key, function()
        local count = vim.v.count
        if count < 1 then
          count = 1
        end
        local pre_count = "" .. count - 1 .. upper_key
        if pre_count == "0" .. upper_key then
          pre_count = ""
        end
        vim.cmd("norm! " .. vim.keycode("<Esc>") .. pre_count .. "v" .. upper_key)
      end)
    end

    for _, key in ipairs(around_inside) do
      local key_wrapped = "<A-" .. key .. ">"
      vim.keymap.set("n", key_wrapped, function()
        vim.cmd("norm! v" .. key .. vim.fn.getcharstr())
      end)
      vim.keymap.set("x", key_wrapped, function()
        vim.cmd("norm! " .. vim.keycode("<Esc>") .. "v" .. key .. vim.fn.getcharstr())
      end)

      vim.keymap.set("x", key, "<Esc>" .. key)
    end
    for _, key in ipairs(ft) do
      vim.keymap.set("n", key, function()
        local char = vim.fn.getcharstr()

        local count = vim.v.count
        if count < 1 then
          count = 1
        end
        local pre_count = "" .. count - 1 .. key .. char
        if pre_count == "0" .. key .. char then
          pre_count = ""
        end

        vim.cmd("norm! " .. pre_count .. "v" .. key .. char)
      end)
      vim.keymap.set("x", key, function()
        local char = vim.fn.getcharstr()

        local count = vim.v.count
        if count < 1 then
          count = 1
        end
        local pre_count = "" .. count - 1 .. key .. char
        if pre_count == "0" .. key .. char then
          pre_count = ""
        end

        vim.cmd("norm! " .. vim.keycode("<Esc>") .. pre_count .. "v" .. key .. char)
      end)

      local upper_key = string.upper(key)

      vim.keymap.set("n", upper_key, function()
        local char = vim.fn.getcharstr()

        local count = vim.v.count
        if count < 1 then
          count = 1
        end

        vim.cmd("norm! v" .. count .. key .. char)
      end)
      vim.keymap.set("x", upper_key, function()
        local char = vim.fn.getcharstr()

        local count = vim.v.count
        if count < 1 then
          count = 1
        end

        vim.cmd("norm! " .. count .. key .. char)
      end)

      local key_wrapped = "<A-" .. key .. ">"
      vim.keymap.set("n", key_wrapped, function()
        local char = vim.fn.getcharstr()

        local count = vim.v.count
        if count < 1 then
          count = 1
        end

        vim.cmd("norm! v" .. count .. upper_key .. char)
      end)
      vim.keymap.set("x", key_wrapped, function()
        local char = vim.fn.getcharstr()

        local count = vim.v.count
        if count < 1 then
          count = 1
        end

        vim.cmd("norm! " .. count .. upper_key .. char)
      end)
    end

    vim.keymap.set({ "n", "v" }, "<A-j>", function()
      local count = vim.v.count
      if count < 1 then
        count = 1
      end

      vim.cmd("norm! " .. count .. "J")
    end, { desc = "Join lines" })

    if opts.visual_only then
      vim.keymap.set("x", "<Esc>", function()
        vim.cmd("norm! " .. vim.keycode("<Esc>") .. "v")
      end)
      vim.keymap.set("x", "<A-Esc>", function()
        vim.cmd("norm! " .. vim.keycode("<Esc>"))
      end)

      for _, key in ipairs({ "d", "c", "y" }) do
        vim.keymap.set("x", key, function()
          vim.cmd("norm! " .. key .. "v")
        end)
      end
    end
  end

  for _, key in ipairs({ "d", "c", "y" }) do
    vim.keymap.set({ "n" }, key, "v" .. key)
  end
  vim.keymap.set({ "n", "x" }, "x", "V")
  --vim.keymap.set({ "n", "x" }, "%", "gg<Esc>VG")
end

return M
