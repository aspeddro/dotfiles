local npairs = require 'nvim-autopairs'
local Rule = require 'nvim-autopairs.rule'
local cond = require 'nvim-autopairs.conds'

npairs.setup()

npairs.remove_rule "'"
npairs.remove_rule '('
npairs.remove_rule '%'
npairs.remove_rule '<'
npairs.remove_rule '```'
npairs.remove_rule '{'

local is_valid_cond = function(opts)
  return string.match(opts.next_char, '%w') == nil
end

npairs.add_rules {
  Rule('(', ')'):with_pair(is_valid_cond),
  Rule('{', '}'):with_pair(is_valid_cond),

  Rule('$', '$', { 'markdown', 'rmd' }),

  Rule("'", "'", { '-rescript', '-r', '-ocaml' }),

  Rule("'", "'", 'r'):with_pair(cond.not_before_regex '^#$'),
}
