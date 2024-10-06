local conform = require 'conform'
local util = require 'conform.util'

---@param paths string[]
---@param fallback string
local find_local_executable = function(paths, fallback)
  local cwd = vim.uv.cwd()

  for _, path in ipairs(paths) do
    local bin_path = vim.fs.joinpath(cwd, path)
    if vim.fn.executable(bin_path) == 1 then
      paths = { bin_path }
      break
    end
  end

  return util.find_executable(paths, fallback)
end

conform.setup {
  formatters = {
    ruff_format = {
      command = find_local_executable({ '.venv/bin/ruff' }, 'ruff'),
    },
    sqlfmt = {
      command = find_local_executable({ '.venv/bin/sqlfmt' }, 'sqlfmt'),
    },
    yamlfix = {
      command = find_local_executable({ '.venv/bin/yamlfix' }, 'yamlfix'),
    },
  },
  formatters_by_ft = {
    lua = { 'stylua' },
    python = { 'ruff_format' },
    javascript = { 'prettier' },
    sql = { 'sqlfmt' },
    markdown = { 'prettier' },
    yaml = { 'yamlfix' },
  },
  -- Disable
  format_on_save = nil,
  format_after_save = nil,
}

local get_formatter_for_bufnr = function()
  local formatters_for_bufnr = conform.list_formatters(0)

  return vim.tbl_map(function(fmt)
    return fmt.name
  end, formatters_for_bufnr)
end

vim.api.nvim_create_user_command('Format', function(args)
  local range = nil
  if args.count ~= -1 then
    local end_line =
      vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
    range = {
      start = { args.line1, 0 },
      ['end'] = { args.line2, end_line:len() },
    }
  end

  local formatter = vim.tbl_isempty(args.fargs) and get_formatter_for_bufnr()
    or { args.fargs[1] }

  conform.format({
    formatters = formatter,
    async = true,
    lsp_fallback = false,
    range = range,
  }, function(err)
    local names = table.concat(formatter, ', ')
    if err ~= nil then
      vim.notify(
        'Failed to format with ' .. names .. 'error: ' .. err,
        vim.log.levels.ERROR
      )
    else
      vim.print('Formatted with ' .. names)
    end
  end)
end, {
  range = true,
  nargs = '*',
  complete = get_formatter_for_bufnr,
})
