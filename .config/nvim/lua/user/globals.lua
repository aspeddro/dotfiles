P = function(v)
  vim.print(v)
end

R = function(...)
  return require('plenary.reload').reload_module(...)
end

---Print table to buffer
PB = function(v)
  if type(v) ~= 'table' then
    return P(v)
  else
    local bufnr = vim.api.nvim_create_buf(false, false)
    vim.api.nvim_buf_set_lines(
      bufnr,
      0,
      -1,
      true,
      vim.split(vim.inspect(v), '\n', { plain = true })
    )
    vim.cmd.vsplit()
    vim.api.nvim_win_set_buf(vim.api.nvim_get_current_win(), bufnr)
  end
end
