require('diffview').setup {
  enhanced_diff_hl = true,
  view = {
    merge_tool = {
      layout = 'diff1_plain',
      disable_diagnostics = true,
    },
  },
  -- hooks = {
  --   view_opened = function(v)
  --     vim.opt_local.relativenumber = false
  --     -- vim.opt_local.cursorline = false
  --   end,
  --   view_closed = function(v)
  --     vim.opt_local.relativenumber = true
  --     -- vim.opt_local.cursorline = true
  --   end,
  -- },
}
