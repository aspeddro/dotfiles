local id_yank_text = vim.api.nvim_create_augroup('OnYankText', { clear = true })

vim.api.nvim_create_autocmd('TextYankPost', {
  group = id_yank_text,
  pattern = '*',
  callback = function()
    vim.highlight.on_yank { timeout = 150 }
  end,
})
