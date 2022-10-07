local formatter = require 'formatter'

local stylua = function()
  return {
    exe = 'stylua',
    args = {
      '-',
    },
    stdin = true,
  }
end

local prettier = function()
  return {
    exe = 'prettier',
    args = {
      '--stdin-filepath',
      vim.api.nvim_buf_get_name(0),
    },
    stdin = true,
  }
end

formatter.setup {
  filetype = {
    lua = { stylua },
    javascript = { prettier },
    typescript = { prettier },
    markdown = { prettier }
  },
}
