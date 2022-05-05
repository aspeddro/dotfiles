local lspconfig = require 'lspconfig'

-- request('workspace/executeCommand', command)
-- vim.lsp.buf_request(0, method, params, handler)
return {
  root_dir = function(filename)
    return lspconfig.util.path.dirname(filename)
  end,
  on_init = function(client, _)
    -- Code Action Commands
    vim.lsp.commands['_ltex.addToDictionary'] = function(cmd, ctx)
      -- P { type(cmd), type(ctx) }
    end
  end,
  settings = {
    ltex = {
      -- language = { 'en-US', 'pt-BR' },
      completionEnabled = true,
      language = 'en-US',
      checkFrequency = 'edit',
      setenceCacheSize = 5000,
      additionalRules = {
        enablePickyRules = true,
        motherTongue = 'en-US',
      },
      dictionary = {
        -- ['pt-BR'] = { ':' .. vim.fn.expand '~/.local/share/dict/pt-BR.txt' },
        ['pt-BR'] = { 'ola', 'bom dia', 'neovim' },
        ['en-US'] = { 'Hello', 'Nice' },
      },
    },
  },
}
