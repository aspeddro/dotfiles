local id_yank_text = vim.api.nvim_create_augroup('OnYankText', { clear = true })

vim.api.nvim_create_autocmd('TextYankPost', {
  group = id_yank_text,
  pattern = '*',
  callback = function()
    vim.highlight.on_yank { timeout = 150 }
  end,
})

vim.api.nvim_create_autocmd('TermOpen', {
  -- group = vim.api.nvim_create_augroup('OnTermOpen', { clear = true }),
  pattern = '*',
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.opt_local.winfixbuf = true
  end,
})

vim.api.nvim_create_autocmd('TermClose', {
  -- group = vim.api.nvim_create_augroup('OnTermClose', { clear = true }),
  pattern = '*',
  callback = function()
    vim.opt_local.winfixbuf = false
  end,
})
