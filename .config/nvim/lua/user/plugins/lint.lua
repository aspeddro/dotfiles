require('lint').linters_by_ft = {
  markdown = { 'vale' },
}

local enabled = false
vim.api.nvim_create_user_command('ToggleLint', function()
  enabled = not enabled

  vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
    callback = function()
      if enabled then
        require('lint').try_lint()
      end
    end,
  })
end, {
  nargs = 0,
})
