local install_path = vim.fn.stdpath 'data'
  .. '/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.execute(
    '!git clone https://github.com/wbthomason/packer.nvim ' .. install_path
  )
end

require('packer').init {
  git = {
    clone_timeout = 300,
  },
  display = {
    open_fn = function()
      return require('packer.util').float { border = 'rounded' }
    end,
    keybindings = { -- Keybindings for the display window
      quit = '<Esc>',
    },
  },
}

require('packer').startup(function(use)
  local local_use = function(opts)
    local opts = type(opts) == 'table' and opts or { opts }
    local dir_plugins = vim.fn.expand '~/Desktop/Plugins/'
    opts[1] = dir_plugins .. opts[1]
    use(opts)
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

  use { 'LionC/nest.nvim' }
  use {
    'rcarriga/nvim-notify',
    config = function()
      vim.notify = require 'notify'
    end,
  }

  local_use {
    'bufferhandler.nvim',
  }

  local_use 'blueberry.nvim'
  -- use {
  --   '~/Desktop/blueberry.nvim',
  -- }
  -- use {
  --   'folke/tokyonight.nvim',
  -- }
  -- use 'tiagovla/tokyodark.nvim'
  -- use {
  --   'projekt0n/github-nvim-theme',
  --   config = function()
  --     require('github-theme').setup { theme_style = 'dark' }
  --   end,
  -- }
  -- use {
  --   'marko-cerovac/material.nvim',
  -- }

  use {
    'kyazdani42/nvim-tree.lua',
    config = function()
      require 'user.plugins.nvimtree'
    end,
  }

  -- use {
  --   '~/Desktop/sidebar.nvim',
  --   config = function()
  --     require('sidebar-nvim').setup {
  --       hide_statusline = false,
  --       -- TODO: new version
  --       keybindings = {
  --         disable_default = true,
  --         bindings = {
  --           ['<Esc>'] = require('sidebar-nvim').close,
  --         },
  --       },
  --       -- TODO: old version
  --       disable_default_keybindings = 1,
  --       bindings = {
  --         -- NOTE: <Esc> key is not supported
  --         ['<Esc>'] = require('sidebar-nvim').close,
  --       },
  --       sections = { 'files', 'git', 'diagnostics' },
  --       files = {
  --         icon = '',
  --         show_hidden = true,
  --       },
  --     }
  --   end,
  -- }

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

  -- use {
  --   'famiu/feline.nvim',
  --   config = function()
  --     require 'plugins.feline'
  --   end,
  -- }

  -- use {
  --   'tjdevries/express_line.nvim',
  --   requires = {
  --     { 'nvim-lua/plenary.nvim' },
  --   },
  --   config = function()
  --     -- require('el').setup()
  --     require 'plugins.express_line'
  --   end,
  -- }

  -- use {
  --   'hoob3rt/lualine.nvim',
  --   requires = {'kyazdani42/nvim-web-devicons', opt = true},
  --   config = function()
  --     require'plugins.lualine'
  --   end,
  -- }

  -- use {
  --   'glepnir/galaxyline.nvim',
  --   branch = 'main',
  --   config = function ()
  --     require'plugins.galaxyline'
  --   end
  -- }

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

  -- TODO: break nvim-tree.lua on back to session
  -- use {
  --   'rmagatti/auto-session',
  --   -- requires = {
  --   --   {
  --   --     'rmagatti/session-lens',
  --   --     after = 'telescope.nvim'
  --   --   }
  --   -- },
  --   config = function()
  --     require 'plugins.autosession'
  --   end,
  -- }

  -- use {
  --   'Shatur/neovim-session-manager',
  --   config = function()
  --     require('session_manager').setup()
  --   end,
  -- }

  -- use {
  --    "nvim-telescope/telescope-frecency.nvim",
  --    requires = {'tami5/sql.nvim'},
  --    after = 'telescope.nvim'
  -- }
  -- use {
  --   "nvim-telescope/telescope-media-files.nvim",
  --   cmd = "Telescope"
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

  -- use {
  --   'sindrets/diffview.nvim',
  --   cmd = {
  --     'DiffviewOpen',
  --     'DiffviewClose',
  --     'DiffviewToggleFiles',
  --     'DiffviewFocusFiles',
  --     'DiffviewFileHistory',
  --   },
  --   config = function()
  --     require 'plugins.diffview'
  --   end,
  -- }

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

  -- use {
  --   'folke/todo-comments.nvim',
  --   event = 'BufReadPost',
  --   requires = "nvim-lua/plenary.nvim",
  --   config = function()
  --     require 'plugins.todo_comments'
  --   end,
  -- }

  -- use {
  --   'b3nj5m1n/kommentary',
  --   config = function ()
  --     require'plugins.kommentary'
  --   end
  -- }

  use {
    'numToStr/Comment.nvim',
    config = function()
      require 'user.plugins.comment'
    end,
  }

  -- use {
  --   "terrortylor/nvim-comment",
  --   config = function ()
  --     require'plugins.comment'
  --   end
  -- }

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
    'akinsho/nvim-toggleterm.lua',
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
    },
  }
  local_use 'cmp-pandoc.nvim'

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
  --   'tanvirtin/vgit.nvim',
  --   requires = 'nvim-lua/plenary.nvim',
  --   config = function ()
  --     require('vgit').setup()
  --   end
  -- }

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

  -- use {
  --   'romgrk/barbar.nvim'
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

  -- use {
  --   'beauwilliams/statusline.lua',
  --   config = function()
  --     local statusline = require 'statusline'
  --     statusline.tabline = false
  --     statusline.ale_diagnostics = false
  --     statusline.lsp_diagnostics = true
  --   end,
  -- }
  -- use {
  --   'ojroques/nvim-bufdel',
  --   config = function ()
  --     require('bufdel').setup {
  --       next = 'cycle',  -- or 'alternate'
  --       quit = false,
  --     }
  --   end
  -- }
  -- use {
  --   "beauwilliams/focus.nvim",
  --   config = function()
  --     require("focus").setup{}
  --   end
  -- }

  -- use {
  --   'edluffy/specs.nvim',
  --   config = function ()
  --     require('specs').setup{show_jumps  = true}
  --   end
  -- }

  -- Utils editings

  use {
    'max397574/better-escape.nvim',
    config = function()
      require('better_escape').setup {
        mapping = { 'jk', 'jj', 'kj' },
      }
    end,
  }

  -- Remove space
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

  -- use {
  --   'lukas-reineke/headlines.nvim',
  --   config = function()
  --     require('headlines').setup()
  --   end
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

  local_use {
    'rlang.nvim',
    config = function()
      require 'user.plugins.rlang'
    end,
    after = 'nvim-treesitter',
    -- wants = {'nvim-treesitter'},
    requires = {
      'nvim-treesitter/nvim-treesitter',
    },
  }

  local_use {
    'pandoc.nvim',
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

  local_use {
    'tex.nvim',
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

  local_use {
    'gitui.nvim',
    config = function()
      require('gitui').setup()
    end,
  }

  local_use {
    'filestyle.nvim',
    config = function()
      require 'user.plugins.filestyle'
    end,
  }

  -- F# support
  use {
    'PhilT/vim-fsharp',
  }
end)
