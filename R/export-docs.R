#' Export BioCompute Object as PDF
#'
#' @param x BioCompute Object JSON string from \code{\link{convert_json}}
#' @param file PDF output file path
#' @param wrap Should the long lines be wrapped?
#' @param linewidth Maximum linewidth when \code{wrap} is \code{TRUE}.
#' @param ... Additional parameters for \code{\link[rmarkdown]{render}}.
#'
#' @importFrom rmarkdown render
#'
#' @export export_pdf
#'
#' @examples
#' \dontrun{
#'
#' generate_example("HCV1a") %>%
#'   convert_json() %>%
#'   export_pdf("~/HCV1a.bco.pdf")
#' }
export_pdf <- function(x, file, wrap = FALSE, linewidth = 80, ...) {
  template <- normalizePath(system.file("templates/export.Rmd", package = "biocompute"))
  rmarkdown::render(
    input = template,
    output_format = "pdf_document",
    output_file = file,
    clean = TRUE,
    params = list(x = x, wrap = wrap, linewidth = linewidth), ...
  )
}

#' Export BioCompute Object as HTML
#'
#' @param x BioCompute Object JSON string from \code{\link{convert_json}}
#' @param file HTML output file path
#' @param wrap Should the long lines be wrapped?
#' @param linewidth Maximum linewidth when \code{wrap} is \code{TRUE}.
#' @param ... Additional parameters for \code{\link[rmarkdown]{render}}.
#'
#' @export export_html
#'
#' @examples
#' \dontrun{
#'
#' generate_example("HCV1a") %>%
#'   convert_json() %>%
#'   export_html("~/HCV1a.bco.html")
#' }
export_html <- function(x, file, wrap = FALSE, linewidth = 80, ...) {
  template <- normalizePath(system.file("templates/export.Rmd", package = "biocompute"))
  rmarkdown::render(
    input = template,
    output_format = "html_document",
    output_file = file,
    clean = TRUE,
    params = list(x = x, wrap = wrap, linewidth = linewidth), ...
  )
}

#' Export BioCompute Object as Word document
#'
#' @param x BioCompute Object JSON string from \code{\link{convert_json}}
#' @param file Word (docx) output file path
#' @param wrap Should the long lines be wrapped?
#' @param linewidth Maximum linewidth when \code{wrap} is \code{TRUE}.
#' @param ... Additional parameters for \code{\link[rmarkdown]{render}}.
#'
#' @export export_word
#'
#' @examples
#' \dontrun{
#'
#' generate_example("HCV1a") %>%
#'   convert_json() %>%
#'   export_word("~/HCV1a.bco.docx")
#' }
export_word <- function(x, file, wrap = FALSE, linewidth = 80, ...) {
  template <- normalizePath(system.file("templates/export.Rmd", package = "biocompute"))
  rmarkdown::render(
    input = template,
    output_format = "word_document",
    output_file = file,
    clean = TRUE,
    params = list(x = x, wrap = wrap, linewidth = linewidth), ...
  )
}
