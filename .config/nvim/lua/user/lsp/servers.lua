local util = require 'lspconfig.util'

local M = {}

M.sumneko_lua = {
  settings = {
    Lua = {
      version = 'LuaJIT',
      completion = { callSnippet = 'Disable' },
      workspace = {
        -- Load only ~/.config/nvim/lua/ files and emmmy-lua plugin
        library = vim.list_extend(
          vim.api.nvim_get_runtime_file('lua/user/*/*.lua', true),
          vim.api.nvim_get_runtime_file('nvim/library/*.lua', true)
        ),
      },
      diagnostics = {
        globals = { 'vim', 'it', 'before_each', 'after_each', 'describe' },
      },
      format = {
        enable = false,
      },
      telemetry = {
        enable = false,
      },
    },
  },
}

M.tsserver = {
  settings = {
    javascript = {
      inlayHints = {
        includeInlayEnumMemberValueHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayParameterNameHints = 'all', -- 'none' | 'literals' | 'all';
        includeInlayParameterNameHintsWhenArgumentMatchesName = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayVariableTypeHints = true,
      },
    },
    typescript = {
      inlayHints = {
        includeInlayEnumMemberValueHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayParameterNameHints = 'all', -- 'none' | 'literals' | 'all';
        includeInlayParameterNameHintsWhenArgumentMatchesName = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayVariableTypeHints = true,
      },
    },
  },
  -- init_options = {
  --   preferences = {
  --     jsxAttributeCompletionStyle = 'auto',
  --     includeInlayParameterNameHints = 'all',
  --     includeInlayParameterNameHintsWhenArgumentMatchesName = true,
  --     includeInlayFunctionParameterTypeHints = true,
  --     includeInlayVariableTypeHints = true,
  --     includeInlayPropertyDeclarationTypeHints = true,
  --     includeInlayFunctionLikeReturnTypeHints = true,
  --     includeInlayEnumMemberValueHints = true,
  --   },
  -- },
}

M.r_language_server = {}

M.rescriptls = {
  cmd = false and {
    'node',
    '/home/pedro/Desktop/projects/rescript-vscode/server/out/server.js',
    '--stdio',
  } or { 'rescript-lsp', '--stdio' },
  init_options = {
    extensionConfiguration = {
      binaryPath = nil,
      platformPath = nil,
      askToStartBuild = false,
      codeLens = true,
      signatureHelp = {
        enable = true,
      },
      inlayHints = {
        enable = false,
      },
    },
  },
}

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

M.ocamllsp = (function()
  local cmd = not vim.tbl_isempty(
        vim.fs.find('bsconfig.json', { upward = true })
      )
      -- Melange support
      and { 'opam', 'exec', '--', 'ocamllsp', '--fallback-read-dot-merlin' }
    or { 'opam', 'exec', '--', 'ocamllsp' }
  return { cmd = cmd }
end)()

M.pyright = {}

M.taplo = {}
M.vimls = {}

M.tailwindcss = {
  root_dir = util.root_pattern('tailwind.config.js', 'tailwind.config.ts'),
}

M.bashls = {}

M.marksman = {
  single_file_support = true,
}

M.rust_analyzer = {
  settings = {
    ['rust-analyzer'] = {
      lens = {
        run = true,
        debug = true,
      },
      checkOnSave = {
        enable = true,
        command = 'clippy',
      },
    },
  },
}

M.clangd = {}

return M
