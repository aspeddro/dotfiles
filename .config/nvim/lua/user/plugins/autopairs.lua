local Rule = require 'nvim-autopairs.rule'
local ts_conds = require 'nvim-autopairs.ts-conds'
local cond = require 'nvim-autopairs.conds'
local npairs = require 'nvim-autopairs'
local cmp_autopairs = require 'nvim-autopairs.completion.cmp'
local cmp = require 'cmp'

npairs.setup {
  -- enable_check_bracket_line = true,
  -- enable_moveright = true,
  check_ts = true,
  ts_config = {
    lua = { 'string' }, -- it will not add a pair on that treesitter node
    -- r = { 'string' },
  },
  disable_filetype = { 'TelescopePrompt' },
}

cmp.event:on(
  'confirm_done',
  cmp_autopairs.on_confirm_done {
    map_char = { tex = '' },
  }
)

npairs.remove_rule "'"
-- npairs.remove_rule '`'


-- stylua: ignore
npairs.add_rules {
  Rule('$', '$', { 'markdown', 'rmd' }),
  Rule("'", "'")
    :with_pair(cond.not_before_regex '^#$')
    :with_pair(cond.not_filetypes { 'rescript' }),

  Rule('<', '>', { 'rescript' })
    :with_pair(ts_conds.is_not_ts_node {'block', 'jsx_element'} ),
}
