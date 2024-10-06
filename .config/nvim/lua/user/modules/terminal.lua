--TODO:
--0. Save position
--1. If more than one terminal is found then select one to run codelens
--2. Save position to restore using TermToggle?
-- local buffer_manager = require("user.modules.buffer")
local M = {}

local DIRECTIONS = { 'right', 'bottom' }

---@return table
local terminals = function()
  return vim.tbl_filter(function(buffer)
    --TODO: see h depreacted use jobpid
    return buffer.variables and buffer.variables.term_plugin
  end, vim.fn.getbufinfo())
end

---@param buf? number
---@return boolean
local is_term_plugin_buf = function(buf)
  local ok, is_term_plugin =
    pcall(vim.api.nvim_buf_get_var, buf or 0, 'term_plugin')
  return ok and is_term_plugin
end

---@param dir string
---@return string[]
M.get_direction = function(dir)
  local choice = dir == 'right' and { 'vsplit' } or { 'split' }

  if not is_term_plugin_buf(vim.api.nvim_get_current_buf()) then
    local width = math.ceil(vim.o.columns * 0.35)
    local height = math.ceil(vim.o.lines * 0.25)
    vim.list_extend(
      choice,
      dir == 'right' and { 'vertical resize ' .. width }
        or { 'resize ' .. height }
    )
  end

  return choice
end

local open = function(buffer, opts)
  vim.cmd(
    table.concat(M.get_direction(opts and opts.direction or 'bottom'), ' | ')
  )

  local winr = vim.api.nvim_get_current_win()

  vim.api.nvim_win_set_buf(winr, buffer.bufnr)
  vim.cmd.startinsert()
end

local close = function(buffer)
  if vim.api.nvim_win_is_valid(buffer.windows[1]) then
    vim.api.nvim_win_close(buffer.windows[1], true)
  end
end

M.toggle = function(buffer, opts)
  if buffer.hidden == 0 then
    close(buffer)
  else
    open(buffer, opts)
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
  vim.api.nvim_buf_set_var(bufnr, 'term_plugin', true)
  vim.api.nvim_set_option_value('filetype', 'term', { buf = bufnr })

  vim.api.nvim_win_set_buf(winr, bufnr)
  vim.api.nvim_set_option_value('winfixbuf', true, { win = winr })

  local job_id = vim.fn.termopen(vim.o.shell, {
    cwd = vim.uv.cwd(),
    on_exit = function()
      if vim.api.nvim_buf_is_valid(bufnr) then
        vim.api.nvim_buf_delete(bufnr, { force = true })
      end
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

  if vim.tbl_isempty(terms) then
    return M.new(opts)
  end

  if #terms == 1 then
    return M.toggle(terms[1], opts)
  end

  for index, term in ipairs(terms) do
    M.toggle(term, index == 1 and { direction = 'bottom' } or opts)
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

-- vim.api.nvim_create_user_command('TermToggle', function(param)
--   toggles { direction = param.args }
-- end, {
--   nargs = '*',
--   complete = function()
--     return DIRECTIONS
--   end,
-- })

vim.keymap.set({ 'n', 't' }, '<a-t>', function()
  local terms = terminals()
  toggles {
    direction = (vim.tbl_isempty(terms) or #terms == 1) and 'bottom' or 'right',
  }
end, { desc = 'Toggle Term' })

-- TODO: When a terminal buffer (:term) is closed go to last listed buffer
vim.api.nvim_create_autocmd('TermClose', {
  group = vim.api.nvim_create_augroup('OnTermClose', { clear = true }),
  pattern = '*',
  callback = function(arg)
    local is_term_buf = is_term_plugin_buf(arg.buf)

    if is_term_buf then
      return
    end

    local buffers = vim.fn.getbufinfo { buflisted = 1 }

    table.sort(buffers, function(a, b)
      return a.lastused > b.lastused
    end)

    local last_buffer = buffers[2]

    -- TODO: Go to other buffer when winfixbuf is true raise a error
    -- Get current window and disable winfixbuf
    -- vim.api.nvim_set_option_value('winfixbuf', false, { win = 0 })

    if last_buffer then
      vim.cmd.buffer(last_buffer.bufnr)
    end
    -- Delete term buffer
    if vim.api.nvim_buf_is_valid(arg.buf) then
      vim.cmd('bd! ' .. arg.buf)
    end
  end,
})

return M
