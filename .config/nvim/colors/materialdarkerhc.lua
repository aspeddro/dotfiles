-- My version of Material Theme Darker High Contrast
local c = require 'user.color'

vim.o.background = 'dark'

local M = {}

-- UI Highlights (:h highlight-groups)
M.base = {
  Normal = { fg = c.fg, bg = c.bg },
  -- NormalNC = { fg = c.fg, bg = c.bg_alt }, -- normal text in non-current windows

  NormalFloat = { bg = c.bg, fg = c.fg },
  FloatBorder = { fg = c.line_number, bg = c.none },

  SignColumn = { bg = c.bg, fg = c.fg },

  SpellBad = { fg = c.red, underline = true },
  SpellCap = { underline = true },
  SpellLocal = { underline = true },
  SpellRare = { underline = true },

  -- Pop-up Menu
  Pmenu = { fg = c.text_pop_menu, bg = c.bg_alt },
  PmenuSel = { fg = c.cyan, bg = c.bg_layer },
  PmenuSbar = { bg = c.bg_alt },
  PmenuThumb = { bg = c.white, fg = c.orange },

  WildMenu = { fg = c.bg_alt, bg = c.blue },
  Folded = { fg = c.blue, bg = c.bg_alt },
  FoldColumn = { fg = c.blue, bg = c.bg_alt },
  LineNr = { fg = c.line_number },

  WinSeparator = { fg = c.line_number },

  CursorLine = { bg = c.bg_alt },
  CursorLineNr = { fg = c.line_number_highlight },
  CursorColumn = { bg = c.bg_alt },
  ColorColumn = { bg = c.bg_alt },
  Cursor = { fg = c.fg, bg = c.none },
  lCursor = { fg = c.fg, bg = c.none },
  CursorIM = { fg = c.fg, bg = c.bg },

  Visual = { bg = c.selection },
  VisualNOS = { bg = c.selection },

  Title = { fg = c.blue },

  DiffText = { fg = c.none, bg = c.diff_change, underline = false },
  DiffAdd = { fg = c.none, bg = c.diff_add, underline = false },
  DiffChange = {
    fg = c.none,
    bg = c.diff_change,
    underline = false,
    bold = false,
  },
  DiffDelete = {
    fg = c.none,
    bg = c.diff_delete,
    underline = false,
    bold = false,
  },

  QuickFixLine = { bg = c.bg_alt },

  MatchParen = { bg = c.gray },

  Terminal = { fg = c.fg, bg = c.bg },
  TermCursor = { fg = c.fg, bg = c.fg },
  TermCursorNC = { fg = c.fg, bg = c.bg },

  Conceal = { fg = c.red },
  Directory = { fg = c.blue },
  SpecialKey = { fg = c.blue, bold = true },

  -- Search
  Search = { fg = c.none, bg = c.gray },
  IncSearch = { bg = c.gray },

  -- Tabs
  TabLine = { fg = c.gray, bg = c.bg_alt },
  TabLineSel = { fg = c.orange, bg = c.bg_alt },
  TabLineFill = { bg = c.bg },

  -- Status Line
  StatusLine = { link = 'Normal' },
  -- StatusLineNC = { ctermfg = c.none },
  -- StatusLineTerm
  -- StatusLineTermNC

  Substitute = { fg = c.bg_alt, bg = c.blue },
  MoreMsg = { fg = c.cyan },
  Question = { fg = c.cyan },
  EndOfBuffer = { fg = c.line_number },

  NonText = { fg = c.line_number },
  Whitespace = { fg = c.line_number },

  MsgArea = { fg = c.fg, bg = c.bg },
  ModeMsg = { fg = c.fg, bg = c.bg },
  MsgSeparator = { fg = c.fg, bg = c.bg },
  ErrorMsg = { fg = c.error, bg = c.none },
  WarningMsg = { fg = c.yellow, bg = c.none },

  -- Diagnostics
  DiagnosticError = { fg = c.error },
  DiagnosticWarn = { fg = c.yellow },
  DiagnosticInfo = { fg = c.paleblue },
  DiagnosticHint = { fg = c.paleblue },
  DiagnosticVirtualTextHint = { fg = c.gray },

  DiagnosticFloatingHint = { fg = c.fg },

  DiagnosticUnderlineError = { fg = c.none, underline = true },
  DiagnosticUnderlineWarn = { fg = c.none, underline = false },
  DiagnosticUnderlineInfo = { fg = c.none, underline = false },
  DiagnosticUnderlineHint = { fg = c.none, underline = false },
}

