local cmp = require 'cmp'

cmp.setup {
  window = {
    completion = {
      border = 'none',
    },
    documentation = {
      border = 'rounded',
      winhighlight = 'Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None',
    },
  },
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert {
    ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item { behavior = cmp.SelectBehavior.Select }
      else
        fallback()
      end
    end),
    ['<CR>'] = cmp.mapping.confirm { select = false },
    ['<Esc>'] = {
      i = cmp.mapping.abort(),
    },
  },
  formatting = {
    format = require('lspkind').cmp_format {
      with_text = true,
      menu = {
        nvim_lsp = '[LSP]',
        buffer = '[Buffer]',
        luasnip = '[LuaSnip]',
        emoji = '[Emoji]',
        path = '[Path]',
        git = '[Git]',
        cmp_pandoc = '[Pandoc]',
        -- copilot = '[Copilot]',
      },
    },
  },
  sources = cmp.config.sources {
    { name = 'nvim_lsp' },
    -- { name = 'copilot', group_index = 2 },
    { name = 'luasnip' },
    { name = 'buffer', option = { keyword_length = 3 } },
    { name = 'path' },
    -- { name = 'latex_symbols' }, -- very slow
    -- { name = 'emoji' },
    { name = 'cmp_pandoc' },
    { name = 'git' },
    -- { name = 'spell' },
    -- {
    --   name = "dictionary",
    --   keyword_length = 5,
    -- }
  },
  experimental = {
    native_menu = false,
    ghost_text = false,
  },
}

require('cmp_pandoc').setup {
  crossref = {
    enable_nabla = true,
  },
}

require('cmp_git').setup {
  filetypes = { 'gitcommit', 'markdown' },
}

-- stylua: ignore
cmp.setup.filetype({ 'markdown', 'rmd', 'pandoc' }, {
  sources = cmp.config.sources {
    { name = 'buffer' },
    { name = 'emoji' },
    { name = 'luasnip' },
    { name = 'cmp_pandoc' },
    -- { name = 'cmp_git' },
    { name = 'path' }
  },
})

-- stylua: ignore
cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources {
    { name = 'buffer' },
    { name = 'conventionalcommits' },
    { name = 'git' },
  },
})

-- stylua: ignore
cmp.setup.cmdline('/', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  },
})

-- stylua: ignore
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources {
    { name = 'path' },
    {
      name = 'cmdline',
      max_item_count = 30,
      keyword_length = 2,
    }
  },
})
