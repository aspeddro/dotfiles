local ls = require 'luasnip'

ls.config.set_config {
  -- prevent back to snippet when leaving it
  history = true,
  updateevents = 'TextChanged,TextChangedI',
}

require 'user.snippets.all'
require 'user.snippets.lua'
require 'user.snippets.markdown'
require 'user.snippets.rescript'
require 'user.snippets.javascript'
-- require('user.snippets.ocaml')

ls.filetype_extend('rmd', { 'markdown' })
ls.filetype_extend('pandoc', { 'markdown' })

-- NOTE: testing c-k and c-j
vim.keymap.set({ 'i', 's' }, '<c-k>', function()
  if ls.expand_or_jumpable() then
    ls.expand_or_jump()
  end
end, { silent = true })

vim.keymap.set({ 'i', 's' }, '<c-j>', function()
  if ls.jumpable(-1) then
    ls.jump(-1)
  end
end, { silent = true })
