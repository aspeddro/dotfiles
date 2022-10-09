local builtin = require 'telescope.builtin'
local actions = require 'telescope.actions'

require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ['<esc>'] = actions.close,
      },
    },
    prompt_prefix = '➜ ',
    selection_caret = '➜ ',
    entry_prefix = '  ',
    preview = {
      treesitter = false,
    },
  },
  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = 'smart_case',
    },
    recent_files = {
      only_cwd = true,
    },
  },
}

vim.keymap.set('n', '<c-p>', builtin.find_files)
vim.keymap.set('n', '<c-d>', builtin.buffers)
vim.keymap.set('n', '<c-o>', builtin.live_grep)
vim.keymap.set('n', '<c-f>', builtin.current_buffer_fuzzy_find)
