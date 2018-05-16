library(methods)
set.seed(2018)
options(digits = 3)

Pkgs <- c(
  "reticulate",
  "showtext", "sysfonts", "showtextdb",
  "fontcm",
  "tikzDevice", "filehash", "png",
  "extrafontdb", "Rttf2pt1", "extrafont"
)
if (length(setdiff(Pkgs, .packages(TRUE))) > 0) {
  install.packages(setdiff(Pkgs, .packages(TRUE)))
}

if (!all(c("source-han-sans-cn", "source-han-serif-cn") %in% showtextdb::font_installed())) {
  showtextdb::font_install(showtextdb::source_han_serif("CN"))
  showtextdb::font_install(showtextdb::source_han_sans("CN"))
}
extrafont::font_install("fontcm")
extrafont::loadfonts()
extrafont::fonts() # registered with pdfFonts()
sysfonts::font_families() # List available font families

knitr::opts_chunk$set(
  comment = "#>",
  collapse = TRUE,
  echo = TRUE,
  cache = TRUE,
  citation.bibtex.max=999,
  out.width = "70%",
  fig.align = "center",
  fig.width = 6,
  # fig.showtext = TRUE, # too danger
  fig.asp = 0.618, # 1 / phi
  # fig.show = "hold", # not for python matplotlib
  fig.ext = if (knitr::is_html_output()) "svg" else if (knitr::is_latex_output()) "pdf" else "png",
  dev = if (knitr::is_html_output()) "svg" else if (knitr::is_latex_output()) "pdf" else "png",
  engine.path = list(
    # octave = "/usr/bin/octave-cli",
    python = "/usr/bin/python"
  )
)
ext <- if (knitr::is_html_output()) ".svg" else if (knitr::is_latex_output()) ".pdf" else ".png"

knitr::knit_hooks$set(optipng = knitr::hook_optipng, pdfcrop = knitr::hook_pdfcrop)

# https://github.com/yihui/knitr-examples/blob/master/085-pdfcrop.Rnw
# knitr::knit_hooks$set(crop = hook_pdfcrop)
options(
  repos = "https://mirrors.tuna.tsinghua.edu.cn/CRAN/",
  tikzDefaultEngine = "xetex",
  tikzXelatexPackages = c(
    getOption("tikzXelatexPackages"),
    "\\usepackage[colorlinks, breaklinks]{hyperref}",
    "\\usepackage{color}",
    "\\usepackage{tikz}",
    "\\usepackage[active,tightpage,xetex]{preview}",
    "\\PreviewEnvironment{pgfpicture}",
    "\\usepackage{amsmath}",
    "\\usepackage{amsfonts}",
    "\\usepackage{mathrsfs}"
  )
)
# https://github.com/yihui/knitr-examples/blob/master/047-tikz-png.Rnw
knitr::knit_hooks$set(tikz2png = function(before, options, envir) {
  # use this hook only for dev='tikz' and externalized tikz graphics
  if (before || options$dev != "tikz" || !options$external || options$fig.num == 0) return()
  figs <- knitr:::all_figs(options, ext = "pdf") # all figure names
  # note the tikz2png option is the extra parameters passed to 'convert'
  for (fig in figs) {
    system(sprintf("convert %s %s %s", options$tikz2png, fig, sub("\\.pdf$", ".png", fig)))
  }
})
