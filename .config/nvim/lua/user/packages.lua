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
  local packer_compile = vim.api.nvim_create_augroup(
    'PackerCompile',
    { clear = true }
  )

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
---@param path string
---@return string
local here = function(path)
  return vim.fn.expand '~/Desktop/Plugins/' .. path
end

local M = {}

M.setup = function()
  automatize()

  require('packer').startup {
    function(use)
      use 'wbthomason/packer.nvim'
      use 'nvim-lua/popup.nvim'
      use 'nvim-lua/plenary.nvim'
      use {
        'lewis6991/impatient.nvim',
        rocks = 'mpack',
      }

      use 'antoinemadec/FixCursorHold.nvim'
      use 'tweekmonster/startuptime.vim'
      use {
        'kyazdani42/nvim-web-devicons',
        config = function()
          require('nvim-web-devicons').setup()
        end,
      }

      -- use {
      --   'rcarriga/nvim-notify',
      --   config = function()
      --     vim.notify = require 'notify'
      --     require('notify').setup{
      --       timeout = 1000
      --     }
      --   end,
      -- }

      -- NOTE: rename to buffernavigation.nvim?
      use {
        here 'bufferhandler.nvim',
        config = function()
          require('bufferhandler').setup {
            source = {
              buffers = function()
                return vim.tbl_map(function(buffer)
                  return buffer.number
                  ---@diagnostic disable-next-line: undefined-field
                end, _G.cokeline.visible_buffers)
              end,
            },
          }
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
          { 'nkrkv/nvim-treesitter-rescript' },
          { 'nvim-treesitter/playground' },
          { 'nvim-treesitter/nvim-treesitter-textobjects' },
          { 'p00f/nvim-ts-rainbow' },
          { 'RRethy/nvim-treesitter-textsubjects' },
          { 'windwp/nvim-ts-autotag' },
          {
            'lewis6991/spellsitter.nvim',
            config = function()
              require('spellsitter').setup()
            end,
          },
          -- { 'm-demare/hlargs.nvim' },
        },
      }

      -- LSP
      use {
        'neovim/nvim-lspconfig',
        config = function()
          -- TODO: call lspconfig setup here start a new server every time when run :PackerCompile
          -- @see https://github.com/wbthomason/packer.nvim/discussions/832
          -- require('user.plugins.lspconfig').setup()
        end,
        requires = {
          {
            'williamboman/nvim-lsp-installer',
            config = function()
              require('nvim-lsp-installer').setup {}
            end,
          },
          {
            'nvim-lua/lsp_extensions.nvim',
          },
          -- {
          --   here 'nvim-code-action-menu',
          --   -- 'weilbith/nvim-code-action-menu',
          --   config = function()
          --     vim.g.code_action_menu_window_border = 'rounded'
          --   end,
          -- },
          -- {
          --   'filipdutescu/renamer.nvim',
          -- },
          -- {
          --   'PlatyPew/format-installer.nvim',
          --   config = function()
          --     require('format-installer').setup()
          --   end,
          -- },
          {
            'RRethy/vim-illuminate',
            config = function()
              vim.g.Illuminate_delay = 1000
            end,
          },
          {
            -- JSON LSP
            'b0o/schemastore.nvim',
          },
          {
            'jose-elias-alvarez/null-ls.nvim',
            config = function()
              require 'user.plugins.null-ls'
            end,
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
          -- { 'hrsh7th/cmp-nvim-lua' },
          { 'hrsh7th/cmp-nvim-lsp' },
          { 'saadparwaiz1/cmp_luasnip' },
          -- { 'hrsh7th/cmp-nvim-lsp-signature-help' },
          -- { 'hrsh7th/cmp-nvim-lsp-document-symbol' },
          -- use 'kdheepak/cmp-latex-symbols'
          { 'hrsh7th/cmp-emoji' },
          -- use 'uga-rosa/cmp-dictionary'
          { 'petertriho/cmp-git' },
          -- use 'f3fora/cmp-spell'
          { 'hrsh7th/cmp-cmdline' },
          {
            here 'cmp-pandoc.nvim',
          },
          { 'onsails/lspkind-nvim' },
          { 'ray-x/lsp_signature.nvim' },
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
          {
            'nvim-telescope/telescope-github.nvim',
            config = function()
              require('telescope').load_extension 'gh'
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

      -- Status Line
      use {
        'rebelot/heirline.nvim',
        config = function()
          require 'user.plugins.heirline'
        end,
      }

      use {
        'noib3/nvim-bufferline',
        config = function()
          require 'user.plugins.cokeline'
        end,
      }

      use {
        'akinsho/toggleterm.nvim',
      }

      use {
        'norcalli/nvim-colorizer.lua',
        config = function()
          require('colorizer').setup { 'css', '!vim', '!packer', '!NvimTree' }
        end,
      }

      use {
        'lewis6991/gitsigns.nvim',
        config = function()
          require 'user.plugins.gitsings'
        end,
        requires = {
          'nvim-lua/plenary.nvim',
        },
      }

      use {
        'sindrets/diffview.nvim',
        config = function()
          require 'user.plugins.diffview'
        end,
        requires = 'nvim-lua/plenary.nvim',
      }

      use {
        'akinsho/git-conflict.nvim',
        config = function()
          require('git-conflict').setup {
            default_mappings = false,
          }
        end,
      }

      use {
        'lewis6991/hover.nvim',
        config = function()
          require('hover').setup {
            preview_opts = {
              border = 'rounded',
              max_width = math.ceil(vim.api.nvim_win_get_width(0) * 0.6),
              max_height = math.ceil(vim.api.nvim_win_get_height(0) * 0.8),
            },
            title = true,
          }
          vim.keymap.set('n', 'K', require('hover').hover, {
            desc = 'hover.nvim',
          })
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
            'jsx_fragment'
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
        'lukas-reineke/headlines.nvim',
        config = function()
          require('headlines').setup {
            markdown = {
              dash_highlight = false,
              headline_pattern = false,
            },
            rmd = {
              dash_highlight = false,
              headline_pattern = false,
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
        here 'detect-indent.nvim',
        config = function()
          require('detect-indent').setup()
        end,
      }

      -- Preserve buffer width/height when resize neovim window
      -- use {
      --   'kwkarlwang/bufresize.nvim',
      --   config = function()
      --     -- TODO: add support to ignore window
      --     -- require('bufresize').setup()
      --     vim.cmd [[
      --       augroup ResizeWindow
      --           autocmd!
      --           autocmd VimResized * lua require('bufresize').resize()
      --           autocmd WinEnter * lua require('bufresize').register()
      --       augroup END
      --     ]]
      --   end,
      -- }

      -- use {
      --   'gpanders/editorconfig.nvim',
      --   config = function()
      --     vim.cmd [[
      --         augroup editorconfig
      --           autocmd!
      --           autocmd BufEnter * lua require('editorconfig').config()
      --         augroup END
      --       ]]
      --   end,
      -- }

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
      use {
        'kevinhwang91/nvim-hclipboard',
        event = 'InsertCharPre',
        config = function()
          require('hclipboard').start()
        end,
      }

      -- use {
      --   'lewis6991/spaceless.nvim',
      --   config = function()
      --     require('spaceless').setup()
      --   end,
      -- }

      -- peeks lines of the buffer
      use {
        'nacro90/numb.nvim',
        config = function()
          require('numb').setup()
        end,
      }

      -- TESTING:
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

      use {
        here 'gitui.nvim',
        config = function()
          require('gitui').setup()
        end,
      }

      use {
        'aspeddro/slides.nvim',
        ft = { 'markdown' },
        config = function()
          require('slides').setup {}
        end,
      }

      use {
        'npxbr/glow.nvim',
        cmd = 'Glow',
      }

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

      -- use { 'bakpakin/fennel.vim' }

      use 'folke/lua-dev.nvim'

      -- use {
      --   'jghauser/follow-md-links.nvim',
      -- }

      -- F# support
      -- use {
      --   'PhilT/vim-fsharp',
      -- }

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
