local install = require 'nvim-treesitter.install'
local parser_config = require('nvim-treesitter.parsers').get_parser_configs()

local color = require 'user.color'

install.prefer_git = true

-- local read_query = function(filename)
--   return table.concat(vim.fn.readfile(vim.fn.expand(filename)), '\n')
-- end

-- parser_config.rdoc = {
--   install_info = {
--     url = '~/Desktop/Projects/tree-sitter-rdoc',
--     -- branch = 'main',
--     files = { 'src/parser.c', 'src/scanner.c' },
--   },
-- }

-- parser_config.rescript = {
--   install_info = {
--     url = '~/Desktop/Projects/tree-sitter-rescript',
--     -- branch = 'main',
--     files = { 'src/parser.c', 'src/scanner.c' },
--   },
--   filetype = { "rescript" }
-- }

parser_config.r = {
  install_info = {
    url = '~/Desktop/Projects/tree-sitter-r',
    -- branch = 'main',
    files = { 'src/parser.c' },
  },
  filetype = 'r',
}
-- parser_config.r = {
--   install_info = {
--     url = '~/Desktop/Projects/tree-sitter-r',
--     -- branch = 'main',
--     files = { 'src/parser.c' },
--   },
--   filetype = 'r',
-- }

-- query.set_query(
--   'r',
--   'highlights',
--   read_query '~/.config/nvim/__queries/r/highlights.scm'
-- )

-- @see https://github.com/nvim-treesitter/nvim-treesitter/issues/1708
local disable = function(_, bufnr)
  local name = vim.api.nvim_buf_get_name(bufnr)
  local filetype = vim.api.nvim_buf_get_option(bufnr, 'filetype')
  local is_valid = vim.tbl_contains({ '.min.js' }, name:match '.min.js')
    and vim.tbl_contains({ 'javascript' }, filetype)

  if is_valid then
    return true
  end

  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, true)

  if #lines > 10000 then
    return true
  end

  for _, line in ipairs(lines) do
    if line:len() > 5000 then
      return true
    end
  end

  return false
end

require('nvim-treesitter.configs').setup {
  ensure_installed = {
    'bash',
    'c',
    'clojure',
    'commonlisp',
    'cpp',
    'css',
    'erlang',
    'elixir',
    'fennel',
    'teal',
    'scss',
    'dockerfile',
    'html',
    'javascript',
    'json',
    'jsonc',
    'julia',
    'query',
    'haskell',
    'latex',
    'bibtex',
    'lua',
    'ocaml',
    'ocaml_interface',
    'ocamllex',
    'python',
    'r',
    'go',
    'gomod',
    'graphql',
    'ruby',
    'perl',
    'java',
    'php',
    'phpdoc',
    'kotlin',
    'regex',
    'scss',
    'toml',
    'rust',
    'tsx',
    'make',
    'markdown',
    'svelte',
    'vim',
    'typescript',
    'yaml',
    'scheme',
    'comment',
    'jsdoc',
    'zig',
    'cmake',
    'prisma',
  },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
    disable = disable,
  },
  rainbow = {
    enable = true,
    disable = disable,
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
    disable = { 'yaml' },
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
      [']]'] = '@parameter.inner',
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

-- highlight argument
-- require('hlargs').setup {
--   color = color.yellow,
-- }
-- require('hlargs').enable()

vim.keymap.set('n', '<leader>tp', ':TSPlaygroundToggle<cr>', { silent = true })
vim.keymap.set(
  'n',
  '<leader>th',
  ':TSHighlightCapturesUnderCursor<cr>',
  { silent = true }
)
