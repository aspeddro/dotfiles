local ls = require 'luasnip'
local fmt = require('luasnip.extras.fmt').fmt
local i = ls.insert_node

return {
  jsdoc = fmt(
    [[
      /**
       * {}
       */
      ]],
    { i(0) }
  ),
}
