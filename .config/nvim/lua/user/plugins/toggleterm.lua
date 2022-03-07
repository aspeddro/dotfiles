-- require('toggleterm').setup {
--   -- size can be a number or function which is passed the current terminal
--   -- size = 20,
--   size = function(term)
--     if term.direction == 'horizontal' then
--       return 15
--     elseif term.direction == 'vertical' then
--       return vim.o.columns * 0.4
--     end
--   end,
--   open_mapping = [[<A-l>]], -- Alt + l, toogle terminal
--   hide_numbers = true, -- hide the number column in toggleterm buffers
--   shade_filetypes = {},
--   shade_terminals = true,
--   -- shading_factor = '<number>', -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
--   start_in_insert = true,
--   insert_mappings = false, -- whether or not the open mapping applies in insert mode
--   persist_size = true,
--   -- direction = 'vertical' | 'horizontal' | 'window' | 'float',
--   close_on_exit = true, -- close the terminal window when the process exits
--   shell = vim.o.shell, -- change the default shell,
-- }

-- require('toggleterm').setup { shade_terminals = true }
local Term = require('toggleterm.terminal').Terminal:new {
  on_open = function(term)
    vim.cmd 'startinsert!'

    require('mapx').tnoremap('<esc>', [[<C-\><C-n>]], { buffer = term.bufnr })
  end,
}

require('mapx').nnoremap('<a-l>', function()
  Term:toggle()
end)
