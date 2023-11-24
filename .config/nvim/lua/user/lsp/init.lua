local lspconfig = require 'lspconfig'
local util = lspconfig.util

require 'user.lsp.handlers'
require 'user.lsp.commands'

-- vim.lsp.set_log_level 'debug'

vim.diagnostic.config {
  virtual_text = true,
  signs = false,
  underline = false,
  update_in_insert = false,
  severity_sort = true,
  float = {
    show_header = true,
    border = 'single',
    focusable = true,
    source = 'always',
  },
}

local on_attach = function(client, bufnr)
  local keymap_set = function(key, fn, opts)
    return vim.keymap.set(
      opts and opts.mode or 'n',
      key,
      fn,
      { buffer = bufnr, desc = 'LSP ' .. (opts and opts.desc or '') }
    )
  end

  -- Enable completion triggered by <c-x><c-o>
  -- vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  if vim.tbl_contains({ 'lua_ls' }, client.name) then
    client.server_capabilities.semanticTokensProvider = nil
  end

  if client.server_capabilities.documentFormattingProvider then
    keymap_set('<space>f', function()
      vim.lsp.buf.format {
        timeout_ms = 2000,
        async = true,
      }
    end, { desc = 'Format' })
  end

  if client.server_capabilities.documentHighlightProvider then
    local group =
      vim.api.nvim_create_augroup('LSP/documentHighlight', { clear = false })

    vim.api.nvim_clear_autocmds { group = group, buffer = bufnr }

    vim.api.nvim_create_autocmd({ 'CursorHold' }, {
      callback = vim.lsp.buf.document_highlight,
      buffer = bufnr,
      group = group,
    })
    vim.api.nvim_create_autocmd('CursorMoved', {
      callback = vim.lsp.buf.clear_references,
      buffer = bufnr,
      group = group,
    })
  end

  if client.server_capabilities.inlayHintProvider then
    require('lsp-inlayhints').on_attach(client, bufnr)
  end

  if client.server_capabilities.codeLensProvider then
    local group = vim.api.nvim_create_augroup('LSP/CodeLens', { clear = true })

    vim.api.nvim_clear_autocmds { group = group, buffer = bufnr }

    vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'CursorHold' }, {
      group = group,
      callback = vim.lsp.codelens.refresh,
      buffer = bufnr,
    })
  end

  if client.server_capabilities.signatureHelpProvider then
    require('lsp_signature').on_attach({
      hint_enable = true,
      floating_window = false,
      hint_prefix = '',
      hint_scheme = 'LspSignatureActiveParameter',
      fix_pos = false,
    }, bufnr)
  end

  if client.server_capabilities.documentSymbolProvider then
    require('nvim-navic').attach(client, bufnr)
  end

  keymap_set('gD', vim.lsp.buf.declaration, { desc = 'Declaration' })

  keymap_set('gd', function()
    -- vim.lsp.buf.definition
    require('glance').open 'definitions'
  end, { desc = 'Definition' })

  keymap_set('K', vim.lsp.buf.hover, { desc = 'Hover' })

  keymap_set('gi', function()
    -- vim.lsp.buf.implementation
    require('glance').open 'implementations'
  end, { desc = 'Implementation' })

  keymap_set('gr', function()
    -- vim.lsp.buf.references
    require('glance').open 'references'
  end, { desc = 'References' })

  keymap_set(
    '<space>d',
    vim.lsp.buf.type_definition,
    { desc = 'Type Definition' }
  )

  keymap_set('<space>l', vim.lsp.codelens.run, { desc = 'Code Lens Run' })

  keymap_set(
    '<space>k',
    vim.lsp.buf.signature_help,
    { desc = 'Signature Help' }
  )

  keymap_set('<space>rn', vim.lsp.buf.rename, { desc = 'Rename' })

  keymap_set(
    '<space>wa',
    vim.lsp.buf.add_workspace_folder,
    { desc = 'Add Workspace Folder' }
  )

  keymap_set(
    '<space>ca',
    vim.lsp.buf.code_action,
    { mode = { 'v', 'n' }, desc = 'Code Action' }
  )

  keymap_set(
    '<space>wr',
    vim.lsp.buf.remove_workspace_folder,
    { desc = 'Remove Workspace Folder' }
  )

  keymap_set(
    '<space>ds',
    require('telescope.builtin').lsp_document_symbols,
    { desc = 'Document Symbol' }
  )

  keymap_set('<space>wl', function()
    vim.notify(
      '[LSP Workspace Folders]: '
        .. table.concat(vim.lsp.buf.list_workspace_folders(), ', '),
      vim.log.levels.INFO
    )
  end, { desc = 'Workspace Folders' })

  keymap_set('<space>g', function()
    local diagnostics = vim.diagnostic.get(bufnr)

    if vim.tbl_isempty(diagnostics) then
      vim.notify(
        'Diagnostics not found for buffer ' .. bufnr,
        vim.log.levels.INFO
      )
      return
    end

    local items = vim.diagnostic.toqflist(diagnostics)

    vim.fn.setqflist({}, ' ', { title = 'Buffer Diagnostics', items = items })

    vim.cmd 'botright copen'
  end, { desc = 'Buffer diagnostics' })
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

