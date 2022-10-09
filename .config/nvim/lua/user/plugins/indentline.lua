vim.g.indent_blankline_context_patterns = {
  'class',
  '^func',
  'method',
  '^if',
  'while',
  'for',
  'with',
  'try',
  'except',
  'arguments',
  'argument_list',
  'object',
  'dictionary',
  'element',
  'table',
  'tuple',
  -- Rescript
  'type_declaration',
  'module_declaration',
  'block',
  'switch_match',
  'jsx_fragment',
}
require('indent_blankline').setup {
  show_current_context = true,
  filetype_exclude = {
    'NvimTree',
    'lsp-installer',
    'terminal',
    'toggleterm',
    'glowpreview',
    'tsplayground',
    'help',
  },
}