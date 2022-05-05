-- @see https://github.com/neovim/nvim-lspconfig/issues/1717
vim.api.nvim_win_set_config(0, { border = 'rounded' })
vim.keymap.set('n', 'q', '<cmd>bd<cr>', { buffer = true })
