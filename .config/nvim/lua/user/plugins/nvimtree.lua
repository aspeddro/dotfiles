require('nvim-tree').setup {
  view = {
    hide_root_folder = true,
    width = 35,
  },
  renderer = {
    special_files = {},
  },
  git = {
    enable = false,
  },
  trash = {
    cmd = 'rip',
  },
  filters = {
    custom = { '.git$', '.cmi$', '.cmj$', '.cmt$' },
  },
  -- TODO: handle buffer delete when file is open
}

vim.keymap.set(
  'n',
  '<leader>n',
  require('nvim-tree').toggle,
  { desc = 'Toggle NvimTree' }
)
