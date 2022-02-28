require 'impatient'
require('impatient').enable_profile()

-- Do not source the default filetype.vim
vim.g.did_load_filetypes = 1
-- Disable filetype plugin
vim.g.did_load_ftplugin = 1
-- -- Stop loading built in plugins
vim.g.loaded_matchit = 1
vim.g.loaded_remote_plugins = 1
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrwSettings = 1
vim.g.loaded_netrwFileHandlers = 1
vim.g.loaded_gzip = 1
vim.g.loaded_zip = 1
vim.g.loaded_zipPlugin = 1
vim.g.loaded_tar = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_zipPlugin = 1
vim.g.loaded_getscript = 1
vim.g.loaded_getscriptPlugin = 1
vim.g.loaded_vimball = 1
vim.g.loaded_vimballPlugin = 1
vim.g.loaded_2html_plugin = 1
vim.g.loaded_logipat = 1
vim.g.loaded_rrhelper = 1
vim.g.loaded_matchparen = 1
vim.g.loaded_spec = 1

vim.g.mapleader = '\\'
vim.g.maplocalleader = ','

local utils = require 'user.utils'

require 'user.options'
require 'user.globals'
require 'user.packages'
require 'user.autocommands'
require 'user.mappings'
-- utils.keymapping.register(require 'user.keymapping')

vim.cmd [[colorscheme blueberry]]