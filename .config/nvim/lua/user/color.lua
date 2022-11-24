local M = {}

---@param hex_str string
---@return string[]
local function hexToRgb(hex_str)
  local hex = '[abcdef0-9][abcdef0-9]'
  local pat = '^#(' .. hex .. ')(' .. hex .. ')(' .. hex .. ')$'
  hex_str = string.lower(hex_str)

  assert(
    string.find(hex_str, pat) ~= nil,
    'hex_to_rgb: invalid hex_str: ' .. tostring(hex_str)
  )

  local r, g, b = string.match(hex_str, pat)
  return { tonumber(r, 16), tonumber(g, 16), tonumber(b, 16) }
end

---@param fg string foreground color
---@param bg string background color
---@param alpha number number between 0 and 1. 0 results in bg, 1 results in fg
---@return string
local blend = function(fg, bg, alpha)
  local bg_hex = hexToRgb(bg)
  local fg_hex = hexToRgb(fg)

  local blendChannel = function(i)
    local ret = (alpha * fg_hex[i] + ((1 - alpha) * bg_hex[i]))
    return math.floor(math.min(math.max(0, ret), 255) + 0.5)
  end

  return string.format(
    '#%02X%02X%02X',
    blendChannel(1),
    blendChannel(2),
    blendChannel(3)
  )
end

-- '#ff8eeb'
-- '#8164ff'
-- '#e7e6e8'
-- '#00be89'

local pallete = {
  none = 'NONE',
  bg = '#212121',
  bg_alt = '#1A1A1A',
  -- fg = '#EEFFFF',
  fg = '#e7e6e8',
  white = '#ffffff',
  black = '#000000',
  red = '#f07178',
  orange = '#F78C6C',
  yellow = '#FFCB6B',
  green = '#C3E88D',
  cyan = '#89DDFF',
  blue = '#82AAFF',
  paleblue = '#B2CCD6',
  purple = '#C792EA',
  brown = '#916b53',
  pink = '#ffa5b7',
  violet = '#bb80b3',
  gray = '#4A4A4A',
  extra = {
    orange = '#FBAC6C',
    green = '#A6E3C6',
    green2 = '#C8FF75',
    blue = '#4D4DFF',
    blue1 = '#6161FF',
    blue2 = '#6B6BFF',
    paleblue = '#576266',
    purple = '#C07BD7',
    pink = '#F87BB4',
    viole = '#E26FCD',
    gray = '#848484',
    gray1 = '#999999',
  },
  rainbow = {
    '#ffd700',
    '#da70d6',
    '#179fff',
  },
}

M = pallete
M.utils = {
  blend = blend,
}

-- TODO: more colors
-- #6bffb5 (green)

M.selection = '#383838'
M.comment = '#5A5A5A'

M.error = '#EC5A5A'
M.bg_layer = '#2B2B2B' -- REMOVE:
M.text_pop_menu = '#848484'
M.vertical_split = '#212121'
M.line_highlight = '#171717'
M.line_number = '#424242'
M.line_number_highlight = '#848484'
M.indent_char = '#292929'
M.bg_add = '#2F3A3E'
M.diff_add = blend('#5E6C49', pallete.bg, 0.3)
M.diff_change = blend('#455575', pallete.bg, 0.3)
M.diff_delete = blend('#6F3F42', pallete.bg, 0.3)
M.git_sings_add = '#586643'
M.git_sings_change = '#455575'
M.git_sings_delete = '#523435'

-- Sidebar
M.fg_sidebar = '#848484'
M.folder_icon = '#90A4AE'
M.git_add = '#c3e88d8f'
M.git_change = '#82aaff8f'
M.git_delete = '#573F42'

return M
