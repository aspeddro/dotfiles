-- local bufferline = require 'bufferline'
local nest = require 'nest'

local buffer = {}
local keymapping = {}
local events = {}

keymapping.register = function(tbl)
  nest.applyKeymaps(tbl)
end

keymapping.set = function(modes, key, value)
  nest.applyKeymaps {
    {
      mode = table.concat(modes),
      {
        { key, value },
      },
    },
  }
end

keymapping.set = {
  n = function(tbl)
    nest.applyKeymaps {
      { mode = 'n', { tbl } },
    }
  end,
}

events.resize = function(direction)
  local commands_resize = {
    up = 'resize -2',
    down = 'resize +2',
    left = 'vertical resize -2',
    right = 'vertical resize +2',
  }

  vim.cmd(commands_resize[direction])

  -- require('bufresize').register()
end

return {
  keymapping = keymapping,
  events = events,
}
