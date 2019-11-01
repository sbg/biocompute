#' Export BioCompute Object as JSON
#'
#' @param x BioCompute Object JSON string from \code{\link{convert_json}}
#' @param file JSON file path
#'
#' @export export_json
#'
#' @examples
#' bco <- tempfile(fileext = ".json")
#' generate_example("HCV1a") %>%
#'   convert_json() %>%
#'   export_json(bco)
#' cat(paste(readLines(bco), collapse = "\n"))
export_json <- function(x, file) {
  if (!("json" %in% class(x))) stop("input class must be \"json\"")
  writeLines(x, file)
}
