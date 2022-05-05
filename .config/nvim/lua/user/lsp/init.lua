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
  local lsp_format = vim.api.nvim_create_augroup('LSPFormat', { clear = true })
  vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
    group = lsp_format,
    callback = function()
      vim.lsp.buf.formatting_sync()
    end,
    buffer = bufnr,
  })

  if client.name == 'rust_analyzer' then
    local inlay_hints = vim.api.nvim_create_augroup(
      'LSPInlayHints',
      { clear = true }
    )

    vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI', 'CursorMoved' }, {
      group = inlay_hints,
      callback = function()
        require('user.lsp.handlers').show_line_hints()
      end,
      buffer = bufnr,
    })
  end

  if client.resolved_capabilities.code_lens then
    local codelens = vim.api.nvim_create_augroup(
      'LSPCodeLens',
      { clear = true }
    )
    vim.api.nvim_create_autocmd({ 'BufEnter', 'InsertLeave', 'CursorHold' }, {
      group = codelens,
      callback = function()
        vim.lsp.codelens.refresh()
      end,
      buffer = bufnr,
    })
  end

  local keymap_set = function(key, fn)
    return vim.keymap.set('n', key, fn, { buffer = bufnr })
  end

  -- document highlight
  require('illuminate').on_attach(client)
  -- Testings
  require('lsp_signature').on_attach({
    bind = true, -- This is mandatory, otherwise border config won't get registered.
    hint_enable = true,
    floating_window = false,
    hint_prefix = '',
    hint_scheme = 'TSComment',
    fix_pos = false,
    handler_opts = {
      border = 'rounded',
    },
  }, bufnr)

  lsp_menu.on_attach(client, bufnr)

  keymap_set('<space>n', function()
    require('illuminate').next_reference { wrap = true }
  end)

  keymap_set('gD', vim.lsp.buf.declaration)
  keymap_set('gd', vim.lsp.buf.definition)

  keymap_set('K', function()
    local ok, _ = pcall(vim.lsp.buf.hover)
    if not ok then
      require('hover').hover()
    end
  end)

  keymap_set('gi', vim.lsp.buf.implementation)

  keymap_set('[d', vim.diagnostic.goto_prev)

  keymap_set(']d', vim.diagnostic.goto_next)

  keymap_set('gr', vim.lsp.buf.references)

  keymap_set('<space>e', vim.diagnostic.open_float)

  keymap_set('<space>d', vim.lsp.buf.type_definition)

  keymap_set('<space>lr', function()
    -- vim.lsp.codelens.run()
    lsp_menu.codelens.run()
  end)

  keymap_set('<space>q', vim.diagnostic.setloclist)

  keymap_set('<space>k', vim.lsp.buf.signature_help)

  keymap_set('<space>rn', vim.lsp.buf.rename)

  keymap_set('<space>wa', vim.lsp.buf.add_workspace_folder)

  keymap_set('<space>ca', lsp_menu.codeaction.run)

  keymap_set('<space>wr', vim.lsp.buf.remove_workspace_folder)

  keymap_set('<space>wl', function()
    vim.notify(
      '[LSP Workspaces Folders]: '
        .. table.concat(vim.lsp.buf.list_workspace_folders(), ', '),
      vim.log.levels.INFO
    )
  end)
end;

-- TODO: refactor
(function()
  local servers = require 'user.lsp.servers'

  for server_name, server in pairs(servers) do
    if not server then
      return
    end

    local server_available, server_installed_opts = require(
      'nvim-lsp-installer.servers'
    ).get_server(server_name)

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

    server = vim.tbl_deep_extend('force', {
      on_attach = on_attach,
      capabilities = capabilities,
    }, server)

    if server_available and server_installed_opts:is_installed() then
      local server_default_opts = server_installed_opts:get_default_options()
      server = vim.tbl_deep_extend('force', server_default_opts, server)
    end

    lspconfig[server_name].setup(server)
  end
end)()
