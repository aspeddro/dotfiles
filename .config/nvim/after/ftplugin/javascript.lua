local node = require('repl.session'):new {
  bin = 'node',
  args = {},
  cwd = nil,
  insert_on_enter = true,
  layout = 'vertical',
  relativenumber = false,
  hide_number = true,
  switch_session_on_start = false,
  save_image_on_exit = false,
  escape_key = '<Esc>',
}

require('mapx').nnoremap('<leader>rs', function()
  node:start()
end, { buffer = true })

require('mapx').nnoremap('<leader>rr', function()
  P(node)
end, { buffer = true })
