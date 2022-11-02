-- Filetype options
vim.filetype.add {
  filename = {
    ['.Rprofile'] = 'r',
    ['renv.lock'] = 'json',
    ['.Rhistory'] = 'r',
  },
  extension = {
    pandoc = 'pandoc',
    tex = 'tex',
    eslintrc = 'json',
    scm = 'scheme',
    prettierrc = 'json',
    conf = 'conf',
    mdx = 'markdown',
    re = 'reason',
    rei = 'reason',
  },
}
