local ls = require 'luasnip'
local i = ls.insert_node
local fmt = require('luasnip.extras.fmt').fmt
local t = ls.text_node
local newline = require('user.snippets').shared.newline

return {
  fun = fmt([[fun ({}) -> {}]], { i(1), i(0) }),
  let = fmt([[let {} = {} in {}]], { i(1, 'pattern'), i(2, '()'), i(0) }),
  func = t({ 'function', '| ' }, i(0)),
  lett = fmt([[let {} = {}]], { i(1, 'pattern'), i(0) }),
  val = fmt([[val {} : {}]], { i(1, 'name'), i(0) }),
  sig = {
    t { 'sig', '\t' },
    i(1),
    newline 'end',
    i(0),
  },
  struct = {
    t { 'struct', '\t' },
    i(1),
    newline 'end',
    i(0),
  },
  module = {
    t { 'module ' },
    i(1, 'M'),
    t { ' = struct', '\t' },
    i(2),
    newline 'end',
    i(0),
  },
  modulesig = {
    t { 'module ' },
    i(1, 'M'),
    t { ' : sig', '\t' },
    i(2),
    newline 'end',
    i(0),
  },
  moduletype = {
    t { 'module type ' },
    i(1, 'M'),
    t { ' = sig', '\t' },
    i(2),
    newline 'end',
    i(0),
  },
  match = {
    t { 'match ' },
    i(1, 'name'),
    t { ' with', '| ' },
    i(2, 'pattern'),
    t { ' -> ' },
    i(3, 'pattern'),
    t { '', '' },
    i(0),
  },
  ['|'] = {
    t { '| ' },
    i(1, '_'),
    t { ' -> ' },
    i(2),
    t { '', '' },
    i(0),
  },
}
