local M = {}

M.close = function()
  local buffers = vim.fn.getbufinfo { buflisted = 1 }

  if #buffers == 1 then
    vim.cmd.bd()
    return
  end

  table.sort(buffers, function(a, b)
    return a.lastused > b.lastused
  end)

  -- Index 2 because index 1 is the current buffer
  local last_used_buffer = buffers[2]

  local bufnr = vim.api.nvim_get_current_buf()

  vim.cmd.buffer(last_used_buffer.bufnr)
  vim.cmd.bd(bufnr)
end

M.go_to = function(idx)
  local buffers = vim.fn.getbufinfo { buflisted = 1 }

  table.sort(buffers, function(a, b)
    return a.bufnr <= b.bufnr
  end)

  local target = buffers[idx]

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
