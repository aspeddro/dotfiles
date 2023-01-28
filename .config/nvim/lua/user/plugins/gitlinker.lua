require('gitlinker').setup {
  opts = {
    action_callback = function(url)
      require('plenary.job'):new({ command = 'xdg-open', args = { url } }):start()
    end,
  },
}
