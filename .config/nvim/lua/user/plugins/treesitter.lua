local install = require 'nvim-treesitter.install'
local parser_config = require('nvim-treesitter.parsers').get_parser_configs()
local ft_to_parser = require('nvim-treesitter.parsers').filetype_to_parsername
local c = require 'user.color'

install.prefer_git = true

ft_to_parser.dune = 'clojure'

parser_config.rescript = {
  install_info = {
    url = '~/Desktop/projects/tree-sitter-rescript',
    -- branch = 'main',
    files = { 'src/parser.c', 'src/scanner.c' },
    requires_generate_from_grammar = true,
  },
  filetype = 'rescript',
}

local disable = function(_, bufnr)
  local name = vim.api.nvim_buf_get_name(bufnr)
  local is_minified_js = vim.tbl_contains({ '.min.js' }, name:match '.min.js')

  if is_minified_js then
    return true
  end

  local lines = vim.api.nvim_buf_line_count(bufnr)

  if lines > 10000 then
    return true
  end

  for _, line in
    ipairs(vim.api.nvim_buf_get_lines(0, 0, math.ceil(1 / 3 * lines), true))
  do
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
    -- 'erlang',
    'elixir',
    'fennel',
    'teal',
    'scss',
    'dockerfile',
    'html',
    'javascript',
    'json',
    'jsonc',
    'json5',
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
    'markdown_inline',
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
    'help',
    'swift',
    -- Git
    'gitcommit',
    'git_rebase',
    'gitignore',
    'gitattributes',
    'diff',
  },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
    disable = disable,
  },
  rainbow = {
    enable = false,
    disable = disable,
    extended_mode = {
      latex = false,
    },
    max_file_lines = nil,
    colors = vim.tbl_flatten { c.rainbow, c.rainbow },
  },
  indent = {
    enable = true,
  },
  autopairs = {
    enable = true,
  },
  autotag = {
    enable = true,
  },
  endwise = {
    enable = true,
  },
  query_linter = {
    enable = true,
  },
  playground = {
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
  -- textobjects = {
  --   select = {
  --     enable = true,
  --     -- Automatically jump forward to textobj, similar to targets.vim
  --     lookahead = true,
  --     keymaps = {
  --       -- You can use the capture groups defined in textobjects.scm
  --       ['af'] = '@function.outer',
  --       ['if'] = '@function.inner',
  --       ['ac'] = '@call.outer',
  --       ['ic'] = '@call.inner',
  --       ['ci'] = '@conditional.inner',
  --       ['co'] = '@conditional.outer',
  --       ['li'] = '@loop.inner',
  --       ['lo'] = '@loop.outer',
  --       ['pi'] = '@parameter.inner',
  --       ['po'] = '@parameter.outer',
  --     },
  --   },
  -- },
  -- swap = {
  --   enable = true,
  --   swap_next = {
  --     ['<leader>a'] = '@parameter.inner',
  --   },
  --   swap_previous = {
  --     ['<leader>A'] = '@parameter.inner',
  --   },
  -- },
  -- move = {
  --   enable = true,
  --   set_jumps = true, -- whether to set jumps in the jumplist
  --   goto_next_start = {
  --     [']m'] = '@function.outer',
  --     [']]'] = '@parameter.inner',
  --   },
  --   goto_next_end = {
  --     [']M'] = '@function.outer',
  --     [']['] = '@class.outer',
  --   },
  --   goto_previous_start = {
  --     ['[m'] = '@function.outer',
  --     ['[['] = '@class.outer',
  --   },
  --   goto_previous_end = {
  --     ['[M'] = '@function.outer',
  --     ['[]'] = '@class.outer',
  --   },
  -- },
  textsubjects = {
    enable = true,
    prev_selection = ',',
    keymaps = {
      ['.'] = 'textsubjects-smart',
      [';'] = 'textsubjects-container-outer',
      ['i;'] = 'textsubjects-container-inner',
    },
  },
  context_commentstring = {
    enable = true,
  },
}

-- require'treesitter-context'.setup{
--   patterns = {
--     rescript = {
--       "module_declaration"
--     }
--   }
-- }

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
