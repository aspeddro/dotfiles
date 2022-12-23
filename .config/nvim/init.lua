-- local ok, impatient = pcall(require, 'impatient')

-- if ok then
--   impatient.enable_profile()
-- end

require 'user.disable'

vim.cmd.colorscheme 'materialdarkerhc'

require 'user.filetype'
require 'user.options'
require 'user.autocmds'
require 'user.plugins.lazy'
-- require 'user.packages'
require 'user.globals'
require 'user.mappings'
require 'user.lsp'
require 'user.modules.terminal'
