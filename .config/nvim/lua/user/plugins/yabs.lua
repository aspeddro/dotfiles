require('yabs'):setup {
  languages = {
    lua = {
      tasks = {
        run = {
          command = 'luafile %', -- The cammand to run (% and other
          -- wildcards will be automatically
          -- expanded)
          type = 'lua', -- The type of command (can be `vim`, `lua`, or
          -- `shell`, default `shell`)
        },
      },
    },
  },
}
