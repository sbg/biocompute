#' Parse Biocompute Object From JSON File to R Object
#'
#' @param x BioCompute Object .json file
#' @param ... Additional parameters for \code{\link[jsonlite]{fromJSON}}.
#'
#' @return A list of class \code{bco}
#'
#' @export parse_bco
#'
#' @examples
#' bco <- tempfile(fileext = ".json")
#' generate_example("HCV1a") %>%
#'   convert_json() %>%
#'   export_json(bco)
#' bco %>% parse_bco()
parse_bco <- function(x, ...) {
  bco <- jsonlite::fromJSON(x, ...)

  class(bco) <- c(class(bco), "bco")
  bco
}
