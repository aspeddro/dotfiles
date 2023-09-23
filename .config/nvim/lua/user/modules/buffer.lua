local M = {}

M.close = function()
  local buffers = vim.fn.getbufinfo { buflisted = 1 }

  local bufnr = vim.api.nvim_get_current_buf()

  if #buffers == 1 then
    if vim.bo.modified then
      vim.notify(
        'No write since last change for buffer ' .. bufnr,
        vim.log.levels.WARN
      )
      return
    end
    vim.cmd.bd()
    return
  end

  table.sort(buffers, function(a, b)
    return a.lastused > b.lastused
  end)

  -- Index 2 because index 1 is the current buffer
  local last_used_buffer = buffers[2]

  if vim.bo.modified then
    vim.ui.select({ 'Yes', 'No' }, {
      prompt = string.format(
        'No write since last change for buffer %d. Force close:',
        bufnr
      ),
      -- format_item = function(item)
      --   return "I'd like to choose " .. item
      -- end,
    }, function(choice)
      if choice == 'Yes' then
        vim.cmd.buffer(last_used_buffer.bufnr)
        vim.cmd('bd! ' .. bufnr)
      else
        return
      end
    end)
    return
  end

  vim.cmd.buffer(last_used_buffer.bufnr)
  vim.cmd.bd(bufnr)
end

M.go_to = function(idx)
  local buffers = vim.fn.getbufinfo { buflisted = 1 }

  table.sort(buffers, function(a, b)
    return a.bufnr <= b.bufnr
  end)

  local target = buffers[idx]

  -- TODO: if target is terminal?

  if not target then
    vim.notify('Buffer ' .. idx .. ' not found', vim.log.levels.INFO)
    return
  end

  -- vim.print(target.name)
  vim.cmd.buffer(target.bufnr)
end

M.new = function()
  vim.cmd.enew()
end

return M
