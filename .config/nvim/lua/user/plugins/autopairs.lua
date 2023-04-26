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

npairs.add_rules {
  Rule('(', ')'):with_pair(cond.not_after_regex('%w', 1)),
  Rule('{', '}'):with_pair(cond.not_after_regex('%w', 1)),

  Rule('$', '$', { 'markdown', 'rmd' }),

  Rule("'", "'", { '-rescript', '-r', '-ocaml' }),

  Rule("'", "'", 'r'):with_pair(cond.not_before_regex '^#$'),
}
