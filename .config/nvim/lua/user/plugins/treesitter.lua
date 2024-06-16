local install = require 'nvim-treesitter.install'
local parser_config = require('nvim-treesitter.parsers').get_parser_configs()

install.prefer_git = true

-- Extend clojure parse to dune file
vim.treesitter.language.register('clojure', 'dune')

parser_config.rescript = {
  install_info = {
    url = '~/Desktop/projects/tree-sitter-rescript',
    files = { 'src/parser.c', 'src/scanner.c' },
    requires_generate_from_grammar = true,
  },
  filetype = 'rescript',
}

local disable = function(lang, bufnr)
  if vim.tbl_contains({ 'rescript' }, lang) then
    return true
  end

  local name = vim.api.nvim_buf_get_name(bufnr)

  if lang == 'javascript' and vim.endswith(name, '.min.js') then
    return true
  end

  local lines = vim.api.nvim_buf_line_count(bufnr)

  if lines > 2000 then
    return true
  end

  if lines == 1 then
    local column_len =
      string.len(vim.api.nvim_buf_get_lines(bufnr, 0, -1, true)[1])

    if column_len > 2000 then
      return true
    end
  end

  return false
end

require('nvim-treesitter.configs').setup {
  ensure_installed = {
    'bash',
    'c',
    -- 'clojure',
    -- 'commonlisp',
    'cpp',
    'css',
    -- 'erlang',
    -- 'elixir',
    -- 'fennel',
    -- 'teal',
    'scss',
    'dockerfile',
    'html',
    'javascript',
    'json',
    'jsonc',
    'json5',
    -- 'julia',
    'query',
    -- 'haskell',
    'latex',
    'bibtex',
    'lua',
    'luadoc',
    'ocaml',
    'ocaml_interface',
    'ocamllex',
    'python',
    'r',
    -- 'go',
    -- 'gomod',
    'graphql',
    -- 'ruby',
    -- 'perl',
    -- 'java',
    -- 'php',
    -- 'phpdoc',
    -- 'kotlin',
    'regex',
    'scss',
    'toml',
    'rust',
    'tsx',
    'make',
    'markdown_inline',
    'markdown',
    -- 'svelte',
    'vim',
    'typescript',
    'yaml',
    'scheme',
    'comment',
    'jsdoc',
    -- 'zig',
    'cmake',
    'prisma',
    'vimdoc',
    -- 'swift',
    -- Git
    'gitcommit',
    'git_rebase',
    'gitignore',
    'gitattributes',
    'diff',
  },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = { 'rescript' },
    disable = disable,
  },
  indent = {
    enable = { 'r' },
    disable = { 'rescript', 'ocaml', 'javascript', 'typescript', 'yaml' },
  },
  -- rainbow = {
  --   enable = false,
  -- },
  -- autotag = {
  --   enable = true,
  -- },
  -- endwise = {
  --   enable = true,
  -- },
  query_linter = {
    enable = true,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = 'gnn',
      node_incremental = 'grn',
      scope_incremental = 'grc',
      node_decremental = 'grm',
    },
  },
  textsubjects = {
    enable = true,
    prev_selection = ',',
    keymaps = {
      ['.'] = 'textsubjects-smart',
      [';'] = 'textsubjects-container-outer',
      ['i;'] = 'textsubjects-container-inner',
    },
  },
}
