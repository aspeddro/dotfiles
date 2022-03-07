local mapx = require 'mapx'

mapx.inoremap('<a-j>', '<Esc>:m .+1<CR>==gi')
mapx.inoremap('<a-k>', '<Esc>:m .-2<CR>==gi')
mapx.inoremap('<a-down>', '<C-\\><C-N><C-w>')

mapx.nnoremap('<a-j>', '<Esc>:m .+1<CR>==')
mapx.nnoremap('<a-k>', '<Esc>:m .-1<CR>==')

-- NOTE: use alt key?
-- better navigation
mapx.nnoremap([[<C-h>]], [[<C-w>h]])
mapx.nnoremap([[<C-j>]], [[<C-w>j]])
mapx.nnoremap([[<C-k>]], [[<C-w>k]])
mapx.nnoremap([[<C-l>]], [[<C-w>l]])

mapx.nnoremap('<c-s>', ':w!<cr>', 'silent')

-- resize
mapx.nnoremap('<c-left>', function()
  require('user.utils').events.resize 'left'
end)
mapx.nnoremap('<c-right>', function()
  require('user.utils').events.resize 'right'
end)
mapx.nnoremap('<c-down>', function()
  require('user.utils').events.resize 'down'
end)
mapx.nnoremap('<c-up>', function()
  require('user.utils').events.resize 'up'
end)

-- better indetation
mapx.vnoremap('>', '<gv')
mapx.vnoremap('<', '>gv')

-- terminal escape
-- mapx.tmap('<c-h>', '<C-\\><C-N><C-w>h')
-- mapx.tmap('<c-j>', '<C-\\><C-N><C-w>j')
-- mapx.tmap('<c-k>', '<C-\\><C-N><C-w>k')
-- mapx.tmap('<c-l>', '<C-\\><C-N><C-w>k')

-- Buffer
mapx.nnoremap('<a-v>', function()
  require('bufferhandler').split()
end)
mapx.nnoremap('<a-x>', function()
  require('bufferhandler').split { open_right = false }
end)
mapx.nnoremap('<c-t>', function()
  require('bufferhandler').new()
end)
mapx.nnoremap('<c-w>', function()
  require('bufferhandler').close()
end)
mapx.nnoremap('<a-1>', function()
  require('bufferhandler').go_to(1)
end)
mapx.nnoremap('<a-2>', function()
  require('bufferhandler').go_to(2)
end)
mapx.nnoremap('<a-3>', function()
  require('bufferhandler').go_to(3)
end)
mapx.nnoremap('<a-4>', function()
  require('bufferhandler').go_to(4)
end)
mapx.nnoremap('<a-5>', function()
  require('bufferhandler').go_to(5)
end)
mapx.nnoremap('<a-6>', function()
  require('bufferhandler').go_to(6)
end)
mapx.nnoremap('<a-7>', function()
  require('bufferhandler').go_to(7)
end)
mapx.nnoremap('<a-8>', function()
  require('bufferhandler').go_to(8)
end)
mapx.nnoremap('<a-9>', function()
  require('bufferhandler').go_to(9)
end)

