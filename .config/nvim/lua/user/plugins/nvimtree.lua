local tree_cb = require('nvim-tree.config').nvim_tree_callback
vim.g.nvim_tree_highlight_opened_files = 2
vim.g.nvim_tree_special_files = {
  ['README.md'] = false,
  ['Makefile'] = false,
  ['MAKEFILE'] = false,
}
require('nvim-tree').setup {
  disable_netrw = true,
  hijack_netrw = false,
  open_on_setup = false,
  ignore_ft_on_setup = {},
  auto_reload_on_write = true,
  open_on_tab = false,
  hijack_cursor = true,
  update_cwd = false,
  hijack_directories = {
    enable = false,
    auto_open = false,
  },
  diagnostics = {
    enable = false,
    icons = {
      hint = '',
      info = '',
      warning = '',
      error = '',
    },
  },
  update_focused_file = {
    enable = true,
    update_cwd = false,
    ignore_list = {},
  },
  system_open = {
    cmd = nil,
    args = {},
  },
  git = {
    enable = false,
    ignore = false,
    timeout = 500,
  },
  trash = {
    cmd = 'rip',
    require_confirm = false,
  },
  actions = {
    change_dir = {
      global = false,
    },
    open_file = {
      quit_on_open = false,
      window_picker = {
        enable = true,
        chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890',
        exclude = {
          -- buftype = { 'nofile', 'terminal', 'help', 'NvimTree', 'toggleterm', 'DiffviewFileHistory' },
          filetype = {
            'NvimTree',
            'notify',
            'packer',
            'qf',
            'nofile',
            'toggleterm',
            'terminal',
            'DiffviewFileHistory',
          },
        },
      },
    },
  },
  view = {
    -- width of the window, can be either a number (columns) or a string in `%`
    width = 40,
    -- side of the tree, can be one of 'left' | 'right' | 'top' | 'bottom'
    side = 'left',
    preserve_window_proportions = true,
    hide_root_folder = true,
    mappings = {
      -- custom only false will merge the list with the default mappings
      -- if true, it will only use your list to set the mappings
      custom_only = true,
      -- list of mappings to set on the tree manually
      list = {
        { key = { '<CR>', 'o', '<2-LeftMouse>' }, cb = tree_cb 'edit' },
        { key = { '<2-RightMouse>', '<C-]>' }, cb = tree_cb 'cd' },
        { key = '<C-v>', cb = tree_cb 'vsplit' },
        { key = '<C-x>', cb = tree_cb 'split' },
        { key = '<C-t>', cb = tree_cb 'tabnew' },
        { key = '<', cb = tree_cb 'prev_sibling' },
        { key = '>', cb = tree_cb 'next_sibling' },
        { key = 'P', cb = tree_cb 'parent_node' },
        { key = '<BS>', cb = tree_cb 'close_node' },
        { key = '<S-CR>', cb = tree_cb 'close_node' },
        { key = '<Tab>', cb = tree_cb 'preview' },
        { key = 'K', cb = tree_cb 'first_sibling' },
        { key = 'J', cb = tree_cb 'last_sibling' },
        { key = 'I', cb = tree_cb 'toggle_ignored' },
        { key = 'H', cb = tree_cb 'toggle_dotfiles' },
        { key = 'R', cb = tree_cb 'refresh' },
        { key = 'a', cb = tree_cb 'create' },
        { key = 'd', cb = tree_cb 'remove' },
        { key = 'r', cb = tree_cb 'rename' },
        { key = '<C-r>', cb = tree_cb 'full_rename' },
        { key = 'x', cb = tree_cb 'cut' },
        { key = 'c', cb = tree_cb 'copy' },
        { key = 'p', cb = tree_cb 'paste' },
        { key = 'y', cb = tree_cb 'copy_name' },
        { key = 'Y', cb = tree_cb 'copy_path' },
        { key = 'gy', cb = tree_cb 'copy_absolute_path' },
        { key = '[c', cb = tree_cb 'prev_git_item' },
        { key = ']c', cb = tree_cb 'next_git_item' },
        { key = '-', cb = tree_cb 'dir_up' },
        { key = 's', cb = tree_cb 'system_open' },
        { key = 'q', cb = tree_cb 'close' },
        { key = 'g?', cb = tree_cb 'toggle_help' },
      },
    },
  },
}

vim.keymap.set('n', '<c-n>', function()
  require('nvim-tree').toggle()
end, { desc = 'Toggle NvimTree' })
