local lspconfig = require 'lspconfig'
local lsp_menu = require 'lsp_menu'

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
  if client.server_capabilities.documentFormattingProvider then
    -- local group =
    --   vim.api.nvim_create_augroup('LSP/documentFormat', { clear = true })
    -- vim.api.nvim_create_autocmd('BufWritePre', {
    --   group = group,
    --   callback = function()
    --     vim.lsp.buf.format {
    --       timeout_ms = 2000,
    --       async = true,
    --     }
    --   end,
    --   buffer = bufnr,
    -- })
    -- vim.api.nvim_buf_create_user_command(bufnr, 'FormatLSP', function()
    --   vim.lsp.buf.format {
    --     timeout_ms = 2000,
    --     async = true,
    --   }
    -- end, { nargs = 0 })
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

  if client.server_capabilities.inlayHintProvider then
    require('lsp-inlayhints').on_attach(client, bufnr)
  end

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

  require('rescript-tools').on_attach(client, bufnr)

  lsp_menu.on_attach(client, bufnr)

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

  keymap_set('<space>l', lsp_menu.codelens.run)

  keymap_set('<space>k', vim.lsp.buf.signature_help)

  keymap_set('<space>rn', vim.lsp.buf.rename)

  keymap_set('<space>wa', vim.lsp.buf.add_workspace_folder)

  keymap_set('<space>ca', lsp_menu.codeaction.run)

  keymap_set(
    '<space>ca',
    require('lsp_menu').codeaction.run,
    { mode = { 'v', 'n' } }
  )

  keymap_set('<space>wr', vim.lsp.buf.remove_workspace_folder)

  keymap_set('<space>wl', function()
    vim.notify(
      '[LSP Workspace Folders]: '
        .. table.concat(vim.lsp.buf.list_workspace_folders(), ', '),
      vim.log.levels.INFO
    )
  end)

  keymap_set('<space>g', function()
    local diagnostics = vim.diagnostic.get(bufnr)
    if #diagnostics == 0 then
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
end;

(function()
  local servers = require 'user.lsp.servers'

  for server_name, server in pairs(servers) do
    local ok, config =
      pcall(require, 'lspconfig.server_configurations.' .. server_name)

    if not ok then
      vim.notify('Server ' .. server_name .. ' not found', vim.log.levels.ERROR)
      return
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

    server = vim.tbl_deep_extend('force', config.default_config, server)
    server = vim.tbl_deep_extend('force', {
      on_attach = on_attach,
      capabilities = capabilities,
    }, server)

    lspconfig[server_name].setup(server)
  end
end)()
