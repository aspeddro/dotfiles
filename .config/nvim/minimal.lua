-- Load the 'runtime/' files
vim.cmd [[set runtimepath=$VIMRUNTIME]]

-- Originally, `packpath` contains a lot of path to search into which also
-- includes the `~/.config/nvim` directory. Now, if we open Neovim, the files
-- in the `plugin/`, `ftplugin/`, etc. directories will be loaded automatically.
--
-- We will set the value of `packpath` to contain only our testing directory to
-- avoid loading files from our config directory.
--
--     $ nvim -nu minimal.lua
vim.cmd [[set packpath=/tmp/nvim/site]]

local package_root = '/tmp/nvim/site/pack'
local packer_install_path = package_root .. '/packer/start/packer.nvim'

vim.opt.mouse = 'a'

local function load_plugins()
  require('packer').startup {
    {
      'wbthomason/packer.nvim',
      'neovim/nvim-lspconfig',
      'rebelot/heirline.nvim',
      'kyazdani42/nvim-web-devicons',
      -- Add plugins to test...
      -- 'williamboman/mason.nvim',
      -- 'williamboman/mason-lspconfig.nvim',
    },
    config = {
      package_root = package_root,
      compile_path = packer_install_path .. '/plugin/packer_compiled.lua',
      display = { non_interactive = true },
    },
  }
end

_G.load_config = function()
  -- Add the necessary `init.lua` settings which could include the setup
  -- functions for the plugins...
  require('nvim-web-devicons').setup()
  local herline = require 'heirline'
  local utils = require 'heirline.utils'
  local TablineFileName = {
    provider = function(self)
      local filename = self.filename
      filename = filename == '' and '[No Name]'
        or vim.fn.fnamemodify(filename, ':t')
      return filename
    end,
  }

  local TablineFileNameBlock = {
    init = function(self)
      self.filename = vim.api.nvim_buf_get_name(self.bufnr)
    end,
    on_click = {
      callback = function(_, minwid, _, button)
        if button == 'm' then -- close on mouse middle click
          vim.api.nvim_buf_delete(minwid, { force = false })
        else
          vim.api.nvim_win_set_buf(0, minwid)
        end
      end,
      minwid = function(self)
        return self.bufnr
      end,
      name = 'heirline_tabline_buffer_callback',
    },
    TablineFileName,
  }

  local TablineCloseButton = {
    condition = function(self)
      return not vim.bo[self.bufnr].modified
    end,
    { provider = ' ' },
    {
      provider = '',
      hl = { fg = 'gray' },
      on_click = {
        callback = function(_, minwid)
          vim.api.nvim_buf_delete(minwid, { force = false })
        end,
        minwid = function(self)
          return self.bufnr
        end,
        name = 'heirline_tabline_close_buffer_callback',
      },
    },
  }
  -- The final touch!
  local TablineBufferBlock = utils.surround({ ' ', ' ' }, function(self)
    if self.is_active then
      return utils.get_highlight('TabLineSel').bg
    else
      return utils.get_highlight('TabLine').bg
    end
  end, { TablineFileNameBlock, TablineCloseButton })

  -- and here we go
  local BufferLine = utils.make_buflist(
    TablineBufferBlock,
    { provider = ' ' }, -- left truncation, optional (defaults to "<")
    { provider = ' ' } -- right trunctation, also optional (defaults to ...... yep, ">")
    -- by the way, open a lot of buffers and try clicking them ;)
  )

  local Tabpage = {
    provider = function(self)
      return '%' .. self.tabnr .. 'T ' .. self.tabnr .. ' %T'
    end,
  }

  local TabpageClose = {
    provider = '%999X  %X',
    hl = 'TabLine',
  }

  local TabPages = {
    -- only show this component if there's 2 or more tabpages
    condition = function()
      return #vim.api.nvim_list_tabpages() >= 2
    end,
    { provider = '%=' },
    utils.make_tablist(Tabpage),
    TabpageClose,
  }

  local TabLineOffset = {
    condition = function(self)
      local win = vim.api.nvim_tabpage_list_wins(0)[1]
      local bufnr = vim.api.nvim_win_get_buf(win)
      self.winid = win

      if vim.bo[bufnr].filetype == 'NvimTree' then
        self.title = ''
        return true
      end
    end,

    provider = function(self)
      local title = self.title
      local width = vim.api.nvim_win_get_width(self.winid)
      local pad = math.ceil((width - #title) / 2)
      return string.rep(' ', pad) .. title .. string.rep(' ', pad)
    end,
  }

  local TabLine = { TabLineOffset, BufferLine, TabPages }

  herline.setup(nil, nil, TabLine)
end

if vim.fn.isdirectory(packer_install_path) == 0 then
  print 'Installing plugins and dependencies...'
  vim.fn.system {
    'git',
    'clone',
    '--depth=1',
    'https://github.com/wbthomason/packer.nvim',
    packer_install_path,
  }
end

load_plugins()
require('packer').sync()
vim.cmd [[autocmd User PackerComplete ++once echo "Ready!" | lua load_config()]]
