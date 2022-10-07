local install_path = vim.fn.stdpath 'data'
  .. '/site/pack/packer/start/packer.nvim'

local packer_bootstrap
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

local function automatize()
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

  local packer = require 'packer'
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

--- Development plugins
---@param name string
---@return string
local here = function(name)
  return vim.fn.expand '~/Desktop/plugins/' .. name
end

local M = {}

M.setup = function()
  automatize()

  require('packer').startup {
    function(use)
      use 'wbthomason/packer.nvim'
      use 'nvim-lua/plenary.nvim'
      use {
        'lewis6991/impatient.nvim',
        rocks = 'mpack',
      }

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
          { 'windwp/nvim-ts-autotag' },
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
            'rmagatti/goto-preview',
            config = function()
              require('goto-preview').setup {}
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
            requires = {
              'rafamadriz/friendly-snippets',
            },
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
          { 'davidsierradz/cmp-conventionalcommits' },
          -- { 'mjlbach/lsp_signature.nvim' },
          -- { 'zbirenbaum/copilot-cmp' },
          -- {
          --   'zbirenbaum/copilot.lua',
          --   event = 'InsertEnter',
          --   config = function()
          --     vim.schedule(function()
          --       require 'copilot'
          --     end)
          --   end,
          -- },
        },
      }

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
        'windwp/nvim-autopairs',
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
          vim.g.indent_blankline_context_patterns = {
            'class',
            '^func',
            'method',
            '^if',
            'while',
            'for',
            'with',
            'try',
            'except',
            'arguments',
            'argument_list',
            'object',
            'dictionary',
            'element',
            'table',
            'tuple',
            -- Rescript
            'type_declaration',
            'module_declaration',
            'block',
            'switch_match',
            'jsx_fragment',
          }
          require('indent_blankline').setup {
            show_current_context = true,
            -- show_current_context_start = true,
            filetype_exclude = {
              'NvimTree',
              'lsp-installer',
              'terminal',
              'toggleterm',
              'glowpreview',
              'tsplayground',
              'help',
            },
          }
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

      -- Hclipboard will bypass the text into clipboard
      -- use {
      --   'kevinhwang91/nvim-hclipboard',
      --   event = 'InsertCharPre',
      --   config = function()
      --     require('hclipboard').start()
      --   end,
      -- }

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

      if packer_bootstrap then
        require('packer').sync()
      end
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
