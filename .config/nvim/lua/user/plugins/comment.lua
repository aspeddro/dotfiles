local ft = require 'Comment.ft'

ft.set('config', '#%s')
ft.set('r', '#%s')
ft.set('zsh', '#%s')
ft.set('query', ';%s')

require('Comment').setup {
  padding = true,
  sticky = true,
  ignore = function()
    return '^$'
  end,
  toggler = {
    line = 'gcc',
    block = 'gbc',
  },
  opleader = {
    line = 'gc',
    block = 'gb',
  },
  mappings = {
    basic = true,
    extra = true,
    extended = false,
  },
}
