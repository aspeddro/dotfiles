local ls = require 'luasnip'
local i = ls.insert_node
local s = ls.snippet
-- local fmt = require('luasnip.extras.fmt').fmt
local t = ls.text_node

ls.add_snippets('ocaml', {
  -- s('sig', {
  --   t { 'sig', '\t' },
  --   i(1),
  --   t { '', 'end' },
  --   i(0),
  -- }),
  -- s('struct', {
  --   t { 'struct', '\t' },
  --   i(1),
  --   t { '', 'end' },
  --   i(0),
  -- }),
  s('module', {
    t { 'module ' },
    i(1, 'M'),
    t { ' = struct', '\t' },
    i(2),
    t { '', 'end' },
    i(0),
  }),
  s('modulesig', {
    t { 'module type ' },
    i(1, 'M'),
    t { ' = sig', '\t' },
    i(2),
    t { '', 'end' },
    i(0),
  }),
  s('moduletype', {
    t { 'module type ' },
    i(1, 'M'),
    t { ' = sig', '\t' },
    i(2),
    t { '', 'end' },
    i(0),
  }),
})
