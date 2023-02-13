local ls = require 'luasnip'
local i = ls.insert_node
local s = ls.snippet
local t = ls.text_node
local fmt = require('luasnip.extras.fmt').fmt

ls.add_snippets('lua', {
  s('ignore', {
    t '--stylua: ignore',
  }),
  s('req', fmt([[local {} = require('{}')]], { i(1), i(0) })),
  s('lf', {
    t 'local ',
    i(1),
    t ' = function(',
    i(2),
    t ')',
    t { '', '\t' },
    i(0),
    t { '', 'end' },
  }),
})
