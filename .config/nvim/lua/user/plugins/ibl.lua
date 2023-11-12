require('ibl').setup {
  indent = { char = '▏' },
  scope = { enabled = false },
  exclude = {
    filetypes = {
      'NvimTree',
      'terminal',
      'toggleterm',
      'glowpreview',
      'help',
      'lazy',
      'mason',
    },
  },
}
