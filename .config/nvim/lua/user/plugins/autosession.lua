local function before_close()
  require('nvim-tree').close()
end

require('auto-session').setup {
  log_level = 'error',
  -- auto_save_enabled = true,
  -- pre_save_cmds = { before_close },
}

-- require('session-lens').setup {
--   path_display = { 'full' },
--   previewer = false,
-- }

-- require('telescope').load_extension 'session-lens'
