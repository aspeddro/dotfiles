local builtin = require 'el.builtin'
local extensions = require 'el.extensions'
local sections = require 'el.sections'
local subscribe = require 'el.subscribe'
local lsp_statusline = require 'el.plugins.lsp_status'
local helper = require 'el.helper'
local diagnostic = require 'el.diagnostic'

local diagnostic_display = diagnostic.make_buffer()

local git_branch = subscribe.buf_autocmd(
  'el_git_branch',
  'BufEnter',
  function(window, buffer)
    local branch = extensions.git_branch(window, buffer)
    if branch then
      return ' ' .. extensions.git_icon() .. ' ' .. branch
    end
  end
)

local git_changes = subscribe.buf_autocmd(
  'el_git_changes',
  'BufWritePost',
  function(window, buffer)
    return extensions.git_changes(window, buffer)
  end
)

local function is_valid(_, buffer)
  return not vim.tbl_contains({ 'NvimTree', 'toggleterm' }, buffer.filetype)
end

require('el').setup {
  generator = function(window, buffer)
    if not is_valid(window, buffer) then
      return {
        { '' },
        -- { extensions.gen_mode { format_string = ' %s ' } },
      }
    end

    return {
      { extensions.gen_mode { format_string = ' %s ' } },
      { git_branch },
      { ' ' },
      { builtin.file },
      { sections.split, required = true },
      {
        sections.collapse_builtin {
          '[',
          builtin.help_list,
          builtin.readonly_list,
          ']',
        },
      },
      { diagnostic_display },
      { git_changes },
      { ' ' },
      { builtin.line },
      { ':' },
      { builtin.column },
      { ' ' },
      { builtin.filetype },
    }
  end,
}
