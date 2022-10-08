-- My version of Material Theme Darker High Contrast
local c = require 'user.color'

vim.o.background = 'dark'

local function hi(group, opts)
  vim.api.nvim_set_hl(0, group, {
    link = opts.link,
    ctermfg = opts.ctermfg,
    ctermbg = opts.ctermbg,
    fg = opts.fg,
    bg = opts.bg,
    sp = opts.sp,
    bold = opts.bold and 1 or 0,
    italic = opts.italic and 1 or 0,
    underline = opts.underline and 1 or 0,
    undercurl = opts.undercurl and 1 or 0,
    -- reverse??
  })
end

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
  VertSplit = { fg = c.line_number, gui = c.none },

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

  QuickFixLine = { fg = c.fg, bg = c.bg_alt },

  MatchParen = { bg = c.gray },

  Terminal = { fg = c.fg, bg = c.bg },
  TermCursor = { fg = c.fg, bg = c.fg },
  TermCursorNC = { fg = c.fg, bg = c.bg },

  Conceal = { fg = c.red },
  Directory = { fg = c.blue },
  SpecialKey = { fg = c.blue, bold = true },

  -- Search
  Search = { fg = c.none, bg = c.gray },
  IncSearch = { bg = c.gray, gui = c.none },

  -- Tabs
  TabLine = { fg = c.gray, bg = c.bg_alt },
  TabLineSel = { fg = c.orange, bg = c.bg_alt },
  TabLineFill = { gui = c.none, bg = c.bg },

  -- Status Line
  StatusLine = { link = 'Normal' }, -- focus
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
  Type = { fg = c.cyan, gui = c.none }, -- int, long, char, etc.
  StorageClass = { fg = c.cyan }, -- static, register, volatile, etc.
  Structure = { fg = c.puple }, -- struct, union, enum, etc.
  Constant = { fg = c.red, italic = true }, -- any constant
  Character = { fg = c.green, italic = true }, -- any character constant: 'c', '\n'
  Number = { fg = c.orange }, -- a number constant: 5
  Boolean = { fg = c.orange }, -- a boolean constant: TRUE, false
  Float = { fg = c.orange }, -- a floating point constant: 2.3e10
  Statement = { fg = c.purple, gui = 'none' }, -- any statement
  Label = { fg = c.purple }, -- case, default, etc.
  Operator = { fg = c.cyan }, -- sizeof", "+", "*", etc.
  Exception = { fg = c.red }, -- try, catch, throw
  PreProc = { fg = c.orange }, -- generic Preprocessor
  Include = { fg = c.cyan }, -- preprocessor #include
  Define = { fg = c.orange }, -- preprocessor #define
  Macro = { fg = c.blue }, -- same as Define
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
  Todo = { fg = c.yellow, bg = c.none, bold = true, italic = true }, -- anything that needs extra attention; mostly the keywords TODO FIXME and XXX

  -- healthError = { fg = c.error },
  -- healthSuccess = { fg = c.green },
  -- healthWarning = { fg = c.orange },
}

