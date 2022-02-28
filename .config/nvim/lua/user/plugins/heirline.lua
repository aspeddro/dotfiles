local herline = require 'heirline'
local conditions = require 'heirline.conditions'
local utils = require 'heirline.utils'
local colors = require('blueberry').colors

local ViMode = {
  -- get vim current mode, this information will be required by the provider
  -- and the highlight functions, so we compute it only once per component
  -- evaluation and store it as a component attribute
  init = function(self)
    self.mode = vim.fn.mode(1) -- :h mode()
  end,
  -- Now we define some dictionaries to map the output of mode() to the
  -- corresponding string and color. We can put these into `static` to compute
  -- them at initialisation time.
  static = {
    mode_names = { -- change the strings if yow like it vvvvverbose!
      n = 'Normal',
      no = 'Normal?',
      nov = 'N?',
      noV = 'N?',
      ['no^V'] = 'N?',
      niI = 'Ni',
      niR = 'Nr',
      niV = 'Nv',
      nt = 'Nt',
      v = 'Visual',
      vs = 'Vs',
      V = 'V_',
      Vs = 'Vs',
      ['^V'] = '^V',
      ['^Vs'] = '^V',
      s = 'S',
      S = 'S_',
      ['^S'] = '^S',
      i = 'Insert',
      ic = 'Ic',
      ix = 'Ix',
      R = 'Replace',
      Rc = 'Rc',
      Rx = 'Rx',
      Rv = 'Rv',
      Rvc = 'Rv',
      Rvx = 'Rv',
      c = 'Command',
      cv = 'Ex',
      r = '...',
      rm = 'M',
      ['r?'] = '?',
      ['!'] = '!',
      t = 'Term',
    },
    mode_colors = {
      n = colors.cyan,
      i = colors.green,
      v = colors.orange,
      V = colors.orange,
      ['^V'] = colors.orange,
      c = colors.orange,
      s = colors.purple,
      S = colors.purple,
      ['^S'] = colors.purple,
      R = colors.orange,
      r = colors.orange,
      ['!'] = colors.red,
      t = colors.red,
    },
  },
  -- We can now access the value of mode() that, by now, would have been
  -- computed by `init()` and use it to index our strings dictionary.
  -- note how `static` fields become just regular attributes once the
  -- component is instantiated.
  -- To be extra meticulous, we can also add some vim statusline syntax to
  -- control the padding and make sure our string is always at least 2
  -- characters long. Plus a nice Icon.
  provider = function(self)
    local mode = self.mode_names[self.mode]
    return mode and mode:upper() or self.mode
  end,
  -- Same goes for the highlight. Now the foreground will change according to the current mode.
  hl = function(self)
    local mode = self.mode:sub(1, 1) -- get only the first mode character
    return { fg = self.mode_colors[mode] }
  end,
}

local FileName = {
  provider = function()
    local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ':.')
    if filename == '' then
      return '[No Name]'
    end
    if not conditions.width_percent_below(filename:len(), 0.25) then
      return vim.fn.pathshorten(filename)
    end
    return filename
  end,
  hl = { fg = colors.blue },
}

local WorkDir = {
  provider = function()
    local wd = vim.loop.cwd()
    if not conditions.width_percent_below(wd:len(), 0.25) then
      return
    end
    return ' ' .. wd
  end,
}

local Git = {
  condition = conditions.is_git_repo,

  init = function(self)
    self.status_dict = vim.b.gitsigns_status_dict
    self.has_changes = self.status_dict.added ~= 0
      or self.status_dict.removed ~= 0
      or self.status_dict.changed ~= 0
  end,

  hl = { fg = colors.orange },

  { -- git branch name
    provider = function(self)
      return ' ' .. self.status_dict.head
    end,
    -- hl = { style = 'bold' },
  },
  -- You could handle delimiters, icons and counts similar to Diagnostics
  {
    condition = function(self)
      return self.has_changes
    end,
    provider = ' ',
  },
  {
    provider = function(self)
      local count = self.status_dict.added or 0
      return count > 0 and ('+' .. count .. ' ')
    end,
    hl = { fg = colors.green },
  },
  {
    provider = function(self)
      local count = self.status_dict.removed or 0
      return count > 0 and ('-' .. count .. ' ')
    end,
    hl = { fg = colors.red },
  },
  {
    provider = function(self)
      local count = self.status_dict.changed or 0
      return count > 0 and ('~' .. count .. ' ')
    end,
    hl = { fg = colors.blue },
  },
  {
    condition = function(self)
      return self.has_changes
    end,
    provider = '',
  },
}

