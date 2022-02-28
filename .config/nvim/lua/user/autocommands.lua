vim.cmd [[
  augroup OnYankText
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup END
]]

-- TODO: in some cases RAM usage increase substantially
-- vim.cmd [[
--   augroup PackerCompileOnSave
--     autocmd!
--     autocmd BufWritePost ~/.config/nvim/lua/packages.lua source <afile> | PackerCompile
--   augroup end
-- ]]
