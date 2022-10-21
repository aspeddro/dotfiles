require('goto-preview').setup {
  border = 'rounded',
  post_open_hook = function(bufnr, window)
    vim.api.nvim_create_autocmd({ 'WinLeave' }, {
      group = vim.api.nvim_create_augroup('GoToPreview', { clear = true }),
      callback = function()
        if vim.api.nvim_win_is_valid(window) then
          vim.api.nvim_win_close(window, true)
        end
      end,
    })
    vim.keymap.set('n', 'q', function()
      vim.api.nvim_win_close(window, true)
    end, { buffer = bufnr })
  end,
}