local Diagnostics = {

  condition = conditions.has_diagnostics,

  static = {
    error_icon = ' ',
    warn_icon = ' ',
    info_icon = ' ',
    hint_icon = ' ',
  },

  init = function(self)
    self.errors = #vim.diagnostic.get(
      0,
      { severity = vim.diagnostic.severity.ERROR }
    )
    self.warnings = #vim.diagnostic.get(
      0,
      { severity = vim.diagnostic.severity.WARN }
    )
    self.hints = #vim.diagnostic.get(
      0,
      { severity = vim.diagnostic.severity.HINT }
    )
    self.info = #vim.diagnostic.get(
      0,
      { severity = vim.diagnostic.severity.INFO }
    )
  end,

  -- {
  --   provider = '![',
  -- },
  {
    provider = function(self)
      -- 0 is just another output, we can decide to print it or not!
      return self.errors > 0 and (self.error_icon .. self.errors .. ' ')
    end,
    hl = { fg = colors.error },
  },
  {
    provider = function(self)
      return self.warnings > 0 and (self.warn_icon .. self.warnings .. ' ')
    end,
    hl = { fg = colors.yellow },
  },
  {
    provider = function(self)
      return self.info > 0 and (self.info_icon .. self.info .. ' ')
    end,
    hl = { fg = colors.cyan },
  },
  {
    provider = function(self)
      return self.hints > 0 and (self.hint_icon .. self.hints)
    end,
    hl = { fg = colors.cyan },
  },
  -- {
  --   provider = ']',
  -- },
}

local LSPActive = {
  condition = conditions.lsp_attached,

  -- You can keep it simple,
  -- provider = " [LSP]",

  -- Or complicate things a bit and get the servers names
  provider = function()
    local names = {}
    for _, server in ipairs(vim.lsp.buf_get_clients(0)) do
      table.insert(names, server.name)
    end
    return ' [' .. table.concat(names, ' ') .. ']'
  end,
  hl = { fg = colors.green },
}

-- We're getting minimalists here!
local Ruler = {
  -- %l = current line number
  -- %L = number of lines in the buffer
  -- %c = column number
  -- %P = percentage through file of displayed window
  -- provider = '%7(%l/3L%):%2c %P',
  provider = '%l:%c/%L',
}

local FileType = {
  provider = function()
    return string.upper(vim.bo.filetype)
  end,
  hl = { fg = colors.purple },
}

local FileEncoding = {
  provider = function()
    local enc = (vim.bo.fileencoding ~= '' and vim.bo.fileencoding) or vim.o.enc -- :h 'enc'
    return enc:upper()
  end,
}

local FileFormat = {
  provider = function()
    local fmt = vim.bo.fileformat
    return fmt:upper()
  end,
}

local FileFlags = {
  {
    provider = function()
      if vim.bo.modified then
        return '[+]'
      end
    end,
    hl = { fg = colors.green },
  },
  {
    provider = function()
      if not vim.bo.modifiable or vim.bo.readonly then
        return ''
      end
    end,
    hl = { fg = colors.orange },
  },
}

local Align = { provider = '%=' }
local Space = { provider = ' ' }

local BasicStatus = {
  Space,
  WorkDir,
  Space,
  FileName,
  Space,
  Git,
  Align,
  Diagnostics,
  Space,
  LSPActive,
  Space,
  FileFlags,
  Space,
  FileEncoding,
  Space,
  FileFormat,
  Space,
  FileType,
  Space,
  Ruler,
  Space,
}

local InactiveStatusline = {
  condition = function()
    return not conditions.is_active()
      and not conditions.buffer_matches {
        buftype = { 'nofile', 'prompt', 'help', 'quickfix', 'NvimTree' },
        filetype = { '^git.*', 'fugitive', 'NvimTree', 'toggleterm' },
      }
  end,
  BasicStatus,
}

local EmptyStatusLine = {
  condition = function()
    return conditions.buffer_matches {
      buftype = {
        'nofile',
        'prompt',
        'help',
        'quickfix',
        'NvimTree',
        'toggleterm',
      },
      filetype = { '^git.*', 'fugitive', 'NvimTree', 'toggleterm' },
    }
  end,
  {
    provider = nil,
  },
}

local DefaultStatusLine = {
  Space,
  ViMode,
  BasicStatus,
}

local StatusLine = {
  hl = function()
    if conditions.is_active() then
      return {
        fg = colors.fg,
        bg = colors.bg,
      }
    else
      return {
        fg = colors.fg,
        bg = colors.bg,
      }
    end
  end,

  init = utils.pick_child_on_condition,
  InactiveStatusline,
  EmptyStatusLine,
  DefaultStatusLine,
}

herline.setup(StatusLine)
