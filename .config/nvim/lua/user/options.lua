-- https://github.com/kyazdani42/nvim-tree.lua/issues/549
-- vim.g.nvim_tree_show_icons = {
--   git = 0,
--   folders = 1, -- or 0,
--   files = 1, -- or 0,
--   folder_arrows = 1, -- or 0
-- }

-- vim.opt.shortmess:append 'cA' -- ?
vim.opt.shortmess = {
  I = true,
  t = true, -- truncate file messages at start
  A = true, -- ignore annoying swap file messages
  o = false, -- file-read message overwrites previous
  O = false, -- file-read message overwrites previous
  T = true, -- truncate non-file messages in middle
  f = true, -- (file x of x) instead of just (x of x
  F = true, -- Don't give file info when editing a file, NOTE: this breaks autocommand messages
  s = true,
  c = true,
  W = true, -- Don't show [w] or written when writing
}

vim.opt.termguicolors = true
-- vim.opt.timeoutlen = 200
-- vim.opt.updatetime = 400
vim.opt.updatetime = 1000
vim.opt.conceallevel = 0 -- So that I can see `` in markdown files

-- Window Options
vim.opt.relativenumber = true
vim.opt.cursorline = not true -- enable cursorline, require by modes package
-- vim.opt.cursorlineopt = 'screenline,number'
vim.opt.breakindent = false -- enable breakindent
-- vim.opt.showbreak = [[↪ ]] -- Make it so that long lines wrap smartly
vim.opt.linebreak = false

vim.wo.signcolumn = 'yes'

vim.opt.wrap = false
vim.opt.wrapmargin = 2
-- vim.opt.textwidth = 80

vim.opt.autoindent = true
-- vim.opt.cindent = true
-- vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
-- vim.opt.expandtab = true
-- vim.opt.softtabstop = 2
-- vim.opt.smarttab = true
-- vim.opt.shiftround = true
vim.opt.smartindent = true
-- vim.opt.smartcase = true

vim.opt.list = false
-- FIXME: raise a error
-- vim.opt.listchars = {
--   eol = '⏎ ',
--   tab = '│ ',
--   extends = '›', -- Alternatives: … »
--   precedes = '‹', -- Alternatives: … «
--   trail = '•', -- BULLET (U+2022, UTF-8: E2 80 A2)
-- }

vim.opt.inccommand = 'nosplit' -- incremental live completion
vim.opt.number = true -- make line number default
vim.opt.wrap = true
vim.opt.hidden = true -- do not save when switching buffers
vim.opt.mouse = 'a' -- enable mouse normal mode
vim.opt.mousefocus = true

vim.opt.undofile = true -- Save undo history
-- vim.opt.undodir = vim.fn.expand '~' .. '/.local/share/nvim/undo'
vim.o.undodir = vim.fn.stdpath 'cache' .. '/undo'
vim.opt.ignorecase = true -- enable case insensitive
vim.opt.incsearch = true
vim.opt.encoding = 'utf-8'
vim.opt.clipboard = 'unnamedplus'
vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }
-- vim.o.completeopt = "menu,preview,noinsert"
-- vim.o.completeopt = "menuone,noselect"
-- vim.opt.completeopt = { "menu", "menuone", "noselect" }

-- vim.opt.dictionary:append("/usr/share/dict/words")

vim.opt.formatoptions = vim.opt.formatoptions
  - 'a' -- Auto formatting is BAD.
  - 't' -- Don't auto format my code. I got linters for that.
  + 'c' -- In general, I like it when comments respect textwidth
  + 'q' -- Allow formatting comments w/ gq
  - 'o' -- O and o, don't continue comments
  + 'r' -- But do continue when pressing enter.
  + 'n' -- Indent past the formatlistpat, not underneath it.
  + 'j' -- Auto-remove comments if possible.
  - '2' -- I'm not in gradeschool anymore

-- vim.opt.formatoptions = {
--   ['1'] = true,
--   ['2'] = true, -- Use indent from 2nd line of a paragraph
--   q = true, -- continue comments with gq"
--   c = true, -- Auto-wrap comments using textwidth
--   r = true, -- Continue comments when pressing Enter
--   n = true, -- Recognize numbered lists
--   t = false, -- autowrap lines using text width value
--   j = true, -- remove a comment leader when joining lines.
--   -- Only break if the line was not longer than 'textwidth' when the insert
--   -- started and only at a white character that has been entered during the
--   -- current insert command.
--   l = false,
--   v = true,
-- }

vim.opt.spell = false
-- vim.opt.spelllang = { 'pt_BR' }

-- vim.opt.fillchars = {
--   vert = '▕', -- alternatives │
--   fold = ' ',
--   eob = ' ', -- suppress ~ at EndOfBuffer
--   diff = '╱', -- alternatives = ⣿ ░ ─
--   msgsep = '‾',
--   foldopen = '▾',
--   foldsep = '│',
--   foldclose = '▸',
-- }

vim.opt.showmode = false
vim.opt.showcmd = false
vim.opt.showmatch = true -- show matching brackets when text indicator is over them
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.pumheight = 10
vim.opt.cmdheight = 1
vim.opt.ruler = false -- ?
vim.o.laststatus = 2 -- ?

vim.opt.title = true
vim.opt.scrolloff = 5 -- always ten lines below my cursor
vim.opt.swapfile = false
vim.opt.confirm = true -- confirm to save changes before exiting modified buffer
vim.opt.autowrite = false -- enable auto write when change buffer
vim.opt.joinspaces = false -- No double spaces with join after a dot
vim.opt.sidescrolloff = 8 -- Columns of context
vim.opt.undolevels = 10000

-- Wild Menu
-- vim.opt.wildoptions = 'pum'
vim.opt.wildmenu = true -- Command line completion mode
vim.opt.wildmode = 'longest:full,full' -- Command-line completion mode
vim.opt.wildignorecase = true
-- NOTE: not working
vim.opt.wildignore = {
  '*.aux',
  '*.out',
  '*.toc',
  '*.o',
  '*.obj',
  '*.dll',
  '*.jar',
  '*.pyc',
  '*.rbc',
  '*.class',
  '*.gif',
  '*.ico',
  '*.jpg',
  '*.jpeg',
  '*.png',
  '*.avi',
  '*.wav',
  -- Temp/System
  '*.*~',
  '*~ ',
  '*.swp',
  '.lock',
  '.DS_Store',
  'tags.lock',
}
vim.opt.formatoptions:remove { 'o', 'c', 'r' }
-- vim.cmd [[set guicursor=i:ver1]]
-- vim.cmd [[set guicursor+=a:blinkon1]]
-- vim.opt.guicursor = {
--   [[n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50]],
--   [[a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor]],
--   [[sm:block-blinkwait175-blinkoff150-blinkon175]],
-- }

-- Faster grep alternatives if possible
vim.o.grepprg = [[rg --glob "!.git" --no-heading --vimgrep --hidden]]
-- vim.opt.grepformat = vim.opt.grepformat ^ { '%f:%l:%c:%m' }

-- Status Line
-- '%f%m%=%l:%c'
-- opt.statusline = "[%{mode()}] %<%F %h%m%r %= %l/%L:%c [%p%%]"
-- vim.opt.statusline = ' %F %R %M%=%l:%c %Y '

-- vim.opt.showtabline = 2
-- vim.opt.tabline = '%t'

-- auto session plugin
-- stylua: ignore
vim.opt.sessionoptions = 'blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal'
