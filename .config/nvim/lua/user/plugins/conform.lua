local conform = require 'conform'

conform.formatters.sqlfmt = {
  command = 'sqlfmt',
  args = { '-' },
}

conform.setup {
  formatters_by_ft = {
    lua = { 'stylua' },
    python = { 'isort', 'black' },
    javascript = { 'prettier' },
    sql = { 'sqlfmt', 'sql_formatter' },
    markdown = { 'prettier' },
  },
  -- Disable
  format_on_save = false,
  format_after_save = false,
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
