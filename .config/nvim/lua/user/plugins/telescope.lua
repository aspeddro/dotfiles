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
  pickers = {
    find_files = {
      find_command = {
        'rg',
        '--color=never',
        '--files',
        '--hidden',
        '-g',
        '!.git',
      },
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

vim.keymap.set('n', '<leader>p', builtin.find_files)
vim.keymap.set('n', '<leader>d', builtin.buffers)
vim.keymap.set('n', '<leader>o', builtin.live_grep)
vim.keymap.set('n', '<leader>f', builtin.current_buffer_fuzzy_find)
