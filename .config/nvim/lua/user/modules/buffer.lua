local M = {}

--TODO: quando fecho um buffer e tenho terminal aberto ele
--nao leva ao ultimo buffer
---@param bufnr number|nil
M.close = function(bufnr)
  local buffers = vim.fn.getbufinfo { buflisted = 1 }

  ---@diagnostic disable-next-line: redefined-local
  local bufnr = bufnr or vim.api.nvim_get_current_buf()

  local ask_close = function(buf, last_used_buffer)
    vim.ui.select({ 'Yes', 'No' }, {
      prompt = string.format(
        'No write since last change for buffer %d. Force close:',
        bufnr
      ),
    }, function(choice)
      if choice == 'Yes' then
        if last_used_buffer ~= nil then
          vim.cmd.buffer(last_used_buffer.bufnr)
        end
        vim.cmd('bd! ' .. buf)
      else
        return
      end
    end)
  end

  if #buffers == 1 then
    if vim.bo.modified then
      ask_close(bufnr, nil)
      return
    end
    vim.cmd.bd()
    vim.cmd.enew()
    return
  end

  table.sort(buffers, function(a, b)
    return a.lastused > b.lastused
  end)

  -- Index 2 because index 1 is the current buffer
  local last_used_buffer = buffers[2]

  if vim.bo.modified then
    ask_close(bufnr, last_used_buffer)
    return
  end

  vim.cmd.buffer(last_used_buffer.bufnr)
  pcall(vim.cmd.bd, bufnr)
end

M.go_to = function(idx)
  local buffers = vim.fn.getbufinfo { buflisted = 1 }

  table.sort(buffers, function(a, b)
    return a.bufnr <= b.bufnr
  end)

  local target = buffers[idx]

  -- TODO: if current buffer is terminal plugin
  local ok, is_term_plugin = pcall(vim.api.nvim_buf_get_var, 0, 'termplugin')

  if ok and is_term_plugin then
    return
  end

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
