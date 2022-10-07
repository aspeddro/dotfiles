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
    custom = { '.git$' },
  },
}
vim.keymap.set(
  'n',
  '<c-n>',
  require('nvim-tree').toggle,
  { desc = 'Toggle NvimTree' }
)
