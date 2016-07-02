# devtools::install_github('jalvesaq/colorout')
library(colorout)
setOutputColors256(
  normal = 202, 
  number = 214, 
  negnum = 209, 
  date = 189, 
  string = 172, 
  const = 179, 
  verbose = FALSE
)

install.packages("formatR", repos = "http://cran.rstudio.com")
library(formatR)
library(shiny)

formatR::tidy_app()
