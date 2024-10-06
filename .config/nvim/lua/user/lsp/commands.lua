--- LSP Commands client side

local terminal = require 'user.modules.terminal'

local rust_analyser = function(params)
  local workspace = params.arguments[1].args.workspaceRoot

  local command = vim
    .iter({ 'cargo', params.arguments[1].args.cargoArgs })
    :flatten(2)
    :totable()

  if vim.uv.cwd() ~= workspace then
    vim.list_extend(command, { '--manifest-path', workspace .. '/Cargo.toml' })
  end

  local jobid = terminal.new()
  terminal.send(jobid, table.concat(command, ' '))
end

-- Code Lens
vim.lsp.commands['rust-analyzer.runSingle'] = rust_analyser
-- vim.lsp.commands['rust-analyzer.debugSingle'] = rust_analyser
