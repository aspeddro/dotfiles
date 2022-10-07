local ls = require 'luasnip'
local i = ls.insert_node
local t = ls.text_node
local newline = require('user.snippets').shared.newline

return {
  swtich = {
    t { 'switch ' },
    i(1, 'patterns'),
    t { ' {', '| ' },
    i(2, 'pattern'),
    t { ' => ' },
    i(3, 'pattern'),
    t { '', '}' },
    i(0),
  },
  module = {
    t { 'module ' },
    i(1, 'Name'),
    t { ' = {', '\t' },
    i(2),
    newline '}',
    i(0),
  },
  moduletype = {
    t { 'module type ' },
    i(1, 'Name'),
    t { ' = {', '\t' },
    i(2),
    newline '}',
    i(0),
  },
}
