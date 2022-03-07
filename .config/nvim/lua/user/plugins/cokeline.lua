local cokeline = require 'cokeline'
local colors = require('blueberry').colors
local get_hex = require('cokeline.utils').get_hex

cokeline.setup {

  -- show_if_buffers_are_at_least = 2,

  mappings = {
    cycle_prev_next = true,
  },
  default_hl = {
    bg = colors.bg,
    fg = function(buffer)
      return buffer.is_focused and colors.fg or colors.gray
    end,
  },
  sidebar = {
    filetype = 'NvimTree',
    components = {
      {
        text = ' ',
        fg = colors.fg,
        bg = colors.bg_alt,
        style = 'bold',
      },
    },
  },

  components = {
    {
      text = function(buffer)
        return buffer.index ~= 1 and '| ' or ''
      end,
      fg = colors.cyan,
    },
    {
      text = '  ',
    },
    {
      text = function(buffer)
        return buffer.devicon.icon
      end,
      fg = function(buffer)
        return buffer.devicon.color
      end,
    },
    {
      text = function(buffer)
        return buffer.unique_prefix
      end,
    },
    {
      text = function(buffer)
        return buffer.filename .. ' '
      end,
    },
    {
      text = function(buffer)
        return buffer.is_modified and '• ' or ''
      end,
      fg = function(buffer)
        return buffer.is_focused and colors.red
      end,
    },
    {
      text = '',
      delete_buffer_on_left_click = true,
    },
    {
      text = '  ',
    },
  },
}
