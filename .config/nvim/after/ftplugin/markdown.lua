vim.api.nvim_buf_create_user_command(0, 'PeekOpen', require('peek').open, {})
vim.api.nvim_buf_create_user_command(0, 'PeekClose', require('peek').close, {})
