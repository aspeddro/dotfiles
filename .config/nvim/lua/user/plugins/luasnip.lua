local ls = require 'luasnip'
local snips = require 'user.snippets'

ls.config.set_config {
  -- prevent back to snippet when leaving it
  history = true,
  updateevents = 'TextChanged,TextChangedI',
}

for _, filetype in pairs { 'all', 'lua', 'ocaml', 'javascript', 'markdown' } do
  ls.add_snippets(filetype, snips.filetype[filetype])
end

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
