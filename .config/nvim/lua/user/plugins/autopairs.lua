local npairs = require 'nvim-autopairs'
local Rule = require 'nvim-autopairs.rule'
local ts_conds = require 'nvim-autopairs.ts-conds'
local cond = require 'nvim-autopairs.conds'
local cmp_autopairs = require 'nvim-autopairs.completion.cmp'
-- local handlers = require 'nvim-autopairs.completion.handlers'
local cmp = require 'cmp'

npairs.setup()

cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())

npairs.remove_rule "'"
npairs.remove_rule '('
npairs.remove_rule '%'
npairs.remove_rule '<'
npairs.remove_rule '```'

npairs.add_rules {
  Rule('(', ')', { '-lua', '-ocaml', '-dune', '-query', '-scheme' }),

  Rule('(', ')', 'lua'):with_pair(cond.not_after_regex '[%{|%(]'),

  Rule('(', ')', { 'ocaml', 'query', 'scheme', 'dune' }):with_pair(
    cond.not_after_regex '%('
  ),

  Rule(
    '(',
    ')',
    { 'javascript', 'typescript', 'javascriptreact', 'typescriptreact' }
  ):with_pair(ts_conds.is_in_range(function(param)
    if not param then
      return false
    end
    return not vim.tbl_contains(
      { 'named_imports', 'import_statement' },
      param.type
    )
  end, function()
    local cursor = vim.api.nvim_win_get_cursor(0)
    return { cursor[1] - 1, cursor[2] }
  end)),

  Rule('$', '$', { 'markdown', 'rmd' }),

  Rule("'", "'", { '-rescript', '-r' }),

  Rule("'", "'", 'r'):with_pair(cond.not_before_regex '^#$'),

  Rule("'", "'", 'rescript'):with_pair(ts_conds.is_in_range(function(param)
    if not param then
      return true
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
    local words_before_cursor =
      vim.split(string.sub(params.line, 1, params.cursor[2]), ' ')
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
