local install_path = vim.fn.stdpath 'data'
  .. '/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  packer_bootstrap = vim.fn.system {
    'git',
    'clone',
    '--depth',
    '1',
    'https://github.com/wbthomason/packer.nvim',
    install_path,
  }
end

require('packer').init {
  git = {
    clone_timeout = 300,
  },
  display = {
    open_fn = function()
      return require('packer.util').float { border = 'rounded' }
    end,
    keybindings = {
      quit = '<Esc>',
    },
  },
}

require('packer').startup(function(use)
  -- NOTE: local plugins
  local here = function(name)
    return vim.fn.expand '~/Desktop/Plugins/' .. name
  end

  -- Fast detect filetype
  use {
    'nathom/filetype.nvim',
    config = function()
      require 'user.plugins.filetype'
    end,
  }
  use 'wbthomason/packer.nvim'
  use 'nvim-lua/popup.nvim'
  use 'nvim-lua/plenary.nvim'
  use 'tweekmonster/startuptime.vim'
  use {
    'kyazdani42/nvim-web-devicons',
    config = function()
      require('nvim-web-devicons').setup()
    end,
  }
  use {
    'b0o/mapx.nvim',
    config = function()
      require('mapx').setup { global = true, debug = false }
    end,
  }
  -- Faster move 'j' 'k'
  use {
    'PHSix/faster.nvim',
    config = function()
      require('mapx').nmap('j', '<Plug>(faster_move_j)')
      require('mapx').nmap('k', '<Plug>(faster_move_k)')
      require('mapx').vmap('k', '<Plug>(faster_vmove_k)')
      require('mapx').vmap('k', '<Plug>(faster_vmove_k)')
    end,
  }

  -- use { 'LionC/nest.nvim' }
  use {
    'rcarriga/nvim-notify',
    config = function()
      vim.notify = require 'notify'
    end,
  }

  use {
    here 'bufferhandler.nvim',
  }

  use {
    here 'blueberry.nvim',
  }

  use {
    'kyazdani42/nvim-tree.lua',
    config = function()
      require 'user.plugins.nvimtree'
    end,
  }

  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = function()
      require 'user.plugins.treesitter'
    end,
    requires = {
      { 'nvim-treesitter/playground' },
      { 'nvim-treesitter/nvim-treesitter-textobjects' },
      -- { '~/Desktop/nvim-treesitter-textobjects' },
      { 'p00f/nvim-ts-rainbow' },
      { 'RRethy/nvim-treesitter-textsubjects' },
      { 'windwp/nvim-ts-autotag' },
    },
  }

  -- use {
  --   'pianocomposer321/yabs.nvim',
  --   config = function()
  --     require 'plugins.yabs'
  --   end,
  -- }

  use {
    'rebelot/heirline.nvim',
    config = function()
      require 'user.plugins.heirline'
    end,
  }

  -- use { 'nvim-lua/lsp-status.nvim' }

  use {
    'nvim-telescope/telescope.nvim',
    config = function()
      require 'user.plugins.telescope'
    end,
    requires = {
      { 'nvim-lua/popup.nvim' },
      { 'nvim-lua/plenary.nvim' },
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        run = 'make',
        config = function()
          require('telescope').load_extension 'fzf'
        end,
      },
      {
        'nvim-telescope/telescope-github.nvim',
        config = function()
          require('telescope').load_extension 'gh'
        end,
      },
      -- {
      --   'LinArcX/telescope-command-palette.nvim',
      --   config = function()
      --     require('telescope').load_extension 'command_palette'
      --   end,
      -- },
      -- {
      --   'nvim-telescope/telescope-packer.nvim',
      --   config = function()
      --     require('telescope').load_extension 'packer'
      --   end,
      -- },
      -- {
      --   'nvim-telescope/telescope-symbols.nvim',
      -- },
    },
  }

  -- Telescone sessions switch
  -- use {
  --   'willthbill/opener.nvim',
  --   config = function()
  --     require('opener').setup {
  --     }
  --     require('telescope').load_extension 'opener'
  --   end,
  -- }

  -- use {
  --   'kdheepak/lazygit.nvim',
  -- }
  use {
    'lewis6991/gitsigns.nvim',
    -- event = 'BufReadPre',
    config = function()
      require 'user.plugins.gitsings'
    end,
    requires = {
      'nvim-lua/plenary.nvim',
    },
  }

  use {
    'windwp/nvim-autopairs',
    config = function()
      require 'user.plugins.autopairs'
    end,
  }

  use {
    'npxbr/glow.nvim',
    -- ft = { 'markdown', 'rmd', 'pandoc' },
    cmd = 'Glow',
  }

  -- Highlight lines
  -- use {
  --   'mvllow/modes.nvim',
  --   config = function()
  --     require 'plugins.modes'
  --   end
  -- }

  use {
    'numToStr/Comment.nvim',
    config = function()
      require 'user.plugins.comment'
    end,
  }

  -- Preserve buffer width/height when resize neovim window
  -- use {
  --   'kwkarlwang/bufresize.nvim',
  --   config = function()
  --     -- TODO: add support to ignore window
  --     -- vim.cmd [[
  --     --   augroup ResizeWindow
  --     --       autocmd!
  --     --       autocmd VimResized * lua require('bufresize').resize()
  --     --       autocmd WinEnter * lua require('bufresize').register()
  --     --   augroup END
  --     -- ]]
  --   end,
  -- }

  -- use {
  --   'folke/zen-mode.nvim',
  --   cmd = { 'ZenMode' },
  --   config = function()
  --     require('zen-mode').setup {}
  --   end,
  -- }

  use {
    here 'toggleterm.nvim',
    config = function()
      require 'user.plugins.toggleterm'
    end,
  }

  use {
    'norcalli/nvim-colorizer.lua',
    -- event = 'BufRead',
    config = function()
      require('colorizer').setup { '*', '!vim', '!packer', '!NvimTree' }
    end,
  }

  -- LSP
  use {
    'neovim/nvim-lspconfig',
    config = function()
      require('user.plugins.lspconfig').setup()
    end,
    requires = {
      -- {
      --   'ii14/lsp-command'
      -- },
      {
        'williamboman/nvim-lsp-installer',
      },
      -- {
      --   'PlatyPew/format-installer.nvim',
      --   config = function()
      --     require('format-installer').setup()
      --   end,
      -- },
      {
        -- JSON LSP
        'b0o/schemastore.nvim',
      },
      -- {
      --   'weilbith/nvim-code-action-menu',
      -- },
    },
  }

  use {
    'jose-elias-alvarez/null-ls.nvim',
    config = function()
      require 'user.plugins.null-ls'
    end,
  }
  -- UI nvim-lsp progress
  use {
    'j-hui/fidget.nvim',
    config = function()
      require('fidget').setup()
    end,
  }

  -- use {
  --   'onsails/lspkind-nvim',
  -- }

  use {
    'hrsh7th/nvim-cmp',
    -- opt = true,
    -- event = 'InsertEnter',
    config = function()
      require 'user.plugins.cmp'
    end,
    requires = {
      {
        'L3MON4D3/LuaSnip',
        requires = {
          'rafamadriz/friendly-snippets',
        },
        config = function()
          require 'user.plugins.luasnip'
        end,
      },
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-path' },
      { 'hrsh7th/cmp-nvim-lua' },
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'saadparwaiz1/cmp_luasnip' },
      { 'hrsh7th/cmp-nvim-lsp-document-symbol' },
      -- use 'kdheepak/cmp-latex-symbols'
      { 'hrsh7th/cmp-emoji' },
      -- use 'uga-rosa/cmp-dictionary'
      { 'petertriho/cmp-git' },
      -- use 'f3fora/cmp-spell'
      { 'hrsh7th/cmp-cmdline' },
      { 'onsails/lspkind-nvim' },
      { 'ray-x/lsp_signature.nvim' },
      -- { 'mjlbach/lsp_signature.nvim' },
    },
  }
  use { here 'cmp-pandoc.nvim' }

  -- LSP Utils
  -- use {
  --   'filipdutescu/renamer.nvim',
  --   config = function()
  --     require('renamer').setup {
  --       title = 'Rename',
  --     }
  --   end,
  --   branch = 'master',
  --   requires = { { 'nvim-lua/plenary.nvim' } },
  -- }

  use {
    here 'detect-indent.nvim',
    config = function()
      require('detect-indent').setup()
    end,
  }

  -- use {
  --   'nmac427/guess-indent.nvim',
  --   config = function()
  --     require('guess-indent').setup {
  --       autocmd = true,
  --       verbose = 2,
  --     }
  --   end,
  -- }

  -- use {
  --   'zsugabubus/crazy8.nvim'
  -- }
  -- use {
  --   'Darazaki/indent-o-matic',
  --   config = function ()
  --     require('indent-o-matic').setup {}
  --   end
  -- }

  use {
    'jubnzv/virtual-types.nvim',
    -- event = 'BufRead',
  }

  use {
    'gpanders/editorconfig.nvim',
    config = function()
      vim.cmd [[
          augroup editorconfig
            autocmd!
            autocmd BufEnter * lua require('editorconfig').config()
          augroup END
        ]]
    end,
  }

  -- use {
  --   "lukas-reineke/indent-blankline.nvim",
  --   config = function ()
  --     require 'plugins.indent'
  --   end
  -- }

  -- use {
  --   'glepnir/indent-guides.nvim',
  --   config = function ()
  --     require('indent_guides').setup()
  --   end
  -- }

  use {
    'lewis6991/impatient.nvim',
    rocks = 'mpack',
  }

  -- use {
  --   'akinsho/nvim-bufferline.lua',
  --   config = function()
  --     require 'plugins.bufferline'
  --   end,
  -- }

  -- Buferline
  use {
    'noib3/nvim-cokeline',
    config = function()
      require 'user.plugins.cokeline'
    end,
  }

  -- Utils editings
  use {
    'max397574/better-escape.nvim',
    config = function()
      require('better_escape').setup {
        mapping = { 'jk', 'jj', 'kj' },
      }
    end,
  }

  -- use {
  --   'lewis6991/spaceless.nvim',
  --   config = function()
  --     require('spaceless').setup()
  --   end,
  -- }

  -- use {
  --   'winston0410/range-highlight.nvim',
  --   config = function ()
  --     require'range-highlight'.setup{}
  --   end,
  --   requires = {
  --     {'winston0410/cmd-parser.nvim'}
  --   }
  -- }

  -- peeks lines of the buffer
  use {
    'nacro90/numb.nvim',
    config = function()
      require('numb').setup()
    end,
  }

  -- use {
  --   'rktjmp/highlight-current-n.nvim',
  --   config = function ()
  --     require("highlight_current_n").setup({
  --       highlight_group = "IncSearch"
  --     })
  --   end
  -- }

  -- use {
  --   'RRethy/vim-illuminate',
  --   config = function()
  --     vim.g.Illuminate_delay = 2000
  --   end,
  -- }

  -- Langs
  -- use {
  --  '~/Desktop/rescript.nvim',
  -- }

  use {
    'aspeddro/slides.nvim',
    -- ft = { 'markdown' },
    config = function()
      require('slides').setup {}
    end,
  }

  use {
    here 'rlang.nvim',
    config = function()
      -- require 'user.plugins.rlang'
    end,
    after = 'nvim-treesitter',
    -- wants = {'nvim-treesitter'},
    requires = {
      'nvim-treesitter/nvim-treesitter',
    },
  }

  use {
    here 'pandoc.nvim',
    -- ft = { 'markdown' },
    requires = {
      'nvim-lua/plenary.nvim',
      'jbyuki/nabla.nvim', -- optional
    },
    config = function()
      require('pandoc').setup {
        default = {
          args = {
            { '--standalone' },
            { '--number-sections' },
            { '--biblatex' },
            { '--pdf-engine', 'tectonic' },
            { '--filter', 'pandoc-crossref' },
          },
        },
      }
    end,
  }

  -- use {
  --   'andweeb/presence.nvim',
  --   config = function ()
  --     require'plugins.presence'
  --   end
  -- }

  use {
    here 'tex.nvim',
    -- ft = { 'tex', 'bib' },
    config = function()
      require('tex').setup {
        engine = 'tectonic',
        viewer = 'evince',
      }
    end,
  }

  -- Hclipboard will bypass the text into clipboard
  use {
    'kevinhwang91/nvim-hclipboard',
    event = 'InsertCharPre',
    config = function()
      require('hclipboard').start()
    end,
  }

  -- use { 'rescript-lang/vim-rescript' }
  use {
    'nkrkv/nvim-treesitter-rescript',
    run = ':TSUpdate rescript',
  }

  -- use { 'bakpakin/fennel.vim' }

  use 'folke/lua-dev.nvim'

  use {
    here 'gitui.nvim',
    config = function()
      require('gitui').setup()
    end,
  }

  -- use {
  --   here 'filestyle.nvim',
  --   config = function()
  --     require 'user.plugins.filestyle'
  --   end,
  -- }

  use {
    here 'repl.nvim',
  }

  -- F# support
  -- use {
  --   'PhilT/vim-fsharp',
  -- }

  if packer_bootstrap then
    require('packer').sync()
  end
end)
