local formatter = require 'formatter'

local root_has_file = function(pattern)
  if #vim.fs.find(pattern, { upward = true }) > 0 then
    return true
  end

  vim.notify(
    'Formatter: Not found '
      .. table.concat(vim.tbl_flatten { pattern }, ', ')
      .. ' at '
      .. vim.loop.cwd(),
    vim.log.levels.WARN
  )
  return false
end

local stylua = function()
  if not root_has_file { 'stylua.toml', '.stylua.toml' } then
    return
  end
  return {
    exe = 'stylua',
    args = {
      '-',
    },
    stdin = true,
  }
end

local prettier = function()
  if
    not root_has_file {
      '.prettierrc',
      '.prettierrc.json',
      '.prettierrc.yml',
      '.prettierrc.yaml',
      '.prettierrc.json5',
      '.prettierrc.js',
      '.prettierrc.cjs',
      'prettierrc.config.js',
      'prettier.config.cjs',
      '.prettier.toml',
    }
  then
    return
  end
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
    markdown = { prettier },
  },
}
