local git = require 'git-conflict'

git.setup {
  disable_diagnostics = true,
  default_mappings = false,
  default_commands = false,
}

vim.api.nvim_create_autocmd('User', {
  pattern = 'GitConflictDetected',
  callback = function()
    local bunfr = vim.api.nvim_get_current_buf()
    vim.diagnostic.disable(bunfr)
    vim.notify(
      'Git Conflict detected in ' .. vim.api.nvim_buf_get_name(bunfr),
      vim.log.levels.INFO
    )
    local actions = {
      ['Current changes'] = 'ours',
      ['Incoming changes'] = 'theirs',
      ['Both changes'] = 'both',
      ['Base changes'] = 'base',
      ['None of the changes'] = 'none',
    }
    local options = {
      'Current changes',
      'Incoming changes',
      'Both changes',
      'Base changes',
      'None of the changes',
    }
    vim.api.nvim_buf_create_user_command(0, 'GitConflict', function()
      vim.ui.select(options, {
        prompt = 'Select a action',
      }, function(choice)
        git.choose(actions[choice])
      end)
    end, { nargs = 0 })
  end,
})
