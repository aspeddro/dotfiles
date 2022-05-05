local bufferhandler = require 'bufferhandler'

-- better navigation
-- vim.keymap.set('n', [[<a-h>]], [[<C-w>h]])
-- vim.keymap.set('n', [[<a-j>]], [[<C-w>j]])
-- vim.keymap.set('n', [[<a-k>]], [[<C-w>k]])
-- vim.keymap.set('n', [[<a-l>]], [[<C-w>l]])

-- move block
vim.keymap.set('n', '<a-k>', '<Esc>:m .-2<CR>==')
vim.keymap.set('n', '<a-j>', '<Esc>:m .+1<CR>==')

vim.keymap.set('v', '<a-k>', ":m '<-2<CR>gv-gv")
vim.keymap.set('v', '<a-j>', ":m '>+1<CR>gv-gv")

-- visual indentation
vim.keymap.set('v', '>', '>gv')
vim.keymap.set('v', '<', '<gv')

-- Window navigation
vim.keymap.set('n', '<a-s>', '<cmd>wincmd j<cr>', { silent = true }) -- move cursor down
vim.keymap.set('n', '<a-w>', '<cmd>wincmd k<cr>', { silent = true }) -- move cursor up
vim.keymap.set('n', '<a-d>', '<cmd>wincmd l<cr>', { silent = true }) -- move cursor right
vim.keymap.set('n', '<a-a>', '<cmd>wincmd h<cr>', { silent = true }) -- move cursor left

-- vim.keymap.set("n", "<leader>w=", "<cmd>wincmd =<cr>", { silent = true }) -- Make window equally
-- vim.keymap.set("n", "<leader>w+", "<cmd>wincmd +<cr>", { silent = true }) -- Increase current window
-- vim.keymap.set("n", "<leader>w-", "<cmd>wincmd -<cr>", { silent = true }) -- Decrease current window

-- terminal navigation
vim.keymap.set('t', '<a-a>', '<C-\\><C-N><C-w>h')
vim.keymap.set('t', '<a-s>', '<C-\\><C-N><C-w>j')
vim.keymap.set('t', '<a-w>', '<C-\\><C-N><C-w>k')
vim.keymap.set('t', '<a-d>', '<C-\\><C-N><C-w>k')

-- cuts without affecting yank
vim.keymap.set('n', 'C', '"_C')

-- save buffer
vim.keymap.set('n', '<c-s>', [[:w!<cr>]])

-- resize
for _, direction in ipairs { 'left', 'right', 'down', 'up' } do
  vim.keymap.set('n', ('<a-%s>'):format(direction), function()
    require('smart-splits')['resize_' .. direction]()
  end)
end

-- Buffer next and previous
vim.keymap.set('n', '<a-m>', '<cmd>bnext<CR>', { silent = true })
vim.keymap.set('n', '<a-n>', '<cmd>bprevious<CR>', { silent = true })

-- Buffer navigation
vim.keymap.set('n', '<a-v>', function()
  bufferhandler.split()
end)
vim.keymap.set('n', '<a-x>', function()
  bufferhandler.split { side = false }
end)
vim.keymap.set('n', '<c-t>', function()
  bufferhandler.new()
end)
vim.keymap.set('n', '<c-w>', function()
  bufferhandler.close()
end)

for i = 1, 9, 1 do
  vim.keymap.set('n', ('<a-%d>'):format(i), function()
    bufferhandler.go_to(i)
  end)
end
