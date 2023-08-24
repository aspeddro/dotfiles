local herline = require 'heirline'
local conditions = require 'heirline.conditions'
local u = require 'heirline.utils'

local EMPTY_FILENAME = '[No Name]'

local colors = {
  bright_bg = u.get_highlight('Folded').bg,
  bright_fg = u.get_highlight('Folded').fg,
  red = u.get_highlight('DiagnosticError').fg,
  dark_red = u.get_highlight('DiffDelete').bg,
  green = u.get_highlight('String').fg,
  blue = u.get_highlight('Function').fg,
  gray = u.get_highlight('NonText').fg,
  comment = u.get_highlight('Comment').fg,
  orange = u.get_highlight('Number').fg,
  purple = u.get_highlight('Statement').fg,
  cyan = u.get_highlight('Type').fg,
  diag_warn = u.get_highlight('DiagnosticWarn').fg,
  diag_error = u.get_highlight('DiagnosticError').fg,
  diag_hint = u.get_highlight('DiagnosticHint').fg,
  diag_info = u.get_highlight('DiagnosticInfo').fg,
  --TODO: add highlight for git
  git_del = u.get_highlight('DiagnosticError').fg,
  git_add = u.get_highlight('String').fg,
  git_change = u.get_highlight('Function').fg,
  normal_bg = u.get_highlight('Normal').bg,
  normal_fg = u.get_highlight('Normal').fg,
}

require('heirline').load_colors(colors)

local Align = { provider = '%=' }
local Space = { provider = ' ' }

local ViMode = {
  -- get vim current mode, this information will be required by the provider
  -- and the highlight functions, so we compute it only once per component
  -- evaluation and store it as a component attribute
  init = function(self)
    self.mode = vim.fn.mode(1) -- :h mode()

    -- execute this only once, this is required if you want the ViMode
    -- component to be updated on operator pending mode
    if not self.once then
      vim.api.nvim_create_autocmd('ModeChanged', {
        command = 'redrawstatus',
      })
      self.once = true
    end
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
      nt = 'Normal Term',
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
    -- mode_colors = {
    --   n = 'cyan',
    --   i = 'green',
    --   v = 'orange',
    --   V = 'orange',
    --   ['^V'] = 'orange',
    --   c = 'orange',
    --   s = 'purple',
    --   S = 'purple',
    --   ['^S'] = 'purple',
    --   R = 'orange',
    --   r = 'orange',
    --   ['!'] = 'red',
    --   t = 'red',
    -- },
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
  hl = function()
    return { fg = 'cyan' }
  end,
}

local FileName = {
  provider = function()
    local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ':.')
    if filename == '' then
      return EMPTY_FILENAME
    end
    -- if not conditions.width_percent_below(filename:len(), 0.25) then
    --   return vim.fn.pathshorten(filename)
    -- end
    return filename
  end,
  hl = { fg = 'purple' },
}

-- local WorkDir = {
--   provider = function()
--     local wd = vim.loop.cwd()
--     if not conditions.width_percent_below(wd:len(), 0.25) then
--       return
--     end
--     return ' ' .. wd
--   end,
-- }

