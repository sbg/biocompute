#' Parse Biocompute Object From JSON File to R Object
#'
#' @param x BioCompute Object .json file
#' @param ... Additional parameters for \code{\link[jsonlite]{fromJSON}}.
#'
#' @return A list of class \code{bco}
#'
#' @export read_bco
#'
#' @examples
#' bco <- tempfile(fileext = ".json")
#' bco <- generate_example("HCV1a") %>%
#'   convert_json() %>%
#'   export_json(bco)
#' bco %>% read_bco()
read_bco <- function(x, ...) {
  bco <- jsonlite::fromJSON(x, ...)

  class(bco) <- c(class(bco), "bco")
  bco
}
