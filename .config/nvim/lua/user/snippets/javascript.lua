local ls = require 'luasnip'
local fmt = require('luasnip.extras.fmt').fmt
local i = ls.insert_node
local s = ls.snippet

ls.add_snippets('javascript', {
  s(
    'doc',
    fmt(
      [[
      /**
       * {}
       */
      ]],
      { i(0) }
    )
  ),
})
