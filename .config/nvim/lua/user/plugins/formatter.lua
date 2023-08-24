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

local make = function(opts)
  if not opts.require then
    return opts.run
  end
  return function()
    if not root_has_file(opts.require) then
      return
    end
    return opts.run
  end
end

local stylua = make {
  require = { 'stylua.toml', '.stylua.toml' },
  run = {
    exe = 'stylua',
    args = {
      '-',
    },
    stdin = true,
  },
}

local prettier = make {
  require = {
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
  },
  run = {
    exe = 'prettier',
    args = {
      '--stdin-filepath',
      vim.api.nvim_buf_get_name(0),
    },
    stdin = true,
  },
}

local black = make {
  run = {
    exe = 'black',
    args = {
      '-q',
      '-',
    },
    stdin = true,
  },
}

local sql_formatter = make {
  run = {
    exe = 'sql-formatter',
    stdin = true,
  },
}

formatter.setup {
  filetype = {
    lua = { stylua },
    python = { black },
    javascript = { prettier },
    typescript = { prettier },
    markdown = { prettier },
    sql = { sql_formatter },
  },
}
