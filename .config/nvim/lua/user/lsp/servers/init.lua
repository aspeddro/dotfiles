local M = {}

M.sumneko_lua = vim.tbl_deep_extend(
  'force',
  require('lua-dev').setup {
    library = { runtime = true, plugins = { 'plenary.nvim' }, types = true },
  },
  {
    settings = {
      Lua = {
        completion = { callSnippet = 'Disable' },
        workspace = { maxPreload = nil },
        format = {
          enable = false,
        },
      },
    },
  }
)

M.tsserver = {
  init_options = {
    preferences = {
      jsxAttributeCompletionStyle = 'auto',
      includeInlayParameterNameHints = 'all',
      includeInlayParameterNameHintsWhenArgumentMatchesName = true,
      includeInlayFunctionParameterTypeHints = true,
      includeInlayVariableTypeHints = true,
      includeInlayPropertyDeclarationTypeHints = true,
      includeInlayFunctionLikeReturnTypeHints = true,
      includeInlayEnumMemberValueHints = true,
    },
  },
}

M.r_language_server = {}

M.rescriptls = {}

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
        args = { '-f', '%l', '%p', os.getenv 'EDITOR' or 'nvim' },
      },
    },
  },
}

-- M.ltex = require 'user.lsp.servers.ltex'

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

M.html = {}
M.cssls = {}

M.yamlls = {}

M.ocamllsp = {}

M.rust_analyzer = {
  settings = {
    ['rust-analyzer'] = {
      lens = {
        run = true,
      },
      checkOnSave = {
        enable = true,
        command = 'clippy',
      },
    },
  },
}

return M
