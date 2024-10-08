local utils = require 'repl.utils'
local builtin = require 'repl.builtin'

require('repl').setup {
  sources = {
    -- builtin.node,
    builtin.r.with {
      bin = 'R',
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
            -- vim.print(params)
            if params.lang == 'r' then
              repl:send(params.line)
            end
          end,
          ['<leader>r'] = function(repl, params)
            local block = utils.get_block {
              scope = { 'binary', 'pipe', 'left_assignment', 'call' },
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
            repl:send(
              ([[rmarkdown::render("%s", knit_root_dir = here::here())]]):format(
                params.name
              )
            )
          end,
        },
        v = {
          ['<leader>l'] = function(repl, params)
            repl:send(params.selection)
          end,
        },
      },
    },
    builtin.python.with {
      pre_start = function(repl)
        local bin = '.venv/bin/activate'
        if vim.fn.executable(bin) == 1 then
          repl:send 'source .venv/bin/activate'
        end
      end,
      mappings = {
        n = {
          ['<leader>l'] = function(repl, params)
            repl:send(params.line)
          end,
          ['<leader>r'] = function(repl)
            local block = utils.get_block {
              scope = {
                'import_statement',
                'import_from_statement',
                'future_import_statement',
                'expression_statement',
                'for_statement',
                'if_statement',
                'while_statement',
                'with_statement',
                'assert_statement',
                'match_statement',
                'try_statement',
                'function_definition',
                'class_definition',
                'type_alias_statement',
              },
            }
            if block == nil then
              return
            end
            -- TODO: config with tab
            local lines = vim.split(block, '\n')

            for _, line in pairs(lines) do
              repl:send(line)
            end

            if #lines > 1 then
              repl:send '\n'
            end
            -- repl:send(block .. '\n')
          end,
          -- Run Above
          ['<leader>ra'] = function(repl)
            local linr = vim.api.nvim_win_get_cursor(0)[1] - 1
            local lines = vim.api.nvim_buf_get_lines(0, 0, linr, true)
            local text = table.concat(lines, '\n')
            repl:send(text)
          end,
        },
        v = {
          ['<leader>l'] = function(repl, params)
            repl:send(params.selection)
          end,
        },
      },
    },
  },
}
