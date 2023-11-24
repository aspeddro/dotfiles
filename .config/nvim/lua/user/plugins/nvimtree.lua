require('nvim-tree').setup {
  renderer = {
    special_files = {},
    root_folder_label = false,
  },
  git = {
    -- TODO: enable
    enable = true,
  },
  trash = {
    cmd = 'rip',
  },
  filters = {
    custom = { '.git$', '.cmi$', '.cmj$', '.cmt$' },
    git_ignored = false,
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