-- return {
--   -- { ':', ';' },
--   {
--     mode = 'i',
--     {
--       {
--         '<A-',
--         { -- alt key
--           { 'j>', [[<Esc>:m .+1<CR>==gi]] },
--           { 'k>', [[<Esc>:m .-2<CR>==gi]] },
--           { 'Down>', [[<C-\\><C-N><C-w>j]] },
--         },
--       },
--     },
--   },

--   {
--     mode = 'n',
--     {
--       '<A-',
--       { -- Alt key, move block code
--         { 'j>', [[<Esc>:m .+1<CR>==]] },
--         { 'k>', [[<Esc>:m .-2<CR>==]] },
--         -- open terminal
--         { 'r>', [[:ToggleTerm direction=vertical<CR>]] },
--         { 'b>', [[:ToggleTerm direction=horizontal<CR>]] },
--         { 't>', [[<cmd>lua require'toggleterm'.toggle_all('close')<CR>]] },
--         -- buffer navigation
--         { 'v>', require('bufferhandler').split },
--         {
--           'x>',
--           function()
--             require('bufferhandler').split { open_right = false }
--           end,
--         },
--         {
--           '1>',
--           function()
--             require('bufferhandler').go_to(1)
--           end,
--         },
--         {
--           '2>',
--           function()
--             require('bufferhandler').go_to(2)
--           end,
--         },
--         {
--           '3>',
--           function()
--             require('bufferhandler').go_to(3)
--           end,
--         },
--         {
--           '4>',
--           function()
--             require('bufferhandler').go_to(4)
--           end,
--         },
--         {
--           '5>',
--           function()
--             require('bufferhandler').go_to(5)
--           end,
--         },
--         {
--           '6>',
--           function()
--             require('bufferhandler').go_to(6)
--           end,
--         },
--         {
--           '7>',
--           function()
--             require('bufferhandler').go_to(7)
--           end,
--         },
--         {
--           '8>',
--           function()
--             require('bufferhandler').go_to(8)
--           end,
--         },
--         {
--           '9>',
--           function()
--             require('bufferhandler').go_to(9)
--           end,
--         },
--       },
--     },
--     {
--       '<C-',
--       {
--         -- {
--         --   'n>',
--         --   function()
--         --     require('nvim-tree').toggle()
--         --   end,
--         -- },
--         {
--           't>',
--           function()
--             require('bufferhandler').new()
--           end,
--         },
--         {
--           'w>',
--           function()
--             require('bufferhandler').close()
--           end,
--         },
--         -- { 'p>', [[<cmd>Telescope find_files<CR>]] },
--         -- { 'o>', [[<cmd>Telescope live_grep<CR>]] },
--         -- { 'f>', [[<cmd>Telescope current_buffer_fuzzy_find<CR>]] },
--         -- { 'd>', [[<cmd>Telescope opener<CR>]] },
--         { 'Up>', [[<cmd>lua require"user.utils".events.resize("up")<CR>]] },
--         {
--           'Down>',
--           [[<cmd>lua require"user.utils".events.resize("down")<CR>]],
--         },
--         {
--           'Left>',
--           [[<cmd>lua require"user.utils".events.resize("left")<CR>]],
--         },
--         {
--           'Right>',
--           [[<cmd>lua require"user.utils".events.resize("right")<CR>]],
--         },
--         -- better navigation
--         { 'h>', [[<C-w>h]] },
--         { 'j>', [[<C-w>j]] },
--         { 'k>', [[<C-w>k]] },
--         { 'l>', [[<C-w>l]] },
--         -- editor
--         { 's>', [[:w!<CR>]] },
--         { 'x>', [[<cmd>:nohlsearch<CR>]] },
--         -- { 'q>', '<cmd>lua require"utils".buffer_close()<CR>'}
--       },
--     },
--     -- {
--     --   '<S-',
--     --     { -- shift key
--     --       { 'l>', ':BufferLineMoveNext<CR>' },
--     --       { 'h>', ':BufferLineMovePrev<CR>' }
--     --   }
--     -- },
--     {
--       '<F5>',
--       [[:luafile ~/.config/nvim/init.lua<CR>]],
--       options = { silent = false },
--     },
--   },
-- },
--   {
--     mode = 'v',
--     {
--       -- better indetation
--       { '<', '<gv' },
--       { '>', '>gv' },
--     },
--     -- {
--     --   options = { noremap = false },
--     --   {
--     --     { 'j', '<Plug>(faster_vmove_j)' },
--     --     { 'k', '<Plug>(faster_vmove_k)' },
--     --   },
--     -- },

--     -- visual block mode
--     {
--       mode = 'x',
--       {
--         { 'K', ":move '<-2<CR>gv-gv" },
--         { 'J', ":move '>+1<CR>gv-gv" },
--         {
--           '<A-',
--           {
--             { 'j>', ":m '>+1<CR>gv-gv" },
--             { 'k>', ":m '<-2<CR>gv-gv" },
--           },
--         },
--       },
--     },

--     {
--       mode = 't',
--       {
--         {
--           '<C-',
--           {
--             { 'h>', '<C-\\><C-N><C-w>h' },
--             { 'j>', '<C-\\><C-N><C-w>j' },
--             { 'k>', '<C-\\><C-N><C-w>k' },
--             { 'l>', '<C-\\><C-N><C-w>l' },
--           },
--         },
--       },
--     },
--   }
