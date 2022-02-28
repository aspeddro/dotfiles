local cokeline = require 'cokeline'
local colors = require('blueberry').colors
cokeline.setup {

  -- show_if_buffers_are_at_least = 2,

  mappings = {
    cycle_prev_next = true,
  },

  default_hl = {
    focused = {
      fg = colors.fg,
      bg = 'NONE',
      style = 'bold',
    },
    unfocused = {
      fg = colors.gray,
      bg = 'bold',
    },
  },

  rendering = {
    left_sidebar = {
      filetype = 'NvimTree',
      components = {
        {
          text = function(a)
            return ''
          end,
          hl = {
            fg = colors.bg_alt,
            bg = colors.bg_alt,
            style = 'bold',
          },
        },
      },
    },
  },

  components = {
    {
      text = function(buffer)
        return buffer.index ~= 1 and '| ' or ''
      end,
    },
    -- {
    --   text = function(buffer)
    --     return buffer.index .. ': '
    --   end,
    --   hl = {
    --     style = function(buffer)
    --       return buffer.is_focused and 'bold' or nil
    --     end,
    --   },
    -- },
    {
      text = '  ',
    },
    {
      text = function(buffer)
        return buffer.devicon.icon
      end,
      hl = {
        fg = function(buffer)
          return buffer.devicon.color
        end,
      },
    },
    {
      text = function(buffer)
        return buffer.unique_prefix
      end,
      -- hl = {
      --   fg = function(buffer)
      --     return buffer.is_focused and colors.purple or colors.gray
      --   end,
      --   style = 'italic',
      -- },
    },

    {
      text = function(buffer)
        return buffer.filename .. ' '
      end,
      -- hl = {
      --   style = function(buffer)
      --     return buffer.is_focused and 'bold' or nil
      --   end,
      -- },
    },
    {
      text = function(buffer)
        return buffer.is_modified and '• ' or ''
      end,
      hl = {
        fg = function(buffer)
          return buffer.is_focused and colors.red
        end,
      },
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
