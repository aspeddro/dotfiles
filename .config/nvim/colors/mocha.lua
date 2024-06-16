local colors = require 'user.modules.colors'

local C = colors.palletes.mocha

local light = false

if light then
  C = colors.palletes.latte
end

local M = {}

M.base = {
  ColorColumn = { bg = C.surface0 }, -- used for the columns set with 'colorcolumn'
  Conceal = { fg = C.overlay1 }, -- placeholder characters substituted for concealed text (see 'conceallevel')
  Cursor = { fg = C.base, bg = C.text }, -- character under the cursor
  lCursor = { fg = C.base, bg = C.text }, -- the character under the cursor when |language-mapping| is used (see 'guicursor')
  CursorIM = { fg = C.base, bg = C.text }, -- like Cursor, but used when in IME mode |CursorIM|
  CursorColumn = { bg = C.mantle }, -- Screen-column at the cursor, when 'cursorcolumn' is set.
  CursorLine = {
    bg = colors.darken(C.surface0, 0.64, C.base),
  }, -- Screen-line at the cursor, when 'cursorline' is set.  Low-priority if forecrust (ctermfg OR guifg) is not set.
  Directory = { fg = C.blue }, -- directory names (and other special names in listings)
  EndOfBuffer = { fg = C.base }, -- filler lines (~) after the end of the buffer.  By default, this is highlighted like |hl-NonText|.
  ErrorMsg = { fg = C.red, bold = true, italic = true }, -- error messages on the command line
  VertSplit = { fg = C.crust }, -- the column separating vertically split windows
  Folded = {
    fg = C.blue,
    bg = C.surface1,
  }, -- line used for closed folds
  FoldColumn = { fg = C.overlay0 }, -- 'foldcolumn'
  SignColumn = { fg = C.surface1 }, -- column where |signs| are displayed
  SignColumnSB = { bg = C.crust, fg = C.surface1 }, -- column where |signs| are displayed
  Substitute = { bg = C.surface1, fg = C.pink }, -- |:substitute| replacement text highlighting
  LineNr = { fg = C.surface1 }, -- Line number for ":number" and ":#" commands, and when 'number' or 'relativenumber' option is set.
  CursorLineNr = { fg = C.lavender }, -- Like LineNr when 'cursorline' or 'relativenumber' is set for the cursor line. highlights the number in numberline.
  MatchParen = { fg = C.peach, bg = C.surface1, bold = true }, -- The character under the cursor or just before it, if it is a paired bracket, and its match. |pi_paren.txt|
  ModeMsg = { fg = C.text, bold = true }, -- 'showmode' message (e.g., "-- INSERT -- ")
  -- MsgArea = { fg = C.text }, -- Area for messages and cmdline, don't set this highlight because of https://github.com/neovim/neovim/issues/17832
  MsgSeparator = {}, -- Separator for scrolled messages, `msgsep` flag of 'display'
  MoreMsg = { fg = C.blue }, -- |more-prompt|
  NonText = { fg = C.overlay0 }, -- '@' at the end of the window, characters from 'showbreak' and other characters that do not really exist in the text (e.g., ">" displayed when a double-wide character doesn't fit at the end of the line). See also |hl-EndOfBuffer|.
  Normal = { fg = C.text, bg = C.base }, -- normal text
  NormalNC = {
    fg = C.text,
    bg = C.base,
  }, -- normal text in non-current windows
  NormalSB = { fg = C.text, bg = C.crust }, -- normal text in non-current windows
  NormalFloat = {
    fg = C.text,
    bg = C.mantle,
  }, -- Normal text in floating windows.
  FloatBorder = { fg = C.blue },
  FloatTitle = { fg = C.subtext0 }, -- Title of floating windows
  Pmenu = {
    bg = colors.darken(C.surface0, 0.8, C.crust),
    fg = C.overlay2,
  }, -- Popup menu: normal item.
  PmenuSel = { bg = C.surface1, bold = true }, -- Popup menu: selected item.
  PmenuSbar = { bg = C.surface1 }, -- Popup menu: scrollbar.
  PmenuThumb = { bg = C.overlay0 }, -- Popup menu: Thumb of the scrollbar.
  Question = { fg = C.blue }, -- |hit-enter| prompt and yes/no questions
  QuickFixLine = { bg = C.surface1, bold = true }, -- Current |quickfix| item in the quickfix window. Combined with |hl-CursorLine| when the cursor is there.
  Search = { bg = colors.darken(C.sky, 0.30, C.base), fg = C.text }, -- Last search pattern highlighting (see 'hlsearch').  Also used for similar items that need to stand out.
  IncSearch = { bg = colors.darken(C.sky, 0.90, C.base), fg = C.mantle }, -- 'incsearch' highlighting; also used for the text replaced with ":s///c"
  CurSearch = { bg = 'none', fg = 'none' }, -- 'cursearch' highlighting: highlights the current search you're on differently
  SpecialKey = { link = 'NonText' }, -- Unprintable characters: text displayed differently from what it really is.  But not 'listchars' textspace. |hl-Whitespace|
  SpellBad = { sp = C.red, undercurl = true }, -- Word that is not recognized by the spellchecker. |spell| Combined with the highlighting used otherwise.
  SpellCap = { sp = C.yellow, undercurl = true }, -- Word that should start with a capital. |spell| Combined with the highlighting used otherwise.
  SpellLocal = { sp = C.blue, undercurl = true }, -- Word that is recognized by the spellchecker as one that is used in another region. |spell| Combined with the highlighting used otherwise.
  SpellRare = { sp = C.green, undercurl = true }, -- Word that is recognized by the spellchecker as one that is hardly ever used.  |spell| Combined with the highlighting used otherwise.
  StatusLine = {
    fg = C.text,
    bg = C.base,
  }, -- status line of current window
  StatusLineNC = {
    fg = C.surface1,
    bg = C.mantle,
  }, -- status lines of not-current windows Note: if this is equal to "StatusLine" Vim will use "^^^" in the status line of the current window.
  TabLine = { bg = C.mantle, fg = C.surface1 }, -- tab pages line, not active tab page label
  TabLineFill = {}, -- tab pages line, where there are no labels
  TabLineSel = { fg = C.green, bg = C.surface1 }, -- tab pages line, active tab page label
  Title = { fg = C.blue, bold = true }, -- titles for output from ":set all", ":autocmd" etc.
  Visual = { bg = C.surface1, bold = false }, -- Visual mode selection
  VisualNOS = { bg = C.surface1, bold = false }, -- Visual mode selection when vim is "Not Owning the Selection".
  WarningMsg = { fg = C.yellow }, -- warning messages
  Whitespace = { fg = C.surface1 }, -- "nbsp", "space", "tab" and "trail" in 'listchars'
  WildMenu = { bg = C.overlay0 }, -- current match in 'wildmenu' completion
  WinBar = { fg = C.rosewater },
  WinBarNC = { link = 'WinBar' },
  WinSeparator = { fg = C.surface1 },
}

M.syntax = {
  Comment = { fg = C.overlay0, italic = true }, -- just comments
  SpecialComment = { link = 'Special' }, -- special things inside a comment
  Constant = { fg = C.peach }, -- (preferred) any constant
  String = { fg = C.green }, -- a string constant: "this is a string"
  Character = { fg = C.teal }, --  a character constant: 'c', '\n'
  Number = { fg = C.peach }, --   a number constant: 234, 0xff
  Float = { link = 'Number' }, --    a floating point constant: 2.3e10
  Boolean = { fg = C.peach }, --  a boolean constant: TRUE, false
  Identifier = { fg = C.flamingo }, -- (preferred) any variable name
  Function = { fg = C.blue }, -- function name (also: methods for classes)
  Statement = { fg = C.mauve }, -- (preferred) any statement
  Conditional = { fg = C.mauve }, --  if, then, else, endif, switch, etc.
  Repeat = { fg = C.mauve }, --   for, do, while, etc.
  Label = { fg = C.sapphire }, --    case, default, etc.
  Operator = { fg = C.sky }, -- "sizeof", "+", "*", etc.
  Keyword = { fg = C.mauve }, --  any other keyword
  Exception = { fg = C.mauve }, --  try, catch, throw

  PreProc = { fg = C.pink }, -- (preferred) generic Preprocessor
  Include = { fg = C.mauve }, --  preprocessor #include
  Define = { link = 'PreProc' }, -- preprocessor #define
  Macro = { fg = C.mauve }, -- same as Define
  PreCondit = { link = 'PreProc' }, -- preprocessor #if, #else, #endif, etc.

  StorageClass = { fg = C.yellow }, -- static, register, volatile, etc.
  Structure = { fg = C.yellow }, --  struct, union, enum, etc.
  Special = { fg = C.pink }, -- (preferred) any special symbol
  Type = { fg = C.yellow }, -- (preferred) int, long, char, etc.
  Typedef = { link = 'Type' }, --  A typedef
  SpecialChar = { link = 'Special' }, -- special character in a constant
  Tag = { fg = C.lavender, bold = true }, -- you can use CTRL-] on this
  Delimiter = { fg = C.overlay2 }, -- character that needs attention
  Debug = { link = 'Special' }, -- debugging statements

  Underlined = { underline = true }, -- (preferred) text that stands out, HTML links
  Bold = { bold = true },
  Italic = { italic = true },
  -- ("Ignore", below, may be invisible...)
  -- Ignore = { }, -- (preferred) left blank, hidden  |hl-Ignore|

  Error = { fg = C.red }, -- (preferred) any erroneous construct
  Todo = { bg = C.flamingo, fg = C.base, bold = true }, -- (preferred) anything that needs extra attention; mostly the keywords TODO FIXME and XXX
  qfLineNr = { fg = C.yellow },
  qfFileName = { fg = C.blue },
  htmlH1 = { fg = C.pink, bold = true },
  htmlH2 = { fg = C.blue, bold = true },
  -- mkdHeading = { fg = C.peach, style = { "bold" } },
  -- mkdCode = { bg = C.terminal_black, fg = C.text },
  mkdCodeDelimiter = { bg = C.base, fg = C.text },
  mkdCodeStart = { fg = C.flamingo, bold = true },
  mkdCodeEnd = { fg = C.flamingo, bold = true },
  -- mkdLink = { fg = C.blue, style = { "underline" } },

  -- debugging
  debugPC = { bg = C.crust }, -- used for highlighting the current line in terminal-debug
  debugBreakpoint = { bg = C.base, fg = C.overlay0 }, -- used for breakpoint colors in terminal-debug
  -- illuminate
  illuminatedWord = { bg = C.surface1 },
  illuminatedCurWord = { bg = C.surface1 },
  -- diff
  diffAdded = { fg = C.green },
  diffRemoved = { fg = C.red },
  diffChanged = { fg = C.blue },
  diffOldFile = { fg = C.yellow },
  diffNewFile = { fg = C.peach },
  diffFile = { fg = C.blue },
  diffLine = { fg = C.overlay0 },
  diffIndexLine = { fg = C.teal },
  DiffAdd = { bg = colors.darken(C.green, 0.18, C.base) }, -- diff mode: Added line |diff.txt|
  DiffChange = { bg = colors.darken(C.blue, 0.07, C.base) }, -- diff mode: Changed line |diff.txt|
  DiffDelete = { bg = colors.darken(C.red, 0.18, C.base) }, -- diff mode: Deleted line |diff.txt|
  DiffText = { bg = colors.darken(C.blue, 0.30, C.base) }, -- diff mode: Changed text within a changed line |diff.txt|
  -- NeoVim
  healthError = { fg = C.red },
  healthSuccess = { fg = C.teal },
  healthWarning = { fg = C.yellow },
  -- misc

  -- glyphs
  GlyphPalette1 = { fg = C.red },
  GlyphPalette2 = { fg = C.teal },
  GlyphPalette3 = { fg = C.yellow },
  GlyphPalette4 = { fg = C.blue },
  GlyphPalette6 = { fg = C.teal },
  GlyphPalette7 = { fg = C.text },
  GlyphPalette9 = { fg = C.red },

  -- rainbow
  rainbow1 = { fg = C.red },
  rainbow2 = { fg = C.peach },
  rainbow3 = { fg = C.yellow },
  rainbow4 = { fg = C.green },
  rainbow5 = { fg = C.sapphire },
  rainbow6 = { fg = C.lavender },
}

for _, value in pairs(M) do
  for group, opts in pairs(value) do
    vim.api.nvim_set_hl(0, group, opts)
  end
end
