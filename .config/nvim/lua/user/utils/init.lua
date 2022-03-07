-- local bufferline = require 'bufferline'

local buffer = {}
local keymapping = {}
local events = {}

keymapping.register = function(tbl) end

keymapping.set = function(modes, key, value) end

keymapping.set = {}

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