M.treesitter = {
  TSVariable = { link = 'Variable' },
  -- TSComment = { fg = c.comment, gui = 'italic' },
  -- TSString = { fg = c.green },
  -- TSConditional = { fg = c.puple },
  -- TSKeyword = { fg = c.purple },
  -- TSRepeat = { fg = c.purple },
  TSKeywordFunction = { fg = c.orange, italic = true },
  TSKeywordReturn = { fg = c.purple, italic = true },
  TSKeywordOperator = { link = 'Keyword' },
  -- TSFunction = { fg = c.blue },
  TSMethod = { fg = c.blue, italic = true },
  -- TSFuncBuiltin = { fg = c.blue, gui = 'italic' },
  -- TSEnvironment = { fg = c.blue },
  -- TSVariableBuiltin = { fg = c.blue, italic = true },
  TSAnnotation = { fg = c.pink }, -- For C++/Dart attributes, annotations that can be attached to the code to denote some kind of meta information.
  TSAttribute = { fg = c.yellow },
  -- TSBoolean = { fg = c.orange }, -- For booleans.
  -- TSCharacter = { fg = c.green, italic = true }, -- For characters.
  TSConstructor = { fg = c.cyan }, -- For constructor calls and definitions: `= {}` in Lua, and Java constructors.
  TSConstant = { fg = c.orange, italic = true }, -- For constants
  TSConstBuiltin = { fg = c.red }, -- For constant that are built in the language: `nil` in Lua.
  -- TSConstMacro = { fg = c.orange }, -- For constants that are defined by macros: `NULL` in C.
  -- TSException = { fg = c.red }, -- For exception related keywords.
  -- TODO: find a color for TSField and TSProperty
  TSField = { fg = '#ffdfb6' }, -- For fields. -- TEST: #FFD7A3
  TSProperty = { link = 'TSField' },
  -- TSFloat = { fg = c.orange }, -- For floats.
  -- TSFuncMacro = { fg = c.blue }, -- For macro defined fuctions (calls and definitions): each `macro_rules` in Rust.
  -- TSInclude = { fg = c.cyan }, -- For includes: `#include` in C, `use` or `extern crate` in Rust, or `require` in Lua.
  -- TSLabel = { fg = c.purple }, -- For labels: `label:` in C and `:label:` in Lua.
  -- TODO: fund a color for TSNamespace
  TSNamespace = { fg = '#FFECB3' }, -- For identifiers referring to modules and namespaces.
  -- TSNumber = { fg = c.orange }, -- For all numbers
  -- TSOperator = { fg = c.cyan }, -- For any operator: `+`, but also `->` and `*` in C.
  TSParameter = { fg = c.yellow }, -- For parameters of a function.
  TSParameterReference = { link = 'TSParameter' }, -- For references to parameters of a function.
  -- TSProperty = { fg = c.blue }, -- Same as `TSField`,accesing for struct members in C.
  -- TSPunctDelimiter = { fg = c.fg }, -- For delimiters ie: `.`
  TSPunctBracket = { fg = c.cyan }, -- For brackets and parens.
  TSPunctSpecial = { fg = c.cyan }, -- For special punctutation that does not fall in the catagories before.
  TSStringRegex = { fg = c.blue }, -- For regexes.
  TSStringEscape = { fg = c.gray }, -- For escape characters within a string.
  -- TSStringSpecial = { fg = c.green },
  TSSymbol = { fg = c.yellow }, -- For identifiers referring to symbols or atoms.
  -- TSType = { fg = c.cyan }, -- For types.
  TSTypeBuiltin = { fg = c.red, italic = true }, -- For builtin types.
  TSTag = { fg = '#ff7597' }, -- Tags like html tag names.
  TSTagDelimiter = { fg = c.cyan }, -- Tag delimiter like `<` `>` `/`
  TSTagAttribute = { fg = c.yellow },
  -- TSText = { fg = c.fg }, -- For strings considered text in a markup language
  TSMath = { fg = c.blue },
  TSTextReference = { fg = '#ff6c92', italic = true },
  -- TSEmphasis = { italic = true }, -- For text to be represented with emphasis.
  -- TSUnderline = { fg = c.fg, underline = true }, -- For text to be represented with an underline.
  -- TSTitle = { fg = c.yellow }, -- Text that is part of a title.
  TSLiteral = { fg = '#6bffb5' }, -- Literal text.
  -- TODO:
  -- TSURI = { underline = true }, -- Any URI like a link or email.
  -- TSStrong = { bold = true },
  -- TSStrike = { strikethrough = true },
  TSError = { underline = true }, -- For syntax/parser errors.

  TSNote = { link = 'Todo' },
  -- TSWarning = { link = 'Todo' },
  TSDanger = { link = 'Todo' },
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
  TelescopeSelection = { fg = c.blue, bg = c.none },

  NvimTreeNormal = { fg = c.fg_sidebar, bg = c.bg_alt },
  NvimTreeFolderName = { fg = c.fg_sidebar },
  NvimTreeFolderIcon = { fg = c.folder_icon },
  NvimTreeOpenedFolderName = { fg = c.cyan },
  NvimTreeOpenedFile = { fg = c.cyan },
  NvimTreeVertsplit = { bg = c.bg_alt, fg = c.bg_alt },

  GitSignsAdd = { fg = c.git_sings_add },
  GitSignsChange = { fg = c.git_sings_change },
  GitSignsDelete = { fg = c.git_sings_delete },
  GitSignsCurrentLineBlame = { link = 'Comment' },
  -- nvim-lspconfig
  LspInfoBorder = { link = 'FloatBorder' },
  -- Indent Blank line
  IndentBlanklineChar = { fg = c.fn.blend(c.gray, c.bg, 0.3) },
  IndentBlanklineContextChar = { fg = c.fn.blend(c.gray, c.bg, 0.99) },
}

M.langs = {
  rTSKeywordReturn = { fg = c.blue, italic = true },
  ocamlTSConstructor = { fg = c.orange },
  javascriptTSConstructor = { link = 'TSTag' },
  tsxTSConstructor = { link = 'TSTag' },
}

for _, value in pairs(M) do
  for group, opts in pairs(value) do
    hi(group, opts)
  end
end
