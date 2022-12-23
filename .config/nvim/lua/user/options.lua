vim.g.mapleader = ','
vim.g.maplocalleader = ','

-- Neovide GUI
vim.opt.guifont = 'JetBrainsMono Nerd Font:h8'

vim.opt.showtabline = 2

vim.opt.shortmess = {
  I = true,
  t = true,
  A = true,
  o = true,
  O = false,
  T = true,
  f = true,
  F = true,
  s = true,
  c = true,
  W = true,
}

vim.opt.termguicolors = true

vim.opt.timeout = true
vim.opt.timeoutlen = 500
vim.opt.updatetime = 1000

vim.opt.conceallevel = 0 -- So that I can see `` in markdown files

vim.opt.relativenumber = true
vim.opt.cursorline = false

vim.opt.breakindent = true
-- vim.opt.showbreak = [[↪ ]] -- Make it so that long lines wrap smartly
vim.opt.linebreak = true
vim.opt.signcolumn = 'yes'

-- Indentation
vim.opt.wrap = true
vim.opt.autoindent = true
vim.opt.tabstop = 4 -- 1 tab == 4 spaces
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.shiftround = true
vim.opt.smartindent = true
vim.opt.smartcase = true

vim.opt.list = true
vim.opt.listchars = {
  eol = nil, --'↴',
  tab = '» ',
  extends = '›',
  precedes = '‹',
  trail = '•',
}

vim.opt.fillchars = {
  eob = '~',
  foldopen = '▾',
  foldsep = '│',
  foldclose = '▸',
  msgsep = ' ',
}

vim.opt.inccommand = 'nosplit' -- incremental live completion
vim.opt.number = true
vim.opt.hidden = true
vim.opt.mouse = 'a'
vim.opt.mousefocus = true

vim.opt.swapfile = false
vim.opt.backup = true
vim.opt.writebackup = true
vim.opt.backupdir = vim.fn.stdpath 'data' .. '/backup'
vim.opt.undofile = true
vim.o.undodir = vim.fn.stdpath 'cache' .. '/undo'

vim.opt.ignorecase = true
vim.opt.incsearch = true
vim.opt.encoding = 'utf-8'
vim.opt.clipboard = 'unnamedplus'
vim.opt.pumheight = 15
vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }

vim.opt.equalalways = false

vim.opt.formatoptions = vim.opt.formatoptions
  + {
    t = false, -- Auto-wrap text using textwidth
    c = true, -- Auto-wrap comment using textwidth
    r = true, -- Automatically add comment leader after hitting <Enter> in insert mode
    o = false, -- O and o, don't continue comments
    q = true, -- Allow formatting comments w/ gq
    a = false, -- Automatic formatting of paragraphs.
    n = true, -- Indent past the formatlistpat, not underneath it.
    ['2'] = true, -- use indent from 2nd line of a paragraph
    j = true, -- Auto-remove comments if possible.
  }

vim.opt.shada = { '!', "'1000", '<50', 's10', 'h' }

vim.opt.spell = false
vim.opt.spelllang = { 'pt' }
vim.opt.spelloptions = { 'camel' }
vim.opt.spellfile = {
  en = vim.fn.stdpath 'config' .. '/spell/en.utf-8.add',
  pt = vim.fn.stdpath 'config' .. '/spell/pt.utf-8.add',
}

vim.opt.showmode = false
vim.opt.showcmd = false
vim.opt.showmatch = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.cmdheight = 0
vim.opt.laststatus = 3

vim.opt.title = true
vim.opt.scrolloff = 10
vim.opt.confirm = false
vim.opt.autowrite = false -- enable auto write when change buffer
vim.opt.joinspaces = false -- No double spaces with join after a dot

vim.opt.wildmenu = true
vim.opt.wildoptions = 'pum'
vim.opt.wildmode = 'longest:full,full'
vim.opt.wildignorecase = true
vim.opt.wildignore = vim.opt.wildignore
  + {
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
    '*.*~',
    '*~ ',
    '*.swp',
    '.lock',
    '.DS_Store',
    'tags.lock',
  }

-- Faster grep alternative
if vim.fn.executable 'rg' == 1 then
  vim.opt.grepprg = [[rg --glob "!.git" --no-heading --vimgrep --hidden]]
  vim.opt.grepformat = vim.opt.grepformat ^ { '%f:%l:%c:%m' }
end
