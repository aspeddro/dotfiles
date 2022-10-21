require('pandoc').setup {
  default = {
    args = {
      { '--standalone' },
      { '--number-sections' },
      -- { '--biblatex' },
      -- { "--natbib" },
      { '--pdf-engine', 'tectonic' },
      { '--filter', 'pandoc-crossref' },
    },
  },
}
