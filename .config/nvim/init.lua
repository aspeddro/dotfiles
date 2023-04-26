vim.loader.enable()

require 'user.disable'

vim.cmd.colorscheme 'materialdarkerhc'

require 'user.options'
require 'user.plugins.lazy'
require 'user.globals'
require 'user.mappings'
require 'user.lsp'
