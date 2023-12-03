return {
  'nvim-lua/plenary.nvim',

  {
    'rcarriga/nvim-notify',
    config = function()
      require('notify').setup {
        timeout = 400,
        stages = 'slide',
      }
      vim.notify = require 'notify'
    end,
  },

  'tpope/vim-sleuth',

  {
    'kyazdani42/nvim-web-devicons',
    config = function()
      require('nvim-web-devicons').setup()
    end,
  },

  {
    'monkoose/matchparen.nvim',
    config = function()
      require('matchparen').setup()
    end,
  },

  {
    'smjonas/live-command.nvim',
    config = function()
      require('live-command').setup {
        commands = {
          Norm = { cmd = 'norm' },
        },
      }
    end,
  },

  -- Better resize window
  { 'mrjones2014/smart-splits.nvim' },

  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
      require 'user.plugins.treesitter'
    end,
    dependencies = {
      -- { 'nvim-treesitter/nvim-treesitter-textobjects' },
      -- { 'mrjones2014/nvim-ts-rainbow' },
      { url = 'https://gitlab.com/HiPhish/nvim-ts-rainbow2.git' },
      { 'RRethy/nvim-treesitter-textsubjects' },
      -- { 'RRethy/nvim-treesitter-endwise' },
      { 'windwp/nvim-ts-autotag' },
      -- { 'm-demare/hlargs.nvim' },
    },
  },

  {
    'JoosepAlviste/nvim-ts-context-commentstring',
    config = function()
      require('ts_context_commentstring').setup { enable_autocmd = false }
    end,
  },

  {
    'williamboman/mason.nvim',
    build = ':MasonUpdate',
    config = function()
      require('mason').setup {
        ui = {
          height = 0.8,
        },
      }
    end,
  },

  -- LSP
  'neovim/nvim-lspconfig',
  -- JSON LSP
  'b0o/schemastore.nvim',

  {
    -- UI LSP progress
    'j-hui/fidget.nvim',
    config = function()
      require('fidget').setup()
    end,
  },

  { 'ray-x/lsp_signature.nvim' },

  {
    'SmiteshP/nvim-navic',
  },

  {
    'lvimuser/lsp-inlayhints.nvim',
    config = function()
      require('lsp-inlayhints').setup {
        inlay_hints = {
          parameter_hints = {
            show = false,
          },
          highlight = 'LspSignatureActiveParameter',
        },
      }
    end,
  },

  {
    'dnlhc/glance.nvim',
    config = function()
      require('glance').setup {}
    end,
  },

  {
    'hrsh7th/nvim-cmp',
    config = function()
      require 'user.plugins.cmp'
    end,
    dependencies = {
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-path' },
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'saadparwaiz1/cmp_luasnip' },
      -- { 'hrsh7th/cmp-emoji' },
      { 'petertriho/cmp-git' },
      { 'hrsh7th/cmp-cmdline' },
      {
        'aspeddro/cmp-pandoc.nvim',
        dev = true,
      },
      { 'onsails/lspkind-nvim' },
    },
  },

  {
    'L3MON4D3/LuaSnip',
    config = function()
      require 'user.plugins.luasnip'
    end,
  },

  {
    'nvim-telescope/telescope.nvim',
    config = function()
      require 'user.plugins.telescope'
    end,
  },

  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'make',
    config = function()
      require('telescope').load_extension 'fzf'
    end,
  },

  {
    'kyazdani42/nvim-tree.lua',
    config = function()
      require 'user.plugins.nvimtree'
    end,
  },

  {
    'tamago324/lir.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'kyazdani42/nvim-web-devicons',
    },
    config = function()
      require 'user.plugins.lir'
    end,
  },

  {
    'rebelot/heirline.nvim',
    config = function()
      require 'user.plugins.heirline'
    end,
  },

  {
    'NvChad/nvim-colorizer.lua',
    config = function()
      require 'user.plugins.colorizer'
    end,
  },

  {
    'lewis6991/gitsigns.nvim',
    config = function()
      require 'user.plugins.gitsings'
    end,
  },

  {
    'sindrets/diffview.nvim',
    config = function()
      require 'user.plugins.diffview'
    end,
  },

  {
    'linrongbin16/gitlinker.nvim',
    config = function()
      require 'user.plugins.gitlinker'
    end,
  },

  {
    'windwp/nvim-autopairs',
    config = function()
      require 'user.plugins.autopairs'
    end,
  },

  {
    'numToStr/Comment.nvim',
    config = function()
      require 'user.plugins.comment'
    end,
  },

  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    config = function()
      require 'user.plugins.ibl'
    end,
  },

  {
    'stevearc/conform.nvim',
    config = function()
      require 'user.plugins.conform'
    end,
  },

  {
    'aspeddro/repl.nvim',
    dev = true,
    config = function()
      require 'user.plugins.repl'
    end,
  },

  {
    'max397574/better-escape.nvim',
    config = function()
      require('better_escape').setup {
        mapping = { 'jk', 'jj', 'kj' },
      }
    end,
  },

  -- peeks lines of the buffer
  {
    'nacro90/numb.nvim',
    config = function()
      require('numb').setup()
    end,
  },

  {
    'toppair/peek.nvim',
    build = 'deno task --quiet build:fast',
    config = function()
      require('peek').setup()
    end,
  },

  -- use {
  --   here 'gitui.nvim',
  --   config = function()
  --     require('gitui').setup()
  --   end,
  -- }

  -- use {
  --   'aspeddro/slides.nvim',
  --   ft = { 'markdown' },
  --   config = function()
  --     require('slides').setup {}
  --   end,
  -- }

  {
    'aspeddro/pandoc.nvim',
    dev = true,
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    config = function()
      require 'user.plugins.pandoc'
    end,
  },

  {
    'rhysd/conflict-marker.vim',
    config = function()
      vim.g.conflict_marker_enable_mappings = 0
      vim.g.conflict_marker_enable_matchit = 0
    end,
  },

  { 'rawnly/gist.nvim' },

  -- {
  --   'sourcegraph/sg.nvim',
  --   dependencies = { 'nvim-lua/plenary.nvim' },

  --   -- If you have a recent version of lazy.nvim, you don't need to add this!
  --   build = 'nvim -l build/init.lua',
  -- },

  -- Langs support

  -- 'ii14/emmylua-nvim',

  { 'folke/neodev.nvim', opts = {} },

  { 'rescript-lang/vim-rescript' },

  {
    'aspeddro/rescript-tools.nvim',
    dev = true,
  },

  {
    'ocaml/vim-ocaml',
    config = function()
      vim.g.ocaml_highlight_operators = 1
      -- Disable mappings
      vim.g.no_plugin_maps = 0
    end,
  },

  {
    'godlygeek/tabular',
  },
}
