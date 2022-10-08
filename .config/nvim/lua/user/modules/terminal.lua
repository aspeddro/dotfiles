--TODOS:
--1. Check if a terminal is in watch mode
--2. If more than one terminal is found then select one to run codelens
--3. Save position to restore using TermToggle?

local M = {}

local DIRECTIONS = { 'right', 'bottom' }

---@return table
local terminals = function()
  return vim.tbl_filter(function(buffer)
    return buffer.variables and buffer.variables.terminal_job_id
  end, vim.fn.getbufinfo())
end

---@param buf? number
---@return boolean
local is_term = function(buf)
  local ok, is_term_plugin =
    pcall(vim.api.nvim_buf_get_var, buf or 0, 'termplugin')
  return ok and is_term_plugin
end

---@param dir string
---@return string[]
M.get_direction = function(dir)
  local choice = dir == 'right' and { 'vsplit' } or { 'split' }

  if not is_term(vim.api.nvim_get_current_buf()) then
    local width = math.ceil(vim.o.columns * 0.4)
    local height = math.ceil(vim.o.lines * 0.3)
    vim.list_extend(
      choice,
      dir == 'right' and { 'vertical resize ' .. width }
        or { 'resize ' .. height }
    )
  end

  return choice
end

local open = function(opts, buffer)
  vim.cmd(table.concat(M.get_direction(opts.direction or 'bottom'), ' | '))

  local winr = vim.api.nvim_get_current_win()

  vim.api.nvim_win_set_buf(winr, buffer.bufnr)
  vim.cmd.startinsert()
end

local close = function(buffer)
  if vim.api.nvim_win_is_valid(buffer.windows[1]) then
    vim.api.nvim_win_close(buffer.windows[1], true)
  end
end

M.toggle = function(buffer)
  if buffer.hidden == 0 then
    close(buffer)
  else
    open({ direction = 'bottom' }, buffer)
  end
end

M.new = function(opts)
  vim.cmd(
    table.concat(
      M.get_direction((opts and opts.direction) and opts.direction or 'bottom'),
      ' | '
    )
  )
  local winr = vim.api.nvim_get_current_win()
  local bufnr = vim.api.nvim_create_buf(false, false)

  --NOTE: To identify terminal created by this module
  vim.api.nvim_buf_set_var(bufnr, 'termplugin', true)

  vim.api.nvim_win_set_buf(winr, bufnr)

  local job_id = vim.fn.termopen(vim.o.shell, {
    cwd = vim.loop.cwd(),
    on_exit = function()
      vim.api.nvim_buf_delete(bufnr, { force = true })
    end,
  })

  vim.opt_local.number = false
  vim.opt_local.relativenumber = false

  vim.cmd.startinsert()

  return job_id
end

M.send = function(jobid, command)
  vim.api.nvim_chan_send(jobid, command .. '\n')
end

local toggles = function(opts)
  local terms = terminals()

  if #terms == 0 then
    return M.new(opts)
  end

  if #terms == 1 then
    return M.toggle(terms[1])
  end

  for _, term in ipairs(terms) do
    M.toggle(term)
  end
end

vim.api.nvim_create_user_command('Term', function(param)
  M.new { direction = param.args }
end, {
  nargs = '*',
  complete = function()
    return DIRECTIONS
  end,
})

vim.api.nvim_create_user_command('TermToggle', function(param)
  toggles { direction = param.args }
end, {
  nargs = '*',
  -- complete = function()
  --   return DIRECTIONS
  -- end,
})

local id_term_plugin_enter = vim.api.nvim_create_augroup('TermEnter', { clear = true })

vim.api.nvim_create_autocmd('BufEnter', {
  group = id_term_plugin_enter,
  callback = function(args)
    if is_term(args.buf) then
      vim.cmd.startinsert()
    end
  end,
})

vim.keymap.set({ 'n', 't' }, '<a-t>', function()
  toggles { direction = 'bottom' }
end)

return M