-- Syntax items (:h group-name)
M.syntax = {
  Comment = { fg = c.comment },
  Variable = { fg = c.fg }, -- #D6D6D6
  String = { fg = c.green },
  Identifier = { fg = c.blue },
  Function = { fg = c.blue },
  Keyword = { fg = c.purple },
  Conditional = { fg = c.purple },
  Repeat = { fg = c.purple },
  Bold = { bold = true },
  Italic = { italic = true },
  Type = { fg = c.cyan }, -- int, long, char, etc.
  StorageClass = { fg = c.cyan }, -- static, register, volatile, etc.
  Structure = { fg = c.puple }, -- struct, union, enum, etc.
  Constant = { fg = c.red, italic = true }, -- any constant
  Character = { fg = c.green, italic = true }, -- any character constant: 'c', '\n'
  Number = { fg = c.orange }, -- a number constant: 5
  Boolean = { fg = c.orange }, -- a boolean constant: TRUE, false
  Float = { fg = c.orange }, -- a floating point constant: 2.3e10
  Statement = { fg = c.purple }, -- any statement
  Label = { fg = c.purple }, -- case, default, etc.
  Operator = { fg = c.cyan }, -- sizeof", "+", "*", etc.
  Exception = { fg = c.red }, -- try, catch, throw
  PreProc = { fg = c.purple, italic = true }, -- generic Preprocessor
  Include = { fg = c.purple }, -- preprocessor #include
  Define = { fg = c.orange }, -- preprocessor #define
  Macro = { fg = c.blue, italic = true }, -- same as Define
  -- Typedef = { fg = c.red }, -- A typedef
  PreCondit = { fg = c.cyan }, -- preprocessor #if, #else, #endif, etc.
  Special = { fg = c.blue, italic = true }, -- any special symbol
  SpecialChar = { fg = '#d7e5c2', italic = true }, -- special character in a constant
  Tag = { fg = c.red }, -- you can use CTRL-] on this
  Delimiter = { fg = c.fg }, -- character that needs attention like , or .
  SpecialComment = { fg = c.gray }, -- special things inside a comment
  Debug = { fg = c.red }, -- debugging statements
  Underlined = { fg = c.red, bg = c.none, underline = true }, -- text that stands out, HTML links
  Ignore = { fg = c.red }, -- left blank, hidden
  Error = { underline = true },
  Todo = { fg = c.yellow, bg = c.none, bold = true }, -- anything that needs extra attention; mostly the keywords TODO FIXME and XXX
}

M.treesitter = {
  ['@variable'] = { link = 'Variable' },
  ['@keyword.function'] = { fg = c.orange, italic = true },
  ['@keyword.return'] = { fg = c.purple, italic = true },
  ['@keyword.operator'] = { link = 'Keyword' },
  ['@method'] = { fg = c.blue, italic = true },
  ['@annotation'] = { fg = c.pink },
  ['@attribute'] = { fg = c.pink },
  ['@constructor'] = { fg = c.orange },
  ['@prepoc'] = { link = 'PreProc' },
  ['@constant'] = { fg = c.orange, italic = true },
  ['@constant.builtin'] = { fg = c.red },
  ['@field'] = { fg = '#ffdfb6' }, -- For fields. -- TEST: #FFD7A3
  ['@property'] = { link = '@field' },
  -- TODO: fund a color for @amespace
  ['@namespace'] = { fg = '#FFECB3' },
  ['@parameter'] = { fg = c.yellow },
  ['@parameter.reference'] = { link = '@parameter' },
  ['@punctuation.bracket'] = { fg = c.rainbow[1]},
  ['@punctuation.special'] = { fg = c.cyan },
  ['@string.regex'] = { fg = c.blue },
  ['@string.espace'] = { fg = c.gray },
  ['@symbol'] = { fg = c.yellow },
  ['@type.builtin'] = { fg = c.red, italic = true },
  ['@tag'] = { fg = '#ff7597' },
  ['@tag.delimiter'] = { fg = c.cyan },
  ['@tag.attribute'] = { fg = c.yellow },
  ['@text.title'] = { link = 'Title' },
  ['@text.math'] = { fg = c.blue },
  ['@text.reference'] = { fg = '#ff6c92', italic = true },
  ['@text.literal'] = { fg = '#6bffb5' },
  ['@text.note'] = { link = 'Todo' },
  ['@text.danger'] = { link = 'Todo' },
}

---@see h lsp-highlight
M.lsp = {
  LspReferenceText = { fg = c.none, bg = '#333333' },
  LspReferenceRead = { link = 'LspReferenceText' },
  LspReferenceWrite = { link = 'LspReferenceText' },
  LspCodeLens = { fg = c.extra.gray },
  LspCodeLensSeparator = { link = 'LspCodeLens' },
  LspSignatureActiveParameter = { link = 'LspCodeLens' },
}

M.plugins = {
  TelescopeBorder = { link = 'FloatBorder' },
  TelescopeSelection = { link = 'Identifier' },

  NvimTreeNormal = { fg = c.fg_sidebar, bg = c.bg_alt },
  NvimTreeFolderName = { fg = c.fg_sidebar },
  NvimTreeFolderIcon = { fg = c.folder_icon },
  NvimTreeOpenedFolderName = { fg = c.cyan },
  NvimTreeOpenedFile = { fg = c.cyan },
  NvimTreeVertsplit = { bg = c.bg_alt, fg = c.bg_alt },

  GitSignsAdd = { fg = c.diff_add },
  GitSignsChange = { fg = c.diff_change },
  GitSignsDelete = { fg = c.diff_delete },
  GitSignsCurrentLineBlame = { link = 'Comment' },
  -- nvim-lspconfig
  LspInfoBorder = { link = 'FloatBorder' },
  -- Indent Blank line
  IndentBlanklineChar = { fg = c.fn.blend(c.gray, c.bg, 0.3) },
  IndentBlanklineContextChar = { fg = c.fn.blend(c.gray, c.bg, 0.99) },
  -- diffview.nvim
  DiffviewNormal = { link = 'NvimTreeNormal' },
}

for _, value in pairs(M) do
  for group, opts in pairs(value) do
    vim.api.nvim_set_hl(0, group, opts)
  end
end
