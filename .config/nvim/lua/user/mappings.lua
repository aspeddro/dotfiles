local buffer = require 'user.modules.buffer'

-- move block
vim.keymap.set('n', '<a-k>', [[<Esc>:m .-2<CR>==]])
vim.keymap.set('n', '<a-j>', [[<Esc>:m .+1<CR>==]])

vim.keymap.set('v', '<a-k>', [[:m '<-2<CR>gv-gv]])
vim.keymap.set('v', '<a-j>', [[:m '>+1<CR>gv-gv]])

-- visual indentation
vim.keymap.set('v', '>', '>gv')
vim.keymap.set('v', '<', '<gv')

-- dont sent to clipboard
vim.keymap.set('n', 'C', [["_C]])

-- Cursor navigation
for key, value in pairs { s = 'j', w = 'k', d = 'l', a = 'h' } do
  vim.keymap.set({ 'n', 't' }, ('<a-%s>'):format(key), function()
    vim.cmd.wincmd(value)
  end)
end

-- Move window
for key, value in pairs { s = 'J', w = 'K', d = 'L', a = 'H' } do
  vim.keymap.set('n', ('<a-s-%s>'):format(key), function()
    vim.cmd.wincmd(value)
  end)
end

-- cuts without affecting yank
vim.keymap.set({ 'n', 'v' }, 'c', '"_c')

vim.keymap.set('t', '<esc>', [[<C-\><C-n>]])

-- save buffer
vim.keymap.set('n', '<leader>s', vim.cmd.write)

-- resize
for _, direction in ipairs { 'left', 'right', 'down', 'up' } do
  vim.keymap.set('n', ('<a-%s>'):format(direction), function()
    require('smart-splits')['resize_' .. direction]()
  end)
end

-- Buffer navigation
vim.keymap.set('n', '<leader>t', buffer.new)
vim.keymap.set('n', '<leader>w', function()
  buffer.close()
end)

for i = 1, 9, 1 do
  vim.keymap.set('n', ('<a-%d>'):format(i), function()
    buffer.go_to(i)
  end)
end

-- Diagnostics keymap
vim.keymap.set('n', '<leader>q', function()
  local items = vim.diagnostic.toqflist(vim.diagnostic.get())

  vim.fn.setqflist({}, ' ', { title = 'Workspace Diagnostics', items = items })

  vim.cmd 'botright copen'
end)

vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
--
vim.cmd 'map q <Nop>'
