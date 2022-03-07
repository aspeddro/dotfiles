local cmp = require 'cmp'

cmp.setup {
  documentation = {
    border = 'rounded',
    winhighlight = 'NormalFloat:NormalFloat,Normal:FloatBorder',
  },
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = {
    ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item {
          behavior = require('cmp.utils.api').is_cmdline_mode()
              and cmp.SelectBehavior.Insert
            or cmp.SelectBehavior.Select,
        }
      else
        fallback()
      end
    end, { 'i', 'c' }),
    -- ['<Tab>'] = cmp.mapping(function(fallback)
    --   if cmp.visible() then
    --     cmp.select_next_item {
    --       behavior = cmp_api.is_cmdline_mode() and cmp.SelectBehavior.Insert
    --         or cmp.SelectBehavior.Select,
    --     }
    --   elseif
    --     luasnip.expand_or_locally_jumpable() and not check_back_space()
    --   then
    --     -- luasnip.expand_or_jump()
    --   else
    --     fallback()
    --   end
    -- end, {
    --   'i',
    --   's',
    --   'c',
    -- }),
    ['<CR>'] = cmp.mapping.confirm { select = false },
    ['<Esc>'] = cmp.mapping {
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    },
  },
  formatting = {
    format = require('lspkind').cmp_format {
      with_text = true,
      menu = {
        buffer = '[Buffer]',
        nvim_lsp = '[LSP]',
        luasnip = '[LuaSnip]',
        emoji = '[Emoji]',
        path = '[Path]',
        cmp_git = '[Git]',
        cmp_pandoc = '[Pandoc]',
      },
    },
  },
  sources = cmp.config.sources {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    -- { name = 'nvim_lua' },
    { name = 'path' },
    -- { name = 'latex_symbols' }, -- very slow, julia lang only?
    -- { name = 'buffer', keyword_length = 3 },
    -- { name = 'emoji' },
    { name = 'cmp_pandoc' },
    { name = 'cmp_git' },
    {
      { name = 'buffer' },
    },
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

-- cmp.setup.filetype('markdown', {
--   sources = {
--     { name = 'emoji' },
--   },
-- })

-- Use buffer source for `/`.
-- stylua: ignore
cmp.setup.cmdline('/', {
  comletion = {
    autocomplete = false,
  },
  sources = cmp.config.sources(
    {
      { name = "nvim_lsp_document_symbol" }
    },
    {
      { name = 'buffer' }
    }
  )
})

-- Use cmdline & path source for ':'.
-- stylua: ignore
cmp.setup.cmdline(':', {
  comletion = {
    autocomplete = false,
  },
  sources = cmp.config.sources(
    {
      { name = 'path' },
    },
    {
      {
        name = 'cmdline',
        max_item_count = 20,
        keyword_length = 3,
      },
    }
  ),
})

require('cmp_pandoc').setup {
  crossref = {
    enable_nabla = true,
  },
}

require('cmp_git').setup()
