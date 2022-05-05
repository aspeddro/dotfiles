local npairs = require 'nvim-autopairs'
local Rule = require 'nvim-autopairs.rule'
local endwise = require('nvim-autopairs.ts-rule').endwise
local ts_conds = require 'nvim-autopairs.ts-conds'
local cond = require 'nvim-autopairs.conds'
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
npairs.remove_rule '('
npairs.remove_rule '%'
npairs.remove_rule '<'
npairs.remove_rule '```'

npairs.add_rules {
  -- Rule('(', ')'):with_pair(cond.not_filetypes {
  --   'ocaml',
  --   'query',
  --   'fennel',
  --   'clojure',
  --   'dune',
  --   'lua'
  -- }),

  Rule('(', ')', { '-lua', '-ocaml', '-dune', '-query', '-scheme' }),

  Rule('(', ')', 'lua'):with_pair(cond.not_after_regex '[%{|%(]'),

  Rule('(', ')', { 'ocaml', 'query', 'scheme' }):with_pair(
    cond.not_after_regex '%('
  ),
  Rule("'", "'", { '-rescript' }),

  Rule('$', '$', { 'markdown', 'rmd' }),

  Rule("'", "'"):with_pair(ts_conds.is_in_range(function(param)
    if not param then
      return false
    end
    if
      vim.tbl_contains({ 'type_parameters', 'variant_parameters' }, param.type)
    then
      return false
    else
      return true
    end
  end, function()
    local pos = vim.api.nvim_win_get_cursor(0)
    return { pos[1] - 1, pos[2] }
  end)),

  Rule('<', '>', { 'rust', 'typescript', 'typescriptreact' }):with_pair(
    ts_conds.is_ts_node {
      'type_identifier',
      'parameters',
      'let_declaration',
      -- 'type_arguments',
    }
  ),

  Rule('<', '>', 'lua'):with_pair(ts_conds.is_in_range(function(params)
    if not params then
      return false
    end
    local words_before_cursor = vim.split(
      string.sub(params.line, 1, params.cursor[2]),
      ' '
    )
    local last_word =
      words_before_cursor[#words_before_cursor]:match '[a-zA-Z]+$'
    if
      (
        (params.type == 'source' and params.lang == 'comment')
        or params.type == 'comment'
      ) and vim.tbl_contains({ 'array', 'table' }, last_word)
    then
      return true
    end
    return false
  end, function()
    local pos = vim.api.nvim_win_get_cursor(0)
    return { pos[1] - 1, pos[2] - 1 }
  end)),

  Rule('<', '>', 'rescript'):with_pair(ts_conds.is_in_range(function(params)
    if not params then
      return false
    end
    if params.type == 'type_identifier' then
      return true
    end
    return false
  end, function()
    local pos = vim.api.nvim_win_get_cursor(0)
    return { pos[1] - 1, pos[2] - 1 }
  end)),
}
