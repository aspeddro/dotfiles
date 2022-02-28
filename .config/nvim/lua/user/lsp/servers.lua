local util = require 'lspconfig.util'

local M = {}

M.sumneko_lua = {
  settings = require('lua-dev').setup({
    library = {
      vimruntime = true,
      types = true,
      plugins = false,
    },
    runtime_path = false,
  }).settings,
}

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
