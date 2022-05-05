local ft = require 'Comment.ft'

ft.set('rescript', { '//%s', '/*%s*/' })

require('Comment').setup {
  ignore = function()
    return '^$'
  end,
}
