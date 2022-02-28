local lspconfig = require 'lspconfig'
local lsp_installer = require 'nvim-lsp-installer'
local mapx = require 'mapx'
local M = {}

vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics,
  {
    virtual_text = true,
    signs = false,
    -- underline = true,
    underline = {
      severity_limit = 'Warning',
    },
    update_in_insert = false,
    severity_sort = true,
  }
)

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

local border_opts = {
  border = 'rounded',
  max_width = 75,
}

vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
  vim.lsp.handlers.hover,
  border_opts
)

vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
  vim.lsp.handlers.signature_help,
  border_opts
)

local rust_analyser = function(params)
  local arguments = params.arguments[1].args.cargoArgs
  local directory = params.arguments[1].args.workspaceRoot

  local Term = require('toggleterm.terminal').Terminal:new {
    dir = directory,
  }

  Term:open()

  local command = table.concat(vim.tbl_flatten { 'cargo', arguments }, ' ')

  Term:send(command)
end

-- vim.lsp.commands['rust-analyzer.debugSingle'] = rust_analyser
vim.lsp.commands['rust-analyzer.runSingle'] = rust_analyser

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
--- @param client table
--- @param bufnr number
local on_attach = function(client, bufnr)
  -- Avoiding LSP formatting conflicts
  client.resolved_capabilities.document_formatting = false
  client.resolved_capabilities.document_range_formatting = false

  -- mapx.nnoremap(lhs: any, rhs: any, ...: any)
  mapx.nnoremap('gD', function()
    vim.lsp.buf.declaration()
  end, { buffer = bufnr })

  mapx.nnoremap('gd', function()
    vim.lsp.buf.definition()
  end, { buffer = bufnr })

  mapx.nnoremap('K', function()
    vim.lsp.buf.hover()
  end, { buffer = bufnr })

  mapx.nnoremap('gi', function()
    vim.lsp.buf.implementation()
  end, { buffer = bufnr })

  mapx.nnoremap('[d', function()
    vim.diagnostic.goto_prev()
  end, { buffer = bufnr })

  mapx.nnoremap(']d', function()
    vim.diagnostic.goto_next()
  end, { buffer = bufnr })

  mapx.nnoremap('gr', function()
    vim.lsp.buf.references()
  end, { buffer = bufnr })

  mapx.nnoremap('<space>e', function()
    vim.diagnostic.open_float()
  end, { buffer = bufnr })

  mapx.nnoremap('<space>d', function()
    vim.lsp.buf.type_definition()
  end, { buffer = bufnr })

  mapx.nnoremap('<space>lr', function()
    vim.lsp.codelens.run()
  end, { buffer = bufnr })

  mapx.nnoremap('<space>q', function()
    vim.diagnostic.setloclist()
  end, { buffer = bufnr })

  mapx.nnoremap('<space>k', function()
    vim.lsp.buf.signature_help()
  end, { buffer = bufnr })

  mapx.nnoremap('<space>rn', function()
    vim.lsp.buf.rename()
  end, { buffer = bufnr })

  mapx.nnoremap('<space>wa', function()
    vim.lsp.buf.add_workspace_folder()
  end, { buffer = bufnr })

  mapx.nnoremap('<space>ca', function()
    vim.lsp.buf.code_action()
  end, { buffer = bufnr })

  mapx.nnoremap('<space>wr', function()
    vim.lsp.buf.remove_workspace_folder()
  end, { buffer = bufnr })

  mapx.nnoremap('<space>wl', function()
    vim.notify(
      '[LSP Workspaces Folders]: '
        .. table.concat(vim.lsp.buf.list_workspace_folders(), ', ')
    )
  end, { buffer = bufnr })

  -- Set autocommands conditional on server_capabilities
  if client.resolved_capabilities.document_highlight then
    vim.cmd [[
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]]
  end

  if client.resolved_capabilities.code_lens then
    vim.cmd [[
      augroup lsp_document_codelens
        au! * <buffer>
        autocmd BufEnter ++once         <buffer> lua require"vim.lsp.codelens".refresh()
        autocmd BufWritePost,CursorHold <buffer> lua require"vim.lsp.codelens".refresh()
      augroup END
    ]]
  end

  -- if client.resolved_capabilities.code_lens then
  --   vim.api.nvim_exec(
  --     [[
  --     augroup lsp_code_lens_refresh
  --       autocmd! * <buffer>
  --       autocmd InsertLeave <buffer> lua vim.lsp.codelens.refresh()
  --       autocmd InsertLeave <buffer> lua vim.lsp.codelens.display()
  --     augroup END
  --   ]],
  --     false
  --   )
  -- end

  if client.supports_method 'textDocument/codeLens' then
    require('virtualtypes').on_attach()
  end
end

function M.server_config(name)
  local server = require('user.lsp.servers')[name]
  local ok, config = pcall(require, 'lspconfig.server_configurations.' .. name)
  local opts = (server == nil or vim.tbl_isempty(server))
      and (ok and config or {})
    or server

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

  return vim.tbl_deep_extend('force', {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    },
    capabilities = capabilities,
  }, opts)
end

function M.setup()
  local servers_list = require 'user.lsp.servers'

  local with_lsp_installer = vim.tbl_map(function(n)
    return n.name
  end, require('nvim-lsp-installer.servers').get_installed_servers())

  local not_installed = vim.tbl_filter(function(n)
    return not vim.tbl_contains(with_lsp_installer, n)
  end, vim.tbl_keys(servers_list))

  for _, server in pairs(not_installed) do
    lspconfig[server].setup(M.server_config(server))
  end

  lsp_installer.on_server_ready(function(server)
    server:setup(M.server_config(server.name))
  end)
end

return M
