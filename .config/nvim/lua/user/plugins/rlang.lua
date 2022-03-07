local rlang = require 'rlang'
rlang.setup {
  commands = {
    default = {
      enable = true,
      names = {
        start = 'RStart',
      },
    },
    custom = true,
    register = {
      ['RWith'] = function(params)
        rlang.start {
          bin = params.bin,
        }
      end,
      ['RQuit'] = function(params)
        rlang.send { input = string.format([[quit("%s")]], params.save) }
      end,
    },
  },
  switch_session_on_start = false,
  -- mapping = {
  --   n = {
  --     ['<leader>rs'] = function()
  --       rlang.start()
  --     end,
  --     ['<leader>l'] = function()
  --       rlang.actions.run_line()
  --     end,
  --     ['<leader>ll'] = function(params)
  --       rlang.actions.run_block()
  --     end,
  --     ['<leader>ss'] = function(params)
  --       if params.filetype == 'r' then
  --         rlang.send {
  --           input = rlang.utils.r_make {
  --             func = 'source',
  --             args = {
  --               string.format([["%s"]], params.bufname),
  --             },
  --           },
  --         }
  --       end
  --     end,
  --     ['<leader>lk'] = function()
  --       rlang.actions.run_chunck()
  --     end,
  --     ['<leader>la'] = function()
  --       rlang.actions.run_above()
  --     end,
  --     ['<leader>q'] = function()
  --       rlang.kill()
  --     end,
  --     ['<leader>rm'] = function()
  --       local rmarkdown = require('rlang.utils').r_make {
  --         func = 'rmarkdown::render',
  --         args = {
  --           string.format([["%s"]], vim.api.nvim_buf_get_name(0)),
  --         },
  --         filetype = { 'rmd' },
  --       }
  --       rlang.send(rmarkdown)
  --     end,
  --   },
  --   v = {
  --     ['<leader>l'] = function()
  --       rlang.actions.run_selection()
  --     end,
  --   },
  -- },
}
