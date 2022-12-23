local ls = require 'luasnip'
local fmt = require('luasnip.extras.fmt').fmt
local i = ls.insert_node
local t = ls.text_node
local newline = require('user.snippets').shared.newline

return {
  doc = fmt(
    [[
      /**
       * {}
       */
      ]],
    { i(0) }
  ),
  docmod = fmt(
    [[
      /***
        {}
      */
      ]],
    { i(0) }
  ),
  switch = {
    t { 'switch ' },
    i(1, ''),
    t { ' {', '| ' },
    i(2, ''),
    t { ' => ' },
    i(3, ''),
    t { '', '}' },
    i(0),
  },
  module = {
    t { 'module ' },
    i(1, ''),
    t { ' = {', '\t' },
    i(2),
    newline '}',
    i(0),
  },
  moduletype = {
    t { 'module type ' },
    i(1, ''),
    t { ' = {', '\t' },
    i(2),
    newline '}',
    i(0),
  },
  externalobj = fmt([[@val external {}: {} = "{}"]], {
    i(1, 'setTimeout'),
    i(2, '(unit => unit, int) => float'),
    i(0, 'setTimeout'),
  }),
  externalglobal = fmt([[@scope("{}") @val external {}: {} = "{}"]], {
    i(1, 'Math'),
    i(2, 'random'),
    i(3, 'unit => float'),
    i(0, 'random'),
  }),
  externalmod = fmt([[@module("{}") external {}: {} = "{}"]], {
    i(1, 'path'),
    i(2, 'dirname'),
    i(3, 'string => string'),
    i(0, 'dirname'),
  }),
  externalmodd = fmt([[@module external {}: {} = "{}"]], {
    i(1, 'leftPad'),
    i(2, '(string, int) => string'),
    i(3, 'leftPad'),
  }),
  component = {
    t { '@react.component', '' },
    'let make = (',
    i(1, ''),
    ') => {',
    newline '\t',
    i(2),
    newline '}',
    i(0),
  },
  ['for'] = {
    'for ',
    i(1),
    ' in ',
    i(2),
    ' to ',
    i(3),
    ' {',
    newline '\t',
    i(4),
    newline '}',
    i(0),
  },
}