-- Completion configuration
vim.tbl_deep_extend(
  'force',
  capabilities,
  require('cmp_nvim_lsp').default_capabilities()
)

capabilities.textDocument.completion.completionItem.insertReplaceSupport = false
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.colorProvider = {
  dynamicRegistration = true,
}

-- PERF: didChangeWatchedFiles is too slow
-- https://github.com/neovim/neovim/issues/23291#issuecomment-1686709265
capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = false

require('neodev').setup {
  library = {
    plugins = false,
  },
}
lspconfig.lua_ls.setup {
  on_init = function(client)
    local path = client.workspace_folders[1].name
    if
      not vim.loop.fs_stat(path .. '/.luarc.json')
      and not vim.loop.fs_stat(path .. '/.luarc.jsonc')
    then
      client.config.settings =
        vim.tbl_deep_extend('force', client.config.settings, {
          Lua = {
            runtime = {
              -- Tell the language server which version of Lua you're using
              -- (most likely LuaJIT in the case of Neovim)
              version = 'LuaJIT',
            },
            -- Make the server aware of Neovim runtime files
            workspace = {
              checkThirdParty = false,
              library = {
                vim.env.VIMRUNTIME,
                -- "${3rd}/luv/library"
                -- "${3rd}/busted/library",
              },
              -- or pull in all of 'runtimepath'. NOTE: this is a lot slower
              -- library = vim.api.nvim_get_runtime_file("", true)
            },
          },
        })

      client.notify(
        'workspace/didChangeConfiguration',
        { settings = client.config.settings }
      )
    end
    return true
  end,
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    Lua = {
      version = 'LuaJIT',
      completion = { callSnippet = 'Disable' },
      workspace = {
        -- library = {
        --   vim.env.VIMRUNTIME,
        --   vim.fn.stdpath 'config',
        --   vim.fn.stdpath 'data' .. '/lazy/emmylua-nvim',
        -- },
        checkThirdParty = false,
      },
      diagnostics = {
        globals = {
          'vim',
          'it',
          'before_each',
          'after_each',
          'describe',
          'jit',
        },
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

lspconfig.tsserver.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  root_dir = lspconfig.util.root_pattern('tsconfig.json', 'jsconfig.json'),
  single_file_support = true,
  settings = {
    typescript = {
      inlayHints = {
        includeInlayParameterNameHints = 'all',
        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
      },
    },
    javascript = {
      inlayHints = {
        includeInlayParameterNameHints = 'all',
        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
      },
    },
  },
}

-- lspconfig.denols.setup {
--   root_dir = lspconfig.util.root_pattern 'deno.json',
--   on_attach = on_attach,
--   capabilities = capabilities,
--   server = {
--     settings = {
--       deno = {
--         enable = true,
--         unstable = true,
--       },
--     },
--   },
-- }

lspconfig.r_language_server.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}

lspconfig.rescriptls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  root_dir = function(fname)
    -- Neovim dont send the real cwd to lsp
    -- TODO:
    -- 1. Check if exists and bsconfig.json and package.json at root
    -- 2. If bsconfig.json extist check if exists pinned-deps
    -- 3. If exists pinned-deps read package.json and check if exists workspaces field
    -- If has an bsconfig.json with pinned deps and an package.json with workspaces then make
    -- root_dir = vim.loop.cwd()

    local has_pinned_deps = (function()
      if vim.fn.filereadable 'bsconfig.json' == 1 then
        local bsconfig = table.concat(vim.fn.readfile 'bsconfig.json', '\n')
        local json = vim.json.decode(bsconfig)
        if not vim.tbl_isempty(json) then
          local pinned = json['pinned-dependencies']
          return pinned and not vim.tbl_isempty(pinned)
        end
      end
      return false
    end)()

    return has_pinned_deps and vim.loop.cwd()
      or util.root_pattern('bsconfig.json', '.git')(fname)
  end,
  cmd = (function()
    local isDev = true
    if isDev then
      return {
        util.path.join {
          vim.fn.expand '~/Desktop',
          'projects',
          'rescript-vscode',
          'server',
          'out',
          'cli.js',
          -- '_build',
          -- 'default',
          -- 'rescript-language-server',
          -- 'bin',
          -- 'main.exe',
        },
        '--stdio',
      }
    end

    return { 'rescript-language-server', '--stdio' }
  end)(),
  init_options = {
    extensionConfiguration = {
      -- binaryPath = nil,
      -- platformPath = nil,
      askToStartBuild = false,
      codeLens = false,
      signatureHelp = {
        enable = true,
      },
      inlayHints = {
        enable = false,
      },
    },
  },
  commands = {
    ResOpenCompiled = {
      require('rescript-tools').open_compiled,
      description = 'Open Compiled JS',
    },
    ResCreateInterface = {
      require('rescript-tools').create_interface,
      description = 'Create Interface file',
    },
    ResSwitchImplInt = {
      require('rescript-tools').switch_impl_intf,
      description = 'Switch Implementation/Interface',
    },
  },
}

