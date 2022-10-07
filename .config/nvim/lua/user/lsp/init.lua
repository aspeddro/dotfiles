local lspconfig = require 'lspconfig'
local lsp_menu = require 'lsp_menu'

require 'user.lsp.handlers'
require 'user.lsp.commands'

vim.diagnostic.config {
  virtual_text = true,
  sings = false,
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
  local lsp_format =
    vim.api.nvim_create_augroup('LSP/documentFormat', { clear = true })
  vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
    group = lsp_format,
    callback = function()
      vim.lsp.buf.format {
        timeout_ms = 2000,
        async = true
      }
    end,
    buffer = bufnr,
  })

  if client.server_capabilities.documentHighlightProvider then
    local id =
      vim.api.nvim_create_augroup('LSP/documentHighlight', { clear = true })
    vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
      callback = vim.lsp.buf.document_highlight,
      buffer = bufnr,
      group = id,
    })
    vim.api.nvim_create_autocmd('CursorMoved', {
      callback = vim.lsp.buf.clear_references,
      buffer = bufnr,
      group = id,
    })
  end

  if client.server_capabilities.colorProvider then
    require('document-color').buf_attach(bufnr)
  end

  if client.server_capabilities.documentSymbolProvider then
    require('nvim-navic').attach(client, bufnr)
  end

  if client.server_capabilities.codeLensProvider then
    local id = vim.api.nvim_create_augroup('LSP/CodeLens', { clear = true })
    vim.api.nvim_create_autocmd({ 'BufEnter', 'InsertLeave', 'CursorHold' }, {
      group = id,
      callback = vim.lsp.codelens.refresh,
      buffer = bufnr,
    })
  end

  require('lsp_signature').on_attach({
    hint_enable = true,
    floating_window = false,
    hint_prefix = '',
    hint_scheme = 'LspSignatureActiveParameter',
    fix_pos = false,
  }, bufnr)

  lsp_menu.on_attach(client, bufnr)

  local keymap_set = function(key, fn)
    return vim.keymap.set('n', key, fn)
  end

  keymap_set('gD', vim.lsp.buf.declaration)
  keymap_set('gd', vim.lsp.buf.definition)
  keymap_set('gp', require('goto-preview').goto_preview_definition)

  keymap_set('K', vim.lsp.buf.hover)

  keymap_set('gi', vim.lsp.buf.implementation)

  keymap_set('[d', vim.diagnostic.goto_prev)

  keymap_set(']d', vim.diagnostic.goto_next)

  keymap_set('gr', vim.lsp.buf.references)

  keymap_set('<space>e', vim.diagnostic.open_float)

  keymap_set('<space>d', vim.lsp.buf.type_definition)

  keymap_set('<space>l', lsp_menu.codelens.run)

  -- keymap_set('<space>q', vim.diagnostic.setloclist)

  keymap_set('<space>k', vim.lsp.buf.signature_help)

  keymap_set('<space>rn', vim.lsp.buf.rename)

  keymap_set('<space>wa', vim.lsp.buf.add_workspace_folder)

  keymap_set('<space>ca', lsp_menu.codeaction.run)

  keymap_set('<space>wr', vim.lsp.buf.remove_workspace_folder)

  keymap_set('<space>wl', function()
    vim.notify(
      '[LSP Workspace Folders]: '
        .. table.concat(vim.lsp.buf.list_workspace_folders(), ', '),
      vim.log.levels.INFO
    )
  end)
end;

(function()
  local servers = require 'user.lsp.servers'

  for server_name, server in pairs(servers) do
    if not server then
      vim.notify('Server ' .. server_name .. ' not found')
      return
    end

    local _, config =
      pcall(require, 'lspconfig.server_configurations.' .. server_name)

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true
    capabilities.textDocument.completion.completionItem.resolveSupport = {
      properties = {
        'documentation',
        'detail',
        'additionalTextEdits',
      },
    }
    capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

    capabilities.textDocument.colorProvider = {
      dynamicRegistration = true,
    }
    server = vim.tbl_deep_extend('force', config.default_config, server)
    server = vim.tbl_deep_extend('force', {
      on_attach = on_attach,
      capabilities = capabilities,
    }, server)

    lspconfig[server_name].setup(server)
  end
end)()
