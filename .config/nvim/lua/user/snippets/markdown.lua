local ls = require 'luasnip'
local t = ls.text_node
local i = ls.insert_node
local newline = require('user.snippets').shared.newline

return {
  codeblock = {
    t { '```' },
    i(1),
    newline '',
    i(2),
    newline '```',
  },
}