local Git = {
  condition = conditions.is_git_repo,

  init = function(self)
    self.status_dict = vim.b.gitsigns_status_dict
    self.has_changes = self.status_dict.added ~= 0
      or self.status_dict.removed ~= 0
      or self.status_dict.changed ~= 0
  end,

  hl = { fg = 'orange' },

  { -- git branch name
    provider = function(self)
      return ' ' .. self.status_dict.head
    end,
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
    hl = { fg = 'git_add' },
  },
  {
    provider = function(self)
      local count = self.status_dict.removed or 0
      return count > 0 and ('-' .. count .. ' ')
    end,
    hl = { fg = 'git_del' },
  },
  {
    provider = function(self)
      local count = self.status_dict.changed or 0
      return count > 0 and ('~' .. count .. ' ')
    end,
    hl = { fg = 'git_change' },
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
    self.errors =
      #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
    self.warnings =
      #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
    self.hints =
      #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
    self.info =
      #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
  end,
  {
    provider = function(self)
      -- 0 is just another output, we can decide to print it or not!
      return self.errors > 0 and (self.error_icon .. self.errors .. ' ')
    end,
    hl = { fg = 'diag_error' },
  },
  {
    provider = function(self)
      return self.warnings > 0 and (self.warn_icon .. self.warnings .. ' ')
    end,
    hl = { fg = 'diag_warn' },
  },
  {
    provider = function(self)
      return self.info > 0 and (self.info_icon .. self.info .. ' ')
    end,
    hl = { fg = 'diag_info' },
  },
  {
    provider = function(self)
      return self.hints > 0 and (self.hint_icon .. self.hints)
    end,
    hl = { fg = 'diag_hint' },
  },
}

local LSPActive = {
  condition = conditions.lsp_attached,
  update = { 'LspAttach', 'LspDetach', 'BufEnter' },
  provider = function()
    local names = vim.tbl_map(function(client)
      return client.name
    end, vim.lsp.get_active_clients { bufnr = 0 })
    return ' [' .. table.concat(names, ' ') .. ']'
  end,
  hl = { fg = 'green' },
}

-- local Navic = {
--   condition = function()
--     return require('nvim-navic').is_available()
--   end,
--   update = 'CursorMoved',
--   provider = function()
--     return require('nvim-navic').get_location()
--   end,
--   hl = { fg = 'comment' },
-- }

local Ruler = {
  provider = '%l:%c/%L',
}

local FileType = {
  provider = function()
    return vim.bo.filetype
  end,
  hl = { fg = 'orange' },
}

local FileEncoding = {
  provider = function()
    return vim.bo.fileencoding ~= '' and vim.bo.fileencoding or vim.o.enc -- :h 'enc'
  end,
}

local FileFormat = {
  provider = function()
    return vim.bo.fileformat
  end,
}

local FileFlags = {
  {
    provider = function()
      if vim.bo.modified then
        return '[+]'
      end
    end,
    hl = { fg = 'orange' },
  },
  {
    provider = function()
      if not vim.bo.modifiable or vim.bo.readonly then
        return ''
      end
    end,
    hl = { fg = 'orange' },
  },
}

local BufferWindow = {
  provider = function()
    return string.format(
      '%d:%d',
      vim.api.nvim_get_current_buf(),
      vim.api.nvim_get_current_win()
    )
  end,
  hl = { fg = 'comment' },
}

local StatusLine = {
  hl = function()
    return 'StatusLine'
  end,
  fallthrough = true,
  Space,
  ViMode,
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

local FileIcon = {
  init = function(self)
    local filename = self.filename
    local extension = vim.fn.fnamemodify(filename, ':e')
    self.icon, self.icon_color = require('nvim-web-devicons').get_icon_color(
      filename,
      extension,
      { default = true }
    )
  end,
  provider = function(self)
    return self.icon and (self.icon .. ' ')
  end,
  hl = function(self)
    return { fg = self.icon_color }
  end,
}

-- we redefine the filename component, as we probably only want the tail and not the relative path
local TablineFileName = {
  provider = function(self)
    ---@see https://github.com/rebelot/heirline.nvim/discussions/89
    ---Get the names of all current listed buffers
    ---@return table
    local function get_current_filenames()
      local listed_buffers = vim.tbl_filter(function(bufnr)
        return vim.bo[bufnr].buflisted and vim.api.nvim_buf_is_loaded(bufnr)
      end, vim.api.nvim_list_bufs())

      return vim.tbl_map(vim.api.nvim_buf_get_name, listed_buffers)
    end

    ---Get unique name for the current buffer
    ---@param filename string
    ---@param shorten boolean
    ---@return string
    local function get_unique_filename(filename, shorten)
      local filenames = vim.tbl_filter(function(filename_other)
        return filename_other ~= filename
      end, get_current_filenames())

      if shorten then
        filename = vim.fn.pathshorten(filename)
        filenames = vim.tbl_map(vim.fn.pathshorten, filenames)
      end

      -- Reverse filenames in order to compare their names
      filename = string.reverse(filename)
      filenames = vim.tbl_map(string.reverse, filenames)

      local index

      -- For every other filename, compare it with the name of the current file char-by-char to
      -- find the minimum index `i` where the i-th character is different for the two filenames
      -- After doing it for every filename, get the maximum value of `i`
      if next(filenames) then
        index = math.max(unpack(vim.tbl_map(function(filename_other)
          for i = 1, #filename do
            -- Compare i-th character of both names until they aren't equal
            if filename:sub(i, i) ~= filename_other:sub(i, i) then
              return i
            end
          end
          return 1
        end, filenames)))
      else
        index = 1
      end

      -- Iterate backwards (since filename is reversed) until a "/" is found
      -- in order to show a valid file path
      while index <= #filename do
        if filename:sub(index, index) == '/' then
          index = index - 1
          break
        end

        index = index + 1
      end

      return string.reverse(string.sub(filename, 1, index))
    end
    -- self.filename will be defined later, just keep looking at the example!
    -- local filename = self.filename
    -- filename = filename == '' and empty_file_name
    --   or vim.fn.fnamemodify(filename, ':t')
    return self.filename == '' and EMPTY_FILENAME
      or get_unique_filename(self.filename, false)
  end,
  hl = function(self)
    return self.is_active and 'Normal' or 'NonText'
  end,
}

-- Here the filename block finally comes together
local TablineFileNameBlock = {
  init = function(self)
    self.filename = vim.api.nvim_buf_get_name(self.bufnr)
  end,
  on_click = {
    callback = function(_, _, _, _)
      -- if button == 'm' then -- close on mouse middle click
      --   vim.api.nvim_buf_delete(minwid, { force = false })
      -- else
      --
      -- end
      -- vim.api.nvim_win_set_buf(0, minwid)
    end,
    minwid = function(self)
      return self.bufnr
    end,
    name = 'heirline_tabline_buffer_callback',
  },
  Space,
  FileIcon,
  TablineFileName,
}

-- a nice "x" button to close the buffer
local TablineCloseButton = {
  Space,
  {
    provider = '󱎘',
    hl = { fg = 'gray' },
    on_click = {
      callback = function(_, minwid)
        vim.api.nvim_buf_delete(minwid, { force = false })

        -- Force redraw
        vim.cmd.redrawtabline()
      end,
      minwid = function(self)
        return self.bufnr
      end,
      name = 'heirline_tabline_close_buffer_callback',
    },
  },
}

-- The final touch!
local TablineBufferBlock = {
  {
    provider = '┃',
    hl = function(self)
      return self.is_active and { fg = 'orange' } or { fg = 'normal_bg' }
    end,
  },
  TablineFileNameBlock,
  TablineCloseButton,
  Space,
}

-- and here we go
local BufferLine = u.make_buflist(
  TablineBufferBlock,
  { provider = '«', hl = { fg = 'gray' } }, -- left truncation
  { provider = '»', hl = { fg = 'gray' } } -- right trunctation
)

local Tabpage = {
  provider = function(self)
    return '%' .. self.tabnr .. 'T ' .. self.tabnr .. ' %T'
  end,
  hl = function(self)
    return self.is_active and 'TabLine' or 'TabLineSel'
  end,
}

local TabpageClose = {
  provider = '%999X  %X',
  hl = 'TabLine',
}

local TabPages = {
  -- only show this component if there's 2 or more tabpages
  condition = function()
    return #vim.api.nvim_list_tabpages() >= 2
  end,
  { provider = '%=' },
  u.make_tablist(Tabpage),
  TabpageClose,
}

local TabLineOffset = {
  condition = function(self)
    local win = vim.api.nvim_tabpage_list_wins(0)[1]
    local bufnr = vim.api.nvim_win_get_buf(win)
    self.winid = win

    if
      vim.tbl_contains(
        { 'NvimTree', 'mind', 'DiffviewFiles' },
        vim.bo[bufnr].filetype
      )
    then
      self.title = ''
      return true
    end
  end,

  provider = function(self)
    local title = self.title
    local width = vim.api.nvim_win_get_width(self.winid)
    local pad = math.ceil((width - #title) / 2)
    return string.rep(' ', pad) .. title .. string.rep(' ', pad)
  end,

  hl = function(self)
    if vim.api.nvim_get_current_win() == self.winid then
      return 'TabLineSel'
    else
      return 'TabLine'
    end
  end,
}

local TabLine = { TabLineOffset, BufferLine, TabPages }

--WinBar
local WinBars = {
  fallthrough = true,
  -- Space,
  -- Navic,
  Align,
  {
    provider = function()
      local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ':.')
      if filename == '' then
        return EMPTY_FILENAME
      end
      return filename
    end,
    hl = { fg = 'comment' },
  },
  Space,
  BufferWindow,
  Space,
}

herline.setup {
  statusline = StatusLine,
  winbar = WinBars,
  tabline = TabLine,
  opts = {
    -- if the callback returns true, the winbar will be disabled for that window
    -- the args parameter corresponds to the table argument passed to autocommand callbacks. :h nvim_lua_create_autocmd()
    disable_winbar_cb = function(args)
      local buf = args.buf
      local buftype = vim.tbl_contains(
        { 'prompt', 'nofile', 'help', 'quickfix' },
        vim.bo[buf].buftype
      )
      local filetype = vim.tbl_contains({
        'gitcommit',
        'fugitive',
        'Trouble',
        'packer',
        'NvimTree',
        'DiffviewFiles',
      }, vim.bo[buf].filetype)
      return buftype or filetype
    end,
  },
}
