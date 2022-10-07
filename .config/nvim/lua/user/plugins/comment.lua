local ft = require 'Comment.ft'

ft({ 'rescript', 'reason' }, { '//%s', '/*%s*/' })

require('Comment').setup {
  ignore = function()
    return '^$'
  end,
}
