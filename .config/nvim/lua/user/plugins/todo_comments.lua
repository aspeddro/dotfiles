local color = require('blueberry.config').colors

require('todo-comments').setup {
  -- sings = false
  signs = false, -- show icons in the signs column
  highlight = {
    keyword = 'fg',
  },
  merge_keywords = false,
  keywords = {
    FIX = {
      color = color.yellow,
      alt = { 'FIXME', 'BUG', 'FIXIT', 'ISSUE' },
    },
    TODO = { color = color.yellow },
    HACK = { color = color.yellow },
    WARN = { color = color.yellow, alt = { 'WARNING', 'XXX' } },
    PERF = {
      color = color.yellow,
      alt = { 'OPTIM', 'PERFORMANCE', 'OPTIMIZE' },
    },
    NOTE = { color = color.yellow, alt = { 'INFO' } },
  },
}
