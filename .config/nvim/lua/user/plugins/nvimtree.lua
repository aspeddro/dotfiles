require('nvim-tree').setup {
  renderer = {
    special_files = {},
  },
  git = {
    enable = false,
  },
  trash = {
    cmd = 'rip',
  },
  filters = {
    custom = { '.git$', '.cmi$', '.cmj$', '.cmt$' },
  },
  view = {
    hide_root_folder = true,
    width = 35,
    -- mappings = {
    --   list = {
    --     {
    --       -- TODO: handle buffer delete when file is open
    --       key = 'd',
    --       action = 'Delete file',
    --       action_cb = function(node)
    --         -- absolute_path string
    --         -- hidden: bool
    --         -- type: "file"
    --         -- local buffers = vim.fn.getbufinfo { buflisted = 1 }
    --       end,
    --     },
    --   },
    -- },
  },
}

vim.keymap.set(
  'n',
  '<leader>n',
  require('nvim-tree').toggle,
  { desc = 'Toggle NvimTree' }
)
