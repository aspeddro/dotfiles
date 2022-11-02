local utils = require 'repl.utils'
local builtin = require 'repl.builtin'

require('repl').setup {
  sources = {
    -- builtin.node,
    builtin.r.with {
      commands = {
        enable = true,
        RStart = {
          function(repl, params)
            local layout = vim.tbl_contains(params.fargs, 'bottom') and 'split'
              or 'vsplit'
            repl:start { layout = layout }
          end,
        },
        RKill = {
          function(repl, opts)
            if vim.tbl_contains(opts.fargs, 'nosave') then
              repl:send [[q("no")]]
            end
            repl:kill()
          end,
          nargs = '*',
          -- complete = function() end,
        },
      },
      mappings = {
        n = {
          ['<leader>l'] = function(repl, params)
            -- P(params)
            if params.lang == 'r' then
              repl:send(params.line)
            end
          end,
          ['<leader>r'] = function(repl, params)
            -- P(params)
            local block = utils.get_block {
              scope = { 'binary', 'pipe', 'left_assignment' },
            }
            if params.ft == 'r' then
              repl:send(block)
            else
              if params.lang == 'r' then
                repl:send(block)
              end
            end
          end,
          ['<leader>rm'] = function(repl, params)
            -- RMarkdown render using workspace directory
            repl:send(([[rmarkdown::render("%s", knit_root_dir = here::here())]]):format(params.name))
          end,
        },
        v = {
          ['<leader>l'] = function(repl, params)
            repl:send(params.selection)
          end,
        },
      },
    },
    -- builtin.python,
  },
}
