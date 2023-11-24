-- Copy text to clipboard using codeblock format ```{ft}{content}```
vim.api.nvim_create_user_command('CopyCodeBlock', function(opts)
  local lines = vim.api.nvim_buf_get_lines(0, opts.line1 - 1, opts.line2, true)
  local content = table.concat(lines, '\n')
  local result = string.format('```%s\n%s\n```', vim.bo.filetype, content)

  local cmd = vim.env.XDG_SESSION_TYPE == 'wayland' and 'wl-copy %s'
    or 'echo %s | xclip -selection clipboard'

  vim.fn.system(string.format(cmd, vim.fn.shellescape(result)))

  vim.notify 'Text copied to clipboard'
end, { range = true })
