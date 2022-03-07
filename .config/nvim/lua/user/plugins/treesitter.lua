local parser_config = require('nvim-treesitter.parsers').get_parser_configs()
local ft_to_parser = require('nvim-treesitter.parsers').filetype_to_parsername
local query = require 'vim.treesitter.query'
local install = require 'nvim-treesitter.install'

local color = require('blueberry').colors

install.prefer_git = true

ft_to_parser.rmd = 'markdown'

-- parser_config.rmd = {
--   install_info = {
--     url = '~/Desktop/Plugins/tree-sitter-markdown',
--     branch = 'main',
--     files = { 'src/parser.c', 'src/scanner.cc' },
--   },
--   filetype = 'rmd',
-- }

local read_query = function(filename)
  return table.concat(vim.fn.readfile(vim.fn.expand(filename)), '\n')
end

-- query.set_query(
--   'r',
--   'highlights',
--   read_query '~/.config/nvim/my_queries/r/highlights.scm'
-- )
require('nvim-treesitter.configs').setup {
  ensure_installed = {
    'bash',
    'css',
    'html',
    'javascript',
    'json',
    'julia',
    'query',
    'haskell',
    'latex',
    'bibtex',
    'lua',
    'ocaml',
    'python',
    'r',
    'regex',
    'scss',
    'toml',
    'rust',
    'tsx',
    'make',
    'markdown',
    'vim',
    'typescript',
    'yaml',
    'comment', -- TODO comments and DOC comment
    'jsdoc',
  },
  highlight = {
    enable = true,
    -- use_languagetree = false,
    -- disable = { 'json', 'latex', 'bibtex' },
    additional_vim_regex_highlighting = false,
  },
  rainbow = {
    enable = true,
    -- disable = { 'latex' }, -- list of languages you want to disable the plugin for
    extended_mode = {
      latex = false,
    }, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
    max_file_lines = nil, -- Do not enable for files with more than n lines, int
    colors = {
      color.extra.orange,
      color.extra.green,
      color.extra.blue1,
      color.extra.paleblue,
      color.extra.purple,
      color.extra.pink,
      color.extra.viole,
    }, -- table of hex strings
    -- termcolors = {} -- table of colour name strings
  },
  indent = {
    enable = true,
    -- disable = { 'yaml' },
  },
  autopairs = {
    enable = true, -- check for autopairs (see nvim-autopairs)
  },
  autotag = {
    enable = true,
  },
  query_linter = {
    enable = true,
    use_virtual_text = true,
    lint_events = { 'BufWrite', 'CursorHold' },
  },
  playground = {
    enable = true,
    persist_queries = true,
    updatetime = 25,
    keybindings = {
      toggle_query_editor = 'o',
      toggle_hl_groups = 'i',
      toggle_injected_languages = 't',
      toggle_anonymous_nodes = 'a',
      toggle_language_display = 'I',
      focus_language = 'f',
      unfocus_language = 'F',
      update = 'R',
      goto_node = '<cr>',
      show_help = '?',
    },
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
  textobjects = {
    select = {
      enable = true,

      -- Automatically jump forward to textobj, similar to targets.vim
      lookahead = true,

      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@call.outer',
        ['ic'] = '@call.inner',
        ['ci'] = '@conditional.inner',
        ['co'] = '@conditional.outer',
        ['li'] = '@loop.inner',
        ['lo'] = '@loop.outer',
        ['pi'] = '@parameter.inner',
        ['po'] = '@parameter.outer',
        -- NOTE: this config break rainbow
        -- Or you can define your own textobjects like this
        -- ['iF'] = {
        --   python = '(function_definition) @function',
        --   cpp = '(function_definition) @function',
        --   c = '(function_definition) @function',
        --   java = '(method_declaration) @function',
        -- },
      },
    },
  },
  swap = {
    enable = true,
    swap_next = {
      ['<space>a'] = '@parameter.inner',
    },
    swap_previous = {
      ['<leader>A'] = '@parameter.inner',
    },
  },
  move = {
    -- FIX: https://github.com/nvim-treesitter/nvim-treesitter-textobjects/issues/177
    enable = true,
    set_jumps = true, -- whether to set jumps in the jumplist
    goto_next_start = {
      [']m'] = '@function.outer',
      [']e'] = '@parameter.inner',
    },
    goto_next_end = {
      [']M'] = '@function.outer',
      [']['] = '@class.outer',
    },
    goto_previous_start = {
      ['[m'] = '@function.outer',
      ['[['] = '@class.outer',
    },
    goto_previous_end = {
      ['[M'] = '@function.outer',
      ['[]'] = '@class.outer',
    },
  },
  -- TODO: Add more languages suppport
  -- r, rescript
  textsubjects = {
    enable = true,
    keymaps = {
      ['.'] = 'textsubjects-smart',
      [';'] = 'textsubjects-container-outer',
    },
  },
}

require('mapx').nmap('<leader>tp', ':TSPlaygroundToggle<cr>', 'silent')
require('mapx').nmap(
  '<leader>th',
  ':TSHighlightCapturesUnderCursor<cr>',
  'silent'
)
