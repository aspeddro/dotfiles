local util = require 'lspconfig.util'

local M = {}

local sumneko_lua = require('lua-dev').setup {
  library = { runtime = true, plugins = true, types = true },
  runtime_path = true,
}
sumneko_lua.settings.Lua.completion.callSnippet = 'Disable'
M.sumneko_lua = sumneko_lua

-- M.sumneko_lua = {
--   settings = {
--     Lua = {
--       diagnostics = { globals = { 'vim' } },
--       runtime = { version = 'LuaJIT', path = vim.split(package.path, ';') },
--       workspace = {
--         library = {
--           [vim.fn.expand '$VIMRUNTIME/lua'] = true,
--           [vim.fn.expand '$VIMRUNTIME/lua/vim/lsp'] = true,
--         },
--       },
--     },
--   },
-- }

M.r_language_server = {}

M.texlab = {
  settings = {
    texlab = {
      build = {
        executable = 'tectonic',
        args = { '%f', '--synctex' },
        onSave = true,
        forwardSearchAfter = true,
        isContinuous = false,
      },
      forwardSearch = {
        onSave = false,
        executable = 'evince-synctex',
        args = { '-f', '%l', '%p', os.getenv 'EDITOR' },
      },
    },
  },
}

-- M.ltex = {
--   root_dir = function(filename)
--     return util.path.dirname(filename)
--   end,
--   settings = {
--     ltex = {
--       language = { 'en-US', 'pt-BR' },
--       dictionary = {
--         ['en-US'] = {},
--         ['pt-BR'] = {},
--       },
--     },
--   },
-- }

M.clojure_lsp = {
  filetypes = { 'clojure', 'edn', 'fennel' },
}

M.jsonls = {
  settings = {
    json = {
      schemas = require('schemastore').json.schemas(),
    },
  },
}

M.rust_analyzer = {
  settings = {
    ['rust-analyzer'] = {
      lens = {
        run = true,
      },
    },
  },
}

return M
