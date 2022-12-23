local M = {}

vim.lsp.handlers['textDocument/publishDiagnostics'] =
  vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = true,
    signs = false,
    -- underline = true,
    underline = {
      severity_limit = 'Warning',
    },
    update_in_insert = false,
    severity_sort = true,
  })

local float_options = {
  border = 'rounded',
  max_width = math.ceil(vim.api.nvim_win_get_width(0) * 0.6),
  max_height = math.ceil(vim.api.nvim_win_get_height(0) * 0.8),
}

vim.lsp.handlers['textDocument/show_line_diagnostics'] =
  vim.lsp.with(vim.lsp.handlers.hover, float_options)

-- vim.lsp.handlers['textDocument/hover'] =
--   vim.lsp.with(vim.lsp.handlers.hover, float_options)

--Prevent show notification
--from https://github.com/neovim/neovim/issues/20457#issuecomment-1266782345
vim.lsp.handlers['textDocument/hover'] = function(_, result, ctx, config)
  config = config or float_options
  config.focus_id = ctx.method
  if not result then
    return
  end
  local markdown_lines =
    vim.lsp.util.convert_input_to_markdown_lines(result.contents)
  markdown_lines = vim.lsp.util.trim_empty_lines(markdown_lines)
  if vim.tbl_isempty(markdown_lines) then
    return
  end
  return vim.lsp.util.open_floating_preview(markdown_lines, 'markdown', config)
end

vim.lsp.handlers['textDocument/signatureHelp'] =
  vim.lsp.with(vim.lsp.handlers.signature_help, float_options)

return M
