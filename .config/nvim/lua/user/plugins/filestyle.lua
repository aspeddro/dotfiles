local filestyle = require 'filestyle'
local utils = require 'filestyle.utils'

filestyle.setup {
  overrides = {
    python = function()
      -- return filestyle.utils.indent { style = 'tab', size = 4 }
      return utils.make(utils.indent { style = 'tab', size = 4 }):add {
        formatoptions = {
          t = true,
          c = true,
          o = false,
        },
      }
    end,
    make = utils.indent { style = 'tab', size = 4 },
  },
}
