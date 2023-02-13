return {
  'nvim-lua/plenary.nvim',

  -- { 'tpope/vim-fugitive', dependencies = { 'tpope/vim-rhubarb' } },
  -- { 'neoclide/coc.nvim', branch = 'release' },

  -- {
  --   'lewis6991/impatient.nvim',
  --   rocks = 'mpack',
  -- },

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
  'tpope/vim-surround',

  -- use {
  --   'kylechui/nvim-surround',
  --   tag = '*', -- Use for stability; omit to use `main` branch for the latest features
  --   config = function()
  --     require('nvim-surround').setup {
  --     }
  --   end,
  -- }

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

  -- NOTE: rename to buffernavigation.nvim?
  {
    'aspeddro/bufferhandler.nvim',
    dev = true,
    config = function()
      require('bufferhandler').setup()
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
      { 'nvim-treesitter/playground' },
      -- { 'nvim-treesitter/nvim-treesitter-textobjects' },
      { 'mrjones2014/nvim-ts-rainbow' },
      { 'RRethy/nvim-treesitter-textsubjects' },
      { 'RRethy/nvim-treesitter-endwise' },
      { 'windwp/nvim-ts-autotag' },
      { 'JoosepAlviste/nvim-ts-context-commentstring' },
      -- { 'm-demare/hlargs.nvim' },
    },
  },

  {
    'williamboman/mason.nvim',
    config = function()
      require('mason').setup{
        ui = {
          height = 0.8
        }
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
  {
    'mrshmllow/document-color.nvim',
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

  -- {
  --   'williamboman/warden.nvim'
  -- },

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
      { 'hrsh7th/cmp-emoji' },
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

  -- StatusLine, BufferLine and WinBar
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
    'mfussenegger/nvim-lint',
    config = function()
      require 'user.plugins.lint'
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
    'ruifm/gitlinker.nvim',
    config = function()
      require 'user.plugins.gitlinker'
    end,
  },

  -- use {
  --   'akinsho/git-conflict.nvim',
  --   tag = '*',
  --   config = function()
  --     require 'user.plugins.git_conflitc'
  --   end,
  -- }

  {
    'windwp/nvim-autopairs',
    dev = false,
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
    config = function()
      require 'user.plugins.indentline'
    end,
  },

  {
    'mhartington/formatter.nvim',
    config = function()
      require 'user.plugins.formatter'
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

  -- DEPREACTED: remove in 0.9
  {
    'luukvbaal/stabilize.nvim',
    config = function()
      require('stabilize').setup()
    end,
  },

  {
    'phaazon/mind.nvim',
    -- branch = 'v2.2',
    dev = true,
    config = function()
      require 'user.plugins.mind'
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
  --   'kdheepak/lazygit.nvim',
  -- }

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
      'jbyuki/nabla.nvim', -- optional
    },
    config = function()
      require 'user.plugins.pandoc'
    end,
  },

  {
    'folke/twilight.nvim',
    config = function()
      require('twilight').setup {
        context = 0,
      }
    end,
  },

  {
    'rhysd/conflict-marker.vim',
    config = function()
      vim.g.conflict_marker_enable_mappings = 0
      vim.g.conflict_marker_enable_matchit = 0
    end,
  },

  -- Langs support

  'ii14/emmylua-nvim',

  {
    'aspeddro/rescript-tools.nvim',
    dev = true,
  },

  {
    'ocaml/vim-ocaml',
    config = function()
      vim.g.ocaml_highlight_operators = 1
    end,
  },

  'jose-elias-alvarez/typescript.nvim',
}
