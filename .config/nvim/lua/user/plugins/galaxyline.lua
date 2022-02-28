local gl = require 'galaxyline'
local gls = gl.section
local lspclient = require 'galaxyline.provider_lsp'
local condition = require 'galaxyline.condition'
local fileinfo = require 'galaxyline.provider_fileinfo'

gl.short_line_list = {
  'LuaTree',
  'vista',
  'dbui',
  'startify',
  'term',
  'NvimTree',
  'fugitive',
  'fugitiveblame',
  'plug',
  'dashboard',
  'toggleterm',
}
local colors = {
  bg = '#212121',
  line_bg = '#353644',
  fg = '#616161',
  fg_green = '#65a380',
  yellow = '#FFCB6B',
  cyan = '#89DDFF',
  darkblue = '#B2CCD6',
  green = '#C3E88D',
  orange = '#F78C6C',
  purple = '#C792EA',
  magenta = '#bb80b3',
  blue = '#82AAFF',
  red = '#f07178',
}
local buffer_not_empty = function()
  if vim.fn.empty(vim.fn.expand '%:t') ~= 1 then
    return true
  end
  return false
end
local checkwidth = function()
  local squeeze_width = vim.fn.winwidth(0) / 2
  if squeeze_width > 40 then
    return true
  end
  return false
end

local function has_file_type()
  local f_type = vim.bo.filetype
  if not f_type or f_type == '' then
    return false
  end
  return true
end

gls.left = {
  {
    ViMode = {
      provider = function()
        -- auto change color according the vim mode
        local alias = {
          n = 'NORMAL',
          i = 'INSERT',
          c = 'COMMAND',
          V = 'VISUAL',
          [''] = 'VISUAL',
          v = 'VISUAL',
          ['r?'] = ':CONFIRM',
          rm = '--MORE',
          R = 'REPLACE',
          Rv = 'VIRTUAL',
          s = 'SELECT',
          S = 'SELECT',
          ['r'] = 'HIT-ENTER',
          [''] = 'SELECT',
          t = 'TERMINAL',
          ['!'] = 'SHELL',
        }
        local mode_color = {
          n = colors.orange,
          i = colors.green,
          v = colors.cyan,
          [''] = colors.blue,
          V = colors.cyan,
          c = colors.red,
          no = colors.magenta,
          s = colors.orange,
          S = colors.orange,
          [''] = colors.orange,
          ic = colors.yellow,
          R = colors.purple,
          Rv = colors.purple,
          cv = colors.red,
          ce = colors.red,
          r = colors.cyan,
          rm = colors.cyan,
          ['r?'] = colors.cyan,
          ['!'] = colors.green,
          t = colors.green,
        }
        local vim_mode = vim.fn.mode()
        vim.api.nvim_command('hi GalaxyViMode guifg=' .. mode_color[vim_mode])
        return '  ' .. alias[vim_mode]
      end,
      highlight = { colors.fg, colors.bg },
      separator = '  ',
      separator_highlight = { colors.bg, colors.bg },
    },
  },
  {
    FileIcon = {
      provider = 'FileIcon',
      condition = buffer_not_empty,
      highlight = {
        require('galaxyline.provider_fileinfo').get_file_icon_color,
        colors.bg,
      },
    },
  },
  {
    FileName = {
      provider = 'FileName',
      condition = buffer_not_empty,
      highlight = { colors.fg, colors.bg },
    },
  },
}

gls.right = {
  {
    DiagnosticError = {
      provider = 'DiagnosticError',
      icon = '  ',
      highlight = { colors.fg, colors.bg },
    },
  },
  {
    DiagnosticHint = {
      provider = 'DiagnosticHint',
      icon = ' ',
      highlight = { colors.fg, colors.bg },
    },
  },
  {
    DiagnosticWarn = {
      provider = 'DiagnosticWarn',
      icon = '   ',
      highlight = { colors.fg, colors.bg },
    },
  },
  {
    DiagnosticInfo = {
      provider = 'DiagnosticInfo',
      icon = '   ',
      highlight = { colors.fg, colors.bg },
    },
  },
  {
    LspStatus = {
      provider = function()
        return string.format('%s ', lspclient.get_lsp_client())
      end,
      icon = ' ',
      condition = function()
        return condition.check_active_lsp() and condition.hide_in_width()
      end,
      highlight = { colors.fg, colors.bg },
    },
  },
  {
    GitBranch = {
      icon = ' ',
      provider = 'GitBranch',
      condition = require('galaxyline.provider_vcs').check_git_workspace,
      highlight = { colors.fg, colors.bg },
    },
  },
  {
    DiffAdd = {
      provider = 'DiffAdd',
      condition = checkwidth,
      icon = '+',
      highlight = { colors.green, colors.bg },
      separator = ' ',
      separator_highlight = { colors.bg, colors.bg },
    },
  },
  {
    DiffModified = {
      provider = 'DiffModified',
      condition = checkwidth,
      icon = '~',
      highlight = { colors.orange, colors.bg },
    },
  },
  {
    DiffRemove = {
      provider = 'DiffRemove',
      condition = checkwidth,
      icon = '-',
      highlight = { colors.red, colors.bg },
    },
  },
  {
    LineNumber = {
      provider = function()
        return vim.fn.line '.'
      end,
      -- icon = 'Ln ',
      condition = buffer_not_empty,
      highlight = { colors.fg, colors.bg },
    },
  },
  {
    ColumnNumber = {
      provider = function()
        return vim.fn.col '.'
      end,
      -- icon = 'Col ',
      condition = buffer_not_empty,
      highlight = { colors.fg, colors.bg },
      separator = ':',
      separator_highlight = { colors.fg, colors.bg },
    },
  },
  {
    FileType = {
      provider = 'FileTypeName',
      highlight = { colors.fg, colors.bg },
      separator = ' ',
      separator_highlight = { colors.fg, colors.bg },
    },
  },
  {
    FileFormat = {
      provider = 'FileFormat',
      highlight = { colors.fg, colors.bg },
      separator = ' ',
      separator_highlight = { colors.bg, colors.bg },
    },
  },
  {
    FileEncode = {
      provider = function()
        return fileinfo.get_file_encode()
      end,
      condition = condition.hide_in_width,
      highlight = { colors.fg, colors.bg },
      separator = ' ',
      separator_highlight = { colors.bg, colors.bg },
    },
  },
}

gl.load_galaxyline()