lspconfig.texlab.setup {
  on_attach = on_attach,
  capabilities = capabilities,
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

lspconfig.jsonls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    json = {
      schemas = require('schemastore').json.schemas(),
      validate = { enable = true },
    },
  },
}

lspconfig.html.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}
lspconfig.cssls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}
lspconfig.yamlls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    yaml = {
      schemaStore = {
        -- You must disable built-in schemaStore support if you want to use
        -- this plugin and its advanced options like `ignore`.
        enable = false,
        -- Avoid TypeError: Cannot read properties of undefined (reading 'length')
        url = '',
      },
      schemas = require('schemastore').yaml.schemas(),
    },
  },
}

lspconfig.ocamllsp.setup {
  cmd = { 'opam', 'exec', '--', 'ocamllsp' },
  settings = {
    extendedHover = { enable = true },
    codelens = { enable = false },
  },
  filetypes = {
    'ocaml',
    'ocaml.menhir',
    'ocaml.interface',
    'ocaml.ocamllex',
    'reason',
    'dune',
    'ocamlinterface',
  },
  on_attach = on_attach,
  capabilities = capabilities,
}

lspconfig.pyright.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    python = {
      analysis = {
        autoSearchPaths = true,
        diagnosticMode = 'openFilesOnly',
        useLibraryCodeForTypes = true,
      },
    },
  },
}

lspconfig.taplo.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}
lspconfig.vimls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}

lspconfig.tailwindcss.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  root_dir = util.root_pattern(
    'tailwind.config.js',
    'tailwind.config.ts',
    'tailwind.config.mjs'
  ),
  settings = {
    tailwindCSS = {
      experimental = {
        -- Enable completion for template string ``
        -- https://github.com/tailwindlabs/tailwindcss/issues/7553
        classRegex = {
          -- '`([^`]*)',
          '["\'`]([^"\'`]*).*?["\'`]',
        },
      },
    },
  },
}

lspconfig.bashls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}

lspconfig.marksman.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  single_file_support = true,
}

lspconfig.rust_analyzer.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    ['rust-analyzer'] = {
      lens = {
        run = true,
        debug = true,
      },
      checkOnSave = {
        enable = true,
      },
    },
  },
}

lspconfig.clangd.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}

lspconfig.elixirls.setup {
  cmd = { 'elixir-ls' },
  on_attach = on_attach,
  capabilities = capabilities,
}

-- require('sg').setup {
--   on_attach = on_attach,
-- }
