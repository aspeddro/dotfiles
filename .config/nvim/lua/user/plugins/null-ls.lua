local null_ls = require 'null-ls'

local formatting = null_ls.builtins.formatting
local code_actions = null_ls.builtins.code_actions

null_ls.setup {
  debug = false,
  sources = {
    formatting.prettier.with {
      prefer_local = 'node_modules/.bin',
      condition = function(utils)
        return utils.root_has_file {
          '.prettierrc',
          '.prettierrc.json',
          '.prettierrc.yml',
          '.prettierrc.yaml',
          '.prettierrc.json5',
          '.prettierrc.js',
          '.prettierrc.cjs',
          'prettier.config.js',
          'prettier.config.cjs',
          '.prettierrc.toml',
        }
      end,
    },
    -- formatting.prettierd,
    formatting.stylua.with {
      condition = function(utils)
        return utils.root_has_file { 'stylua.toml', '.stylua.toml' }
      end,
    },
    formatting.styler,
    formatting.black.with {
      condition = function(utils)
        return utils.root_has_file { 'setup.py', 'setup.cfg', 'pyproject.toml' }
      end,
    },
    formatting.rescript.with {
      condition = function(utils)
        return utils.root_has_file { 'bsconfig.json' }
      end,
      -- prefer_local = 'node_modules/.bin',
    },
    code_actions.gitsigns,
  },
  on_attach = function(client, bufnr)
    -- Format on Save
    if client.resolved_capabilities.document_formatting then
      vim.cmd [[
        augroup lsp_buf_format
          au! BufWritePre <buffer>
          autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()
        augroup END
      ]]
    end

    -- if client.resolved_capabilities.document_range_formatting then
    --   vim.api.nvim_buf_set_keymap(
    --     bufnr,
    --     'v',
    --     '<leader>f',
    --     '<cmd>lua vim.lsp.buf.range_formatting()<CR>',
    --     {
    --       noremap = true,
    --       silent = false,
    --     }
    --   )
    -- end
  end,
}
