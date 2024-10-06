vim.loader.enable()

require 'user.disable'
require 'user.options'

vim.cmd.colorscheme 'mocha'

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end

vim.opt.runtimepath:prepend(lazypath)

require('lazy').setup(require 'user.plugins', {
  concurrency = 8,
  dev = {
    path = vim.fn.expand '~/Desktop/projects/nvim-plugins',
  },
  install = {
    colorscheme = { 'mocha' },
  },
})

require 'user.globals'
require 'user.mappings'
require 'user.lsp'
