require('gitsigns').setup {
  current_line_blame = true,
  current_line_blame_opts = {
    delay = 2000,
    virt_text_priority = 500,
  },
  preview_config = {
    border = 'single',
  },
}
