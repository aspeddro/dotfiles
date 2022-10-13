local M = {}

local function bootstap()
  local install_path = vim.fn.stdpath 'data'
    .. '/site/pack/packer/start/packer.nvim'

  if not vim.loop.fs_stat(install_path) then
    if vim.fn.input 'Download Packer? (y for yes): ' ~= 'y' then
      return
    end

    print 'Downloading packer.nvim...'
    print(
      vim.fn.system(
        string.format(
          'git clone %s %s',
          'https://github.com/wbthomason/packer.nvim',
          install_path
        )
      )
    )
  end
end

local function automatize(packer)
  local packer_compile =
    vim.api.nvim_create_augroup('PackerCompile', { clear = true })

  vim.api.nvim_create_autocmd('BufWritePost', {
    group = packer_compile,
    pattern = vim.fn.stdpath 'config' .. '/lua/user/packages.lua',
    callback = function()
      package.loaded['user.packages'] = nil
      require('user.packages').setup()
      require('packer').clean()
    end,
  })

  local state = 'cleaned'
  local orig_complete = packer.on_complete
  packer.on_complete = vim.schedule_wrap(function()
    if state == 'cleaned' then
      packer.install()
      state = 'installed'
    elseif state == 'installed' then
      packer.compile()
      state = 'compiled'
    elseif state == 'compiled' then
      packer.on_complete = orig_complete
      state = 'done'
    end
  end)

  vim.api.nvim_create_autocmd('User', {
    pattern = 'PackerCompileDone',
    callback = function()
      vim.notify 'Packer Compiled'
    end,
  })
end

--- Development local plugins
---@param name string
---@return string
local here = function(name)
  return os.getenv 'HOME' .. '/Desktop/plugins/' .. name
end

