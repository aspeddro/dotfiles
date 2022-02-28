# wayland
# options(bitmapType='cairo')
# options(device="CairoWin")
# options(device = "X11")

options(
  tinytex.latexmk.emulation = FALSE,
  repos = c(CRAN = "https://cloud.r-project.org"),
  # LSP
  languageserver.lint_cache = FALSE,
  languageserver.max_completions = 50,
  languageserver.rich_documentation = FALSE,
  languageserver.formatting_style = function(options) {
    styler::tidyverse_style(scope = "indention", indent_by = 2)
  }
)
