local ls = require 'luasnip'
local i = ls.insert_node
local fmt = require('luasnip.extras.fmt').fmt
local newline = require('user.snippets').shared.newline

return {
  ignore = '-- stylua: ignore',
  req = fmt([[local {} = require('{}')]], { i(1), i(0) }),
  lf = {
    desc = 'table function',
    'local ',
    i(1),
    ' = function(',
    i(2),
    ')',
    newline '  ',
    i(0),
    newline 'end',
  },
}
