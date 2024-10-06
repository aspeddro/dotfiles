local diffview = require 'diffview'

diffview.setup {
  enhanced_diff_hl = true,
  view = {
    merge_tool = {
      layout = 'diff1_plain',
      disable_diagnostics = true,
    },
  },
  hooks = {
    view_opened = function()
      vim.keymap.set('n', 'q', diffview.close, { buffer = true })
    end,
    diff_buf_read = function(bufnr)
      -- Change local options in diff buffers
      vim.treesitter.stop(bufnr)
    end,
  },
}