M.setup = function()
  bootstap()

  local packer = require 'packer'

  automatize(packer)

  packer.startup {
    function(use)
      use 'wbthomason/packer.nvim'
      use 'nvim-lua/plenary.nvim'
      use {
        'lewis6991/impatient.nvim',
        rocks = 'mpack',
      }

      use {
        'ggandor/leap.nvim',
        config = function()
          require('leap').add_default_mappings()
        end,
      }

      use 'tpope/vim-sleuth'

      use {
        'kyazdani42/nvim-web-devicons',
        config = function()
          require('nvim-web-devicons').setup()
        end,
      }

      use {
        'monkoose/matchparen.nvim',
        config = function()
          require('matchparen').setup()
        end,
      }

      -- NOTE: rename to buffernavigation.nvim?
      use {
        here 'bufferhandler.nvim',
        config = function()
          require('bufferhandler').setup()
        end,
      }

      -- Better resize window
      use { 'mrjones2014/smart-splits.nvim' }

      use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        config = function()
          require 'user.plugins.treesitter'
        end,
        requires = {
          { 'nvim-treesitter/playground' },
          { 'nvim-treesitter/nvim-treesitter-textobjects' },
          { 'p00f/nvim-ts-rainbow' },
          { 'RRethy/nvim-treesitter-textsubjects' },
          { 'RRethy/nvim-treesitter-endwise' },
          { 'windwp/nvim-ts-autotag' },
          { 'JoosepAlviste/nvim-ts-context-commentstring' },
          -- { 'm-demare/hlargs.nvim' },
        },
      }

      use {
        'williamboman/mason.nvim',
        config = function()
          require('mason').setup()
        end,
      }

      -- LSP
      use {
        'neovim/nvim-lspconfig',
        requires = {
          {
            -- JSON LSP
            'b0o/schemastore.nvim',
          },
          {
            -- UI LSP progress
            'j-hui/fidget.nvim',
            config = function()
              require('fidget').setup()
            end,
          },
          {
            here 'lsp_menu.nvim',
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
            'rmagatti/goto-preview',
            config = function()
              require 'user.plugins.gotopreview'
            end,
          },
        },
      }

      use {
        'hrsh7th/nvim-cmp',
        config = function()
          require 'user.plugins.cmp'
        end,
        requires = {
          {
            'L3MON4D3/LuaSnip',
            config = function()
              require 'user.plugins.luasnip'
            end,
          },
          { 'hrsh7th/cmp-buffer' },
          { 'hrsh7th/cmp-path' },
          { 'hrsh7th/cmp-nvim-lsp' },
          { 'saadparwaiz1/cmp_luasnip' },
          { 'hrsh7th/cmp-emoji' },
          { 'petertriho/cmp-git' },
          { 'hrsh7th/cmp-cmdline' },
          {
            here 'cmp-pandoc.nvim',
          },
          { 'onsails/lspkind-nvim' },
        },
      }

      use {
        'nvim-telescope/telescope.nvim',
        config = function()
          require 'user.plugins.telescope'
        end,
        requires = {
          { 'nvim-lua/plenary.nvim' },
          {
            'nvim-telescope/telescope-fzf-native.nvim',
            run = 'make',
            config = function()
              require('telescope').load_extension 'fzf'
            end,
          },
        },
      }

      use {
        'kyazdani42/nvim-tree.lua',
        config = function()
          require 'user.plugins.nvimtree'
        end,
      }

      -- StatusLine, BufferLine and WinBar
      use {
        'rebelot/heirline.nvim',
        config = function()
          require 'user.plugins.heirline'
        end,
      }

      use {
        'NvChad/nvim-colorizer.lua',
        config = function()
          require('colorizer').setup {
            filetypes = {
              'css',
              '!vim',
              '!packer',
              '!NvimTree',
            },
          }
        end,
      }

      use {
        'mfussenegger/nvim-lint',
        config = function()
          require 'user.plugins.lint'
        end,
      }

      use {
        'lewis6991/gitsigns.nvim',
        config = function()
          require 'user.plugins.gitsings'
        end,
      }

      use {
        'sindrets/diffview.nvim',
        config = function()
          require 'user.plugins.diffview'
        end,
      }

      use {
        here 'nvim-autopairs',
        -- 'windwp/nvim-autopairs',
        config = function()
          require 'user.plugins.autopairs'
        end,
      }

      use {
        'numToStr/Comment.nvim',
        config = function()
          require 'user.plugins.comment'
        end,
      }

      use {
        'lukas-reineke/indent-blankline.nvim',
        config = function()
          require 'user.plugins.indentline'
        end,
      }

      use {
        'mhartington/formatter.nvim',
        config = function()
          require 'user.plugins.formatter'
        end,
      }

      use {
        here 'repl.nvim',
        config = function()
          require 'user.plugins.repl'
        end,
      }

      use {
        'max397574/better-escape.nvim',
        config = function()
          require('better_escape').setup {
            mapping = { 'jk', 'jj', 'kj' },
          }
        end,
      }

      -- peeks lines of the buffer
      use {
        'nacro90/numb.nvim',
        config = function()
          require('numb').setup()
        end,
      }

      -- DEPREACTED: remove in 0.8.1
      use {
        'luukvbaal/stabilize.nvim',
        config = function()
          require('stabilize').setup {
            nested = 'QuickFixCmdPost,DiagnosticChanged *',
          }
        end,
      }

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

      use {
        here 'pandoc.nvim',
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
                -- { '--biblatex' },
                -- { "--natbib" },
                { '--pdf-engine', 'tectonic' },
                { '--filter', 'pandoc-crossref' },
              },
            },
          }
        end,
      }

      use 'ii14/emmylua-nvim'

      use {
        'phaazon/mind.nvim',
        branch = 'v2.2',
        config = function()
          require('mind').setup()
        end,
      }
    end,
    config = {
      git = {
        clone_timeout = 300,
      },
      display = {
        open_fn = function()
          return require('packer.util').float { border = 'rounded' }
        end,
        keybindings = {
          quit = 'q',
        },
      },
      autoremove = true,
    },
  }
end

M.setup()

return M
