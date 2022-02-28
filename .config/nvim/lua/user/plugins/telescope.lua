local actions = require 'telescope.actions'
local action_state = require 'telescope.actions.state'
local action_set = require 'telescope.actions.set'

local Job = require 'plenary.job'
local Filetype = require 'plenary.filetype'

local select = function(prompt_bufnr)
  local current_picker = action_state.get_current_picker(prompt_bufnr)
  local selection = current_picker:get_selection()

  if
    selection.value ~= nil
    and type(selection.value) == 'string'
    and vim.tbl_contains({ 'pdf' }, Filetype.detect(selection.value))
  then
    Job
      :new({
        command = 'evince',
        args = { selection.value },
      })
      :start()

    return actions.close(prompt_bufnr)
  end
  return action_set.select(prompt_bufnr, 'default')
end

require('telescope').setup {
  defaults = {
    vimgrep_arguments = {
      'rg',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case',
    },
    mappings = {
      i = {
        ['<esc>'] = actions.close,
        ['<c-j>'] = actions.move_selection_next,
        ['<c-k>'] = actions.move_selection_previous,
        ['<CR>'] = select,
      },
      n = {
        ['<CR>'] = select,
      },
    },
    prompt_prefix = '➜ ',
    selection_caret = '➜ ',
    entry_prefix = '  ',
  },
  pickers = {
    find_files = {
      -- previewer = true,
      find_command = {
        'rg',
        '--hidden',
        '--no-heading',
        '--files',
        '--iglob',
        '!.git',
      },
    },
  },
  extensions = {
    fzf = {
      fuzzy = true, -- false will only do exact matching
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true, -- override the file sorter
      case_mode = 'smart_case', -- or "ignore_case" or "respect_case"
      -- the default case_mode is "smart_case"
    },
  },
}

require('mapx').nmap('<c-p>', function()
  require('telescope.builtin').find_files()
end)

require('mapx').nmap('<c-o>', function()
  require('telescope.builtin').live_grep()
end)
require('mapx').nmap('<c-f>', function()
  require('telescope.builtin').current_buffer_fuzzy_find()
end)
