local cmp = require 'cmp'

cmp.setup {
  window = {
    documentation = {
      border = 'single',
      winhighlight = 'Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:Visual,Search:None',
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
    ['<C-Space>'] = cmp.mapping.complete(),
  },
  formatting = {
    fields = { 'kind', 'abbr', 'menu' },
    format = function(entry, vim_item)
      local menu = ({
        nvim_lsp = '[LSP]',
        buffer = '[Buf]',
        luasnip = '[Snip]',
        emoji = '[Emoji]',
        path = '[Path]',
        git = '[Git]',
        cmp_pandoc = '[Pandoc]',
      })[entry.source.name]

      vim_item.menu = vim_item.kind .. (menu ~= nil and ' ' .. menu or '')
      vim_item.kind = require('lspkind').presets.codicons[vim_item.kind] or ''
      return vim_item
    end,
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  }, {
    { name = 'buffer', keyword_length = 3 },
    { name = 'path' },
    { name = 'cmp_pandoc' },
    { name = 'git' },
  }),
}

require('cmp_pandoc').setup {
  crossref = {
    enable_nabla = true,
  },
}

require('cmp_git').setup {
  filetypes = { 'gitcommit' },
}

-- cmp.setup.filetype({ 'markdown', 'rmd', 'pandoc' }, {
--   sources = cmp.config.sources {
--     { name = 'buffer', keyword_length = 3 },
--     { name = 'emoji' },
--     { name = 'luasnip' },
--     { name = 'cmp_pandoc' },
--     { name = 'path' },
--   },
-- })

-- cmp.setup.filetype('gitcommit', {
--   sources = cmp.config.sources {
--     { name = 'buffer' },
--     { name = 'git' },
--   },
-- })

-- cmp.setup.cmdline({ '/', '?' }, {
--   mapping = cmp.mapping.preset.cmdline(),
--   sources = {
--     { name = 'buffer' },
--   },
-- })

-- Somethis completion not work
-- cmp.setup.cmdline(':', {
--   mapping = cmp.mapping.preset.cmdline(),
--   sources = cmp.config.sources {
--     { name = 'path' },
--     {
--       name = 'cmdline',
--       max_item_count = 30,
--       keyword_length = 2,
--     },
--   },
-- })
