
-- vim.lsp.handlers['textDocument/hover'] = (function(_, result, ctx)
--   local handler = function(_, result, ctx)
--     if result then
--       local content = result.contents or result.contents.value
--       if not content then
--         print('[LSP] No capabilities for hover')
--         return
--       end
--       local lines = vim.split(content, '\n', true)
--       local markdown_lines = vim.lsp.util.convert_input_to_markdown_lines(content)
--       markdown_lines = vim.lsp.util.trim_empty_lines(markdown_lines)
--       local bufnr = vim.lsp.util.open_floating_preview(lines, 'markdown', { border = 'rounded', max_width = 60, focus_id = ctx.method })

--       require('colorizer').highlight_buffer(bufnr, nil, vim.list_slice(lines, 2, #lines), 0, require('colorizer').get_buffer_options(0))
--     end
--   end
--   return handler
-- end)()

-- vim.lsp.handlers['textDocument/show_line_diagnostics'] = vim.lsp.with(
--   vim.lsp.handlers.hover,
--   { border = 'rounded' }
-- )
