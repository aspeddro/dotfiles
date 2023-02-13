local lspconfig = require 'lspconfig'
local util = lspconfig.util

require 'user.lsp.handlers'
require 'user.lsp.commands'

-- vim.lsp.set_log_level 'debug'

vim.diagnostic.config {
  virtual_text = true,
  signs = false,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  float = {
    show_header = true,
    border = 'rounded',
    focusable = false,
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

  if client.server_capabilities.documentFormattingProvider then
    keymap_set('<space>f', function()
      vim.lsp.buf.format {
        timeout_ms = 2000,
        async = true,
      }
    end)
  end

  if client.server_capabilities.documentHighlightProvider then
    local group =
      vim.api.nvim_create_augroup('LSP/documentHighlight', { clear = true })
    vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
      callback = vim.lsp.buf.document_highlight,
      buffer = bufnr,
      group = group,
    })
    vim.api.nvim_create_autocmd('CursorMoved', {
      callback = function()
        --NOTE: Prevent Error executing vim.schedule lua callback: /usr/share/nvim/runtime/lua/vim/uri.lua:86: Invalid buffer id: number
        if vim.api.nvim_buf_is_loaded(bufnr) then
          vim.lsp.buf.clear_references()
        end
      end,
      buffer = bufnr,
      group = group,
    })
  end

  -- ERROR: https://github.com/simrat39/inlay-hints.nvim/issues/10
  -- if client.server_capabilities.inlayHintProvider then
  --   require('lsp-inlayhints').on_attach(client, bufnr)
  -- end

  if client.server_capabilities.colorProvider then
    require('document-color').buf_attach(bufnr)
  end

  if client.server_capabilities.documentSymbolProvider then
    require('nvim-navic').attach(client, bufnr)
  end

  if client.server_capabilities.codeLensProvider then
    local group = vim.api.nvim_create_augroup('LSP/CodeLens', { clear = true })
    vim.api.nvim_create_autocmd({ 'InsertLeave', 'CursorHold' }, {
      group = group,
      callback = vim.lsp.codelens.refresh,
      buffer = bufnr,
    })
    vim.api.nvim_create_autocmd('BufEnter', {
      group = group,
      callback = vim.lsp.codelens.refresh,
      buffer = bufnr,
      once = true,
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

  keymap_set('gD', vim.lsp.buf.declaration)

  keymap_set('gd', function()
    -- vim.lsp.buf.definition
    require('glance').open 'definitions'
  end)

  -- keymap_set('gp', require('goto-preview').goto_preview_definition)

  keymap_set('K', vim.lsp.buf.hover)

  keymap_set('gi', function()
    -- vim.lsp.buf.implementation
    require('glance').open 'implementations'
  end)

  keymap_set('gr', function()
    -- vim.lsp.buf.references
    require('glance').open 'references'
  end)

  keymap_set('<space>d', vim.lsp.buf.type_definition)

  keymap_set('<space>l', vim.lsp.codelens.run)

  keymap_set('<space>k', vim.lsp.buf.signature_help)

  keymap_set('<space>rn', vim.lsp.buf.rename)

  keymap_set('<space>wa', vim.lsp.buf.add_workspace_folder)

  keymap_set('<space>ca', vim.lsp.buf.code_action, { mode = { 'v', 'n' } })

  keymap_set('<space>wr', vim.lsp.buf.remove_workspace_folder)

  keymap_set('<space>ds', require('telescope.builtin').lsp_document_symbols)

  keymap_set('<space>wl', function()
    vim.notify(
      '[LSP Workspace Folders]: '
        .. table.concat(vim.lsp.buf.list_workspace_folders(), ', '),
      vim.log.levels.INFO
    )
  end)

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
  end)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    'documentation',
    'detail',
    'additionalTextEdits',
  },
}
capabilities.textDocument.colorProvider = {
  dynamicRegistration = true,
}
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

local flags = {
  -- This is the default in Nvim 0.7+
  debounce_text_changes = 150,
}

lspconfig.lua_ls.setup {
  on_attach = on_attach,
  flags = flags,
  capabilities = capabilities,
  settings = {
    Lua = {
      version = 'LuaJIT',
      completion = { callSnippet = 'Disable' },
      workspace = {
        library = vim.api.nvim_get_runtime_file('', true),
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

require('typescript').setup {
  disable_commands = false,
  debug = false,
  go_to_source_definition = {
    fallback = true, -- fall back to standard LSP definition on failure
  },
  server = {
    on_attach = on_attach,
    flags = flags,
    capabilities = capabilities,
  },
}

lspconfig.r_language_server.setup {
  on_attach = on_attach,
  flags = flags,
  capabilities = capabilities,
}

lspconfig.rescriptls.setup {
  on_attach = on_attach,
  flags = flags,
  capabilities = capabilities,
  cmd = false and {
    'node',
    util.path.join {
      vim.fn.expand '~/Desktop',
      'projects',
      'rescript-vscode',
      'server',
      'out',
      'server.js',
    },
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
  flags = flags,
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
  flags = flags,
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
  flags = flags,
  capabilities = capabilities,
}
lspconfig.cssls.setup {
  on_attach = on_attach,
  flags = flags,
  capabilities = capabilities,
}
lspconfig.yamlls.setup {
  on_attach = on_attach,
  flags = flags,
  capabilities = capabilities,
}

lspconfig.ocamllsp.setup {
  cmd = { 'opam', 'exec', '--', 'ocamllsp' },
  filetypes = vim.list_extend(
    require('lspconfig.server_configurations.ocamllsp').default_config.filetypes,
    { 'ocamlinterface' }
  ),
  on_attach = on_attach,
  flags = flags,
  capabilities = capabilities,
}

lspconfig.pyright.setup {
  on_attach = on_attach,
  flags = flags,
  capabilities = capabilities,
}

lspconfig.taplo.setup {
  on_attach = on_attach,
  flags = flags,
  capabilities = capabilities,
}
lspconfig.vimls.setup {
  on_attach = on_attach,
  flags = flags,
  capabilities = capabilities,
}

lspconfig.tailwindcss.setup {
  on_attach = on_attach,
  flags = flags,
  capabilities = capabilities,
  root_dir = util.root_pattern('tailwind.config.js', 'tailwind.config.ts'),
}

lspconfig.bashls.setup {
  on_attach = on_attach,
  flags = flags,
  capabilities = capabilities,
}

lspconfig.marksman.setup {
  on_attach = on_attach,
  flags = flags,
  capabilities = capabilities,
  single_file_support = true,
}

lspconfig.rust_analyzer.setup {
  on_attach = on_attach,
  flags = flags,
  capabilities = capabilities,
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

lspconfig.clangd.setup {
  on_attach = on_attach,
  flags = flags,
  capabilities = capabilities,
}

lspconfig.elixirls.setup {
  cmd = { 'elixir-ls' },
  on_attach = on_attach,
  flags = flags,
  capabilities = capabilities,
}
