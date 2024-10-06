local oil = require 'oil'

oil.setup {
  -- columns = {},
  delete_to_trash = true,
  view_options = {
    show_hidden = false,
  },
  keymaps = {
    ['g?'] = 'actions.show_help',
    ['<CR>'] = 'actions.select',
    ['<C-s>'] = 'actions.select_vsplit',
    ['<C-h>'] = 'actions.select_split',
    ['<C-t>'] = 'actions.select_tab',
    ['<C-p>'] = 'actions.preview',
    ['<C-c>'] = 'actions.close',
    ['<C-l>'] = 'actions.refresh',
    ['-'] = 'actions.parent',
    -- ["_"] = "actions.open_cwd",
    ['`'] = 'actions.cd',
    ['~'] = 'actions.tcd',
    ['gs'] = 'actions.change_sort',
    ['gx'] = 'actions.open_external',
    ['g.'] = 'actions.toggle_hidden',
    ['g\\'] = 'actions.toggle_trash',
  },
}

vim.keymap.set('n', '<leader>n', function()
  oil.open(vim.fn.getcwd())
end, { desc = 'Open Oil' })
vim.keymap.set('n', '-', oil.open, { desc = 'Go to parent dir' })
