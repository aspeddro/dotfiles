local Terminal = require('toggleterm.terminal').Terminal

return {
  new = function(opts)
    return Terminal:new {
      dir = opts.dir,
      on_open = function(term)
        vim.cmd 'startinsert!'

        require('mapx').tnoremap(
          '<esc>',
          [[<C-\><C-n>]],
          { buffer = term.bufnr }
        )
      end,
    }
  end,
}
