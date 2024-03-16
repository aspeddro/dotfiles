-- My version of Material Theme
local colors = require 'user.modules.colors'

local c = colors.palletes.dark

vim.o.background = 'dark'

local M = {}

-- UI Highlights (:h highlight-groups)
M.base = {
  Normal = { fg = c.fg, bg = c.bg },
  -- NormalNC = { fg = c.fg, bg = c.bg_alt }, -- normal text in non-current windows

  NormalFloat = { fg = c.fg, bg = c.gray2 },
  FloatBorder = { fg = c.gray2, bg = c.gray2 },

  SignColumn = { bg = c.bg, fg = c.fg },

  SpellBad = { fg = c.red, underline = true },
  SpellCap = { underline = true },
  SpellLocal = { underline = true },
  SpellRare = { underline = true },

  -- Pop-up Menu
  Pmenu = { fg = '#848484', bg = c.bg },
  PmenuSel = { fg = c.cyan, bg = colors.blend(c.gray, c.bg, 0.3) },
  PmenuSbar = { bg = c.bg },
  PmenuThumb = { bg = c.white, fg = c.orange },

  WildMenu = { fg = c.bg, bg = c.blue },
  Folded = { fg = c.blue, bg = c.bg },
  FoldColumn = { fg = c.blue, bg = c.bg },
  LineNr = { fg = c.comment },

  WinSeparator = { fg = c.gray },

  CursorLine = { bg = c.bg },
  CursorLineNr = { fg = c.gray },
  CursorColumn = { bg = c.bg },
  ColorColumn = { bg = c.bg },
  Cursor = { fg = c.fg, bg = c.none },
  lCursor = { fg = c.fg, bg = c.none },
  CursorIM = { fg = c.fg, bg = c.bg },

  Visual = { bg = colors.blend(c.bg, c.comment, 0.7) },
  VisualNOS = { bg = c.gray1 },

  Title = { fg = '#ff8eeb' },

  DiffText = {
    fg = c.none,
    bg = colors.blend(c.blue, c.bg, 0.1),
    underline = false,
  },
  DiffAdd = {
    fg = c.none,
    bg = colors.blend(c.green, c.bg, 0.1),
    underline = false,
  },
  DiffChange = {
    fg = c.none,
    bg = colors.blend(c.blue, c.bg, 0.1),
    underline = false,
    bold = false,
  },
  DiffDelete = {
    fg = c.none,
    bg = colors.blend(c.red, c.bg, 0.1),
    underline = false,
    bold = false,
  },

  QuickFixLine = { bg = c.bg },

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
  TabLine = { fg = c.gray, bg = c.bg },
  TabLineSel = { fg = c.orange, bg = c.bg },
  TabLineFill = { bg = c.bg },

  -- Status Line
  StatusLine = { link = 'Normal' },
  -- StatusLineNC = { ctermfg = c.none },
  -- StatusLineTerm
  -- StatusLineTermNC

  Substitute = { fg = c.bg, bg = c.blue },
  MoreMsg = { fg = c.cyan },
  Question = { fg = c.cyan },
  EndOfBuffer = { fg = c.comment },

  NonText = { fg = c.comment },
  Whitespace = { fg = c.comment },

  MsgArea = { fg = c.fg, bg = c.bg },
  ModeMsg = { fg = c.fg, bg = c.bg },
  MsgSeparator = { fg = c.fg, bg = c.bg },
  ErrorMsg = { fg = c.red2, bg = c.none },
  WarningMsg = { fg = c.yellow, bg = c.none },

  -- Diagnostics
  DiagnosticError = { fg = c.red2 },
  DiagnosticWarn = { fg = c.yellow },
  DiagnosticInfo = { fg = c.paleblue },
  DiagnosticHint = { fg = c.paleblue },
  DiagnosticUnnecessary = { undercurl = false },
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
  Identifier = { fg = c.fg },
  Function = { fg = c.blue },
  Keyword = { fg = c.purple },
  Conditional = { fg = c.purple },
  Repeat = { fg = c.purple },
  Bold = { bold = true },
  Italic = { italic = true },
  Type = { fg = c.cyan }, -- int, long, char, etc.
  StorageClass = { fg = c.cyan }, -- static, register, volatile, etc.
  Structure = { fg = c.cyan }, -- struct, union, enum, etc.
  Constant = { fg = c.red }, -- any constant
  Character = { fg = c.green, italic = true }, -- any character constant: 'c', '\n'
  Number = { fg = c.orange }, -- a number constant: 5
  Boolean = { fg = c.red }, -- a boolean constant: TRUE, false
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
  ['@variable.builtin'] = { fg = c.blue, italic = true },
  ['@keyword.function'] = { fg = c.orange, italic = true },
  ['@keyword.return'] = { fg = c.purple, italic = true },
  ['@keyword.operator'] = { link = 'Keyword' },
  ['@function.method'] = { fg = c.blue, italic = true },
  ['@annotation'] = { fg = c.pink },
  ['@attribute'] = { fg = c.pink },
  ['@constructor'] = { fg = c.orange },
  ['@keyword.directive'] = { link = 'PreProc' },
  ['@constant'] = { link = 'Constant' },
  ['@constant.comment'] = {
    --[[ c.orange ]]
    fg = '#ff8eeb',
    italic = true,
  },
  ['@constant.builtin'] = { --[[ fg = c.red  ]]
    link = '@constant',
  },
  ['@variable.member'] = { fg = '#ffdfb6' }, -- For fields. -- TEST: #FFD7A3
  ['@property'] = { link = '@variable.member' },
  -- TODO: fund a color for @amespace
  ['@module'] = { --[[ fg = '#FFECB3' ]]
    fg = '#F5A191',
  },
  ['@variable.parameter'] = { fg = c.none },
  -- ['@parameter.reference'] = { link = '@parameter' },
  ['@punctuation.bracket'] = { link = 'Keyword' },
  -- ['@punctuation.special'] = { fg = c.cyan },
  -- ['@punctuation.delimiter'] = { fg = c.cyan },
  ['@string.regexp'] = { fg = c.blue },
  ['@string.escape'] = { fg = c.gray },
  ['@string.special.symbol'] = { fg = c.yellow },
  ['@type.builtin'] = { fg = c.red, italic = true },

  ['@tag'] = { fg = '#ff7597' },
  ['@tag.delimiter'] = { fg = c.cyan },
  ['@tag.attribute'] = { fg = c.yellow },

  ['@markup.heading'] = { link = 'Title' },
  ['@markup.string'] = { bold = true },
  ['@markup.list'] = { fg = c.cyan },
  ['@markup.raw'] = { fg = c.yellow },
  ['@markup.raw.block'] = { link = 'Variable' },
  ['@markup.link.label'] = { fg = c.orange },
  ['@markup.link.url'] = { italic = true },
  -- ['@markup.link'] = { link = 'Underlined' },
  ['@text.math'] = { fg = c.blue },
  ['@markup.link'] = { fg = '#ff6c92', italic = true },
  ['@text.literal'] = { fg = '#6bffb5' },
  ['@text.uri.comment'] = { italic = true },
  ['@string.special.path'] = { italic = true, fg = c.red },
  ['@comment.todo'] = { link = 'Todo' },
  ['@text.danger'] = { link = 'Todo' },

  -- css
  ['@property.css'] = { link = '@variable.member' },

  -- python
  ['@variable.parameter.python'] = { fg = c.yellow },
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

M.tokens = {
  -- semantic tokens
  ['@lsp.type.property'] = { link = '@variable.member' },
  ['@lsp.type.namespace'] = { link = '@module' },
  ['@lsp.type.member'] = { link = '@variable.member' },
  ['@lsp.typemod.enum.declaration'] = { link = 'Type' },
  ['@lsp.typemod.struct.declaration'] = { link = 'Type' },

  -- rescript lsp emit tag as interface
  ['@lsp.type.interface.rescript'] = { link = '@tag' },
}

M.plugins = {
  TelescopeBorder = { fg = c.gray, bg = c.bg },
  TelescopeSelection = { link = 'Identifier' },

  -- NvimTreeNormal = { fg = c.extra.gray, bg = c.bg_alt },
  -- NvimTreeFolderName = { fg = c.fg },
  -- NvimTreeFolderIcon = { fg = c.gray },
  -- NvimTreeOpenedFolderName = { fg = c.cyan },
  -- NvimTreeOpenedFile = { fg = c.cyan },
  NvimTreeWinSeparator = { bg = c.bg, fg = c.bg },

  GitSignsAdd = { fg = colors.blend(c.green, c.bg, 0.5) },
  GitSignsChange = { fg = colors.blend(c.blue, c.bg, 0.5) },
  GitSignsDelete = { fg = colors.blend(c.red, c.bg, 0.5) },
  GitSignsCurrentLineBlame = { link = 'Comment' },
  -- nvim-lspconfig
  -- LspInfoBorder = { link = 'FloatBorder' },
  -- Indent Blank line
  IblIndent = { fg = colors.blend(c.gray, c.bg, 0.3) },
  -- diffview.nvim
  DiffviewNormal = { link = 'NvimTreeNormal' },

  ConflictMarkerBegin = { bg = '#2f7366' },
  ConflictMarkerOurs = { bg = '#2e5049' },
  ConflictMarkerTheirs = { bg = '#344f69' },
  ConflictMarkerEnd = { bg = '#2f628e' },
  ConflictMarkerCommonAncestorsHunk = { bg = '#754a81' },

  -- TSRainbowRed = { fg = c.rainbow[1] },
  -- TSRainbowYellow = { fg = c.rainbow[2] },
  -- TSRainbowBlue = { fg = c.rainbow[3] },
  -- TSRainbowOrange = { fg = c.rainbow[1] },
  -- TSRainbowGreen = { fg = c.rainbow[2] },
  -- TSRainbowViolet = { fg = c.rainbow[3] },
  -- TSRainbowCyan = { fg = c.rainbow[1] },
}

for _, value in pairs(M) do
  for group, opts in pairs(value) do
    vim.api.nvim_set_hl(0, group, opts)
  end
end
