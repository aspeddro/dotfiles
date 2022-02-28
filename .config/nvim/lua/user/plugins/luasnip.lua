local ls = require 'luasnip'
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local fmt = require('luasnip.extras.fmt').fmt
local rep = require('luasnip.extras').rep

ls.config.set_config {
  -- prevent back to snippet when leaving it
  history = false,
  updateevents = 'TextChanged,TextChangedI',
  -- region_check_events = 'TextChanged,TextChangedI',
  -- delete_check_events = 'CursorMoved',
}

local function indent()
  if vim.bo.expandtab then
    return '\t'
  end
  return string.rep(' ', vim.api.nvim_buf_get_option(0, 'shiftwidth'))
end

-- ls.snippets = {
--   all = {
--     s({ trig = 'date' }, {
--       f(function()
--         return string.format(
--           string.gsub(vim.bo.commentstring, '%%s', ' %%s'),
--           os.date()
--         )
--       end, {}),
--     }),
--   },
--   lua = {
--     s({ trig = 'ignore', dscr = 'StyLua Ignore' }, t '-- stylua: ignore'),
--     s(
--       { trig = 'local req' },
--       fmt([[local {} = require('{}')]], { i(1), i(0) })
--     ),
--     s({ trig = 'mod func', dscr = 'module function' }, {
--       i(1, 'M'),
--       t ' = function(',
--       i(2),
--       t { ')', '' },
--       f(indent),
--       i(0),
--       t { '', 'end' },
--     }),
--   },
--   typescript = {
--     s(
--       { trig = '/*', dscr = 'JSDOc comment' },
--       fmt(
--         [[
--         /**
--          * {}
--          */
--         ]],
--         { i(0) }
--       )
--     ),
--   },
--   -- rescript = {
--   --   s({ trig = '@react', dscr = 'React Compoment' }, {
--   --     t { '@react.compoment', 'let make = (' },
--   --     i(1),
--   --     t { ') => {', '' },
--   --     f(indent),
--   --     i(0),
--   --     t { '', '}' },
--   --   }),
--   -- },
--   rmd = {
--     s({ trig = 'chunck', dscr = 'Chunck Code' }, {
--       t '```{r ',
--       i(1, 'unnamed'),
--       t { '}', '' },
--       i(0),
--       t { '', '```' },
--     }),
--   },
-- }

require('luasnip.loaders.from_vscode').lazy_load()
require('luasnip').filetype_extend('javascript', { 'typescript' })

require('mapx').imap('<c-e>', function()
  if ls.expand_or_locally_jumpable() then
    ls.expand_or_jump()
  end
end)
require('mapx').smap('<c-e>', function()
  if ls.expand_or_locally_jumpable() then
    ls.expand_or_jump()
  end
end)
