require('nvim-tree').setup {
  renderer = {
    special_files = {},
    root_folder_label = false,
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
  view = {
    width = 35,
    preserve_window_proportions = true,
  },
}

vim.keymap.set(
  'n',
  '<leader>n',
  vim.cmd.NvimTreeToggle,
  { desc = 'Toggle NvimTree' }
)
