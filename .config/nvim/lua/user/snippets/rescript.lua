local ls = require 'luasnip'
local fmt = require('luasnip.extras.fmt').fmt
local s = ls.snippet
local i = ls.insert_node
local t = ls.text_node

ls.add_snippets('rescript', {
  s(
    'doctemplate',
    fmt(
      [[
      /**
      {}
      */
      ]],
      { i(0) }
    )
  ),
  s(
    'docmodtemplate',
    fmt(
      [[
      /***
      {}
      */
      ]],
      { i(0) }
    )
  ),
  s('switch', {
    t { 'switch ' },
    i(1, ''),
    t { ' {', '| ' },
    i(2, ''),
    t { ' => ' },
    i(3, ''),
    t { '', '}' },
    i(0),
  }),
  s('module', {
    t { 'module ' },
    i(1, ''),
    t { ' = ' },
    i(0),
  }),
  s('moduletype', {
    t { 'module type ' },
    i(1, ''),
    t { ' = {', '\t' },
    i(2),
    t { '', '}' },
    i(0),
  }),
  s(
    'externalobj',
    fmt([[@val external {}: {} = "{}"]], {
      i(1, 'setTimeout'),
      i(2, '(unit => unit, int) => float'),
      i(0, 'setTimeout'),
    })
  ),
  s(
    'externalglobal',
    fmt([[@scope("{}") @val external {}: {} = "{}"]], {
      i(1, 'Math'),
      i(2, 'random'),
      i(3, 'unit => float'),
      i(0, 'random'),
    })
  ),
  s(
    'externalmod',
    fmt([[@module("{}") external {}: {} = "{}"]], {
      i(1, 'path'),
      i(2, 'dirname'),
      i(3, 'string => string'),
      i(0, 'dirname'),
    })
  ),
  s(
    'externalmodd',
    fmt([[@module external {}: {} = "{}"]], {
      i(1, 'leftPad'),
      i(2, '(string, int) => string'),
      i(3, 'leftPad'),
    })
  ),
  s('component', {
    t { '@react.component', '' },
    t 'let make = (',
    i(1, ''),
    t ') => {',
    t { '', '\t' },
    i(2),
    t { '', '}' },
    i(0),
  }),
  s('for', {
    t 'for ',
    i(1),
    t ' in ',
    i(2),
    t ' to ',
    i(3),
    t ' {',
    t { '', '\t' },
    i(4),
    t { '', '}' },
    i(0),
  }),
})
