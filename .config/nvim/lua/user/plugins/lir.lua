local lir = require 'lir'
local actions = require 'lir.actions'
local mark_actions = require 'lir.mark.actions'
local clipboard_actions = require 'lir.clipboard.actions'

lir.setup {
  show_hidden_files = false,
  ignore = {}, -- { ".DS_Store", "node_modules" } etc.
  devicons = {
    enable = true,
    highlight_dirname = true,
  },
  mappings = {
    ['l'] = function()
      -- TODO: open xlsx and pdf file
      -- local ctx = lir.get_context()
      -- local current = ctx:current()
      -- -- vim.print(filepath)
      -- if not current.is_dir and vim.endswith(current.fullpath, '.xlsx') then
      --   vim.print({vim.fn.shellescape(current.fullpath), current})
      --   vim.fn.system('open ' .. vim.fn.shellescape(current.fullpath))
      --   return
      -- end
      -- vim.api.nvim
      actions.edit()
    end,
    ['<C-s>'] = actions.split,
    ['<C-v>'] = actions.vsplit,
    -- ['<C-t>'] = actions.tabedit,

    ['h'] = actions.up,
    ['q'] = actions.quit,

    ['K'] = actions.mkdir,
    ['N'] = actions.newfile,
    ['R'] = actions.rename,
    -- ['@'] = actions.cd,
    ['Y'] = actions.yank_path,
    ['.'] = actions.toggle_show_hidden,
    ['D'] = actions.delete,

    ['J'] = function()
      mark_actions.toggle_mark()
      vim.cmd 'normal! j'
    end,
    ['C'] = clipboard_actions.copy,
    ['X'] = clipboard_actions.cut,
    ['P'] = clipboard_actions.paste,
  },
  float = {
    winblend = 0,
    curdir_window = {
      enable = false,
      highlight_dirname = false,
    },

    -- -- You can define a function that returns a table to be passed as the third
    -- -- argument of nvim_open_win().
    -- win_opts = function()
    --   local width = math.floor(vim.o.columns * 0.8)
    --   local height = math.floor(vim.o.lines * 0.8)
    --   return {
    --     border = {
    --       "+", "─", "+", "│", "+", "─", "+", "│",
    --     },
    --     width = width,
    --     height = height,
    --     row = 1,
    --     col = math.floor((vim.o.columns - width) / 2),
    --   }
    -- end,
  },
  hide_cursor = false,
}

-- vim.api.nvim_create_autocmd({ 'FileType' }, {
--   pattern = { 'lir' },
--   callback = function()
--     -- use visual mode
--     vim.api.nvim_buf_set_keymap(
--       0,
--       'x',
--       'J',
--       ':<C-u>lua require"lir.mark.actions".toggle_mark("v")<CR>',
--       { noremap = true, silent = true }
--     )

--     -- echo cwd
--     vim.api.nvim_echo({ { vim.fn.expand '%:p', 'Normal' } }, false, {})
--   end,
-- })

vim.keymap.set('n', '<leader>n', function()
  vim.cmd.edit '.'
end, { desc = 'Open Lir' })

vim.keymap.set('n', '-', function()
  vim.cmd.edit '%:h'
end, { desc = 'Open Lir parent dir of buffer' })
