local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    '--single-branch',
    'https://github.com/folke/lazy.nvim.git',
    lazypath,
  }
end
vim.opt.runtimepath:prepend(lazypath)

local opts = {
  concurrency = 8,
  dev = {
    path = '~/Desktop/plugins',
  },
}

local plugins = require 'user.plugins'

require('lazy').setup({ plugins }, opts)
