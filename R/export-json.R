#' Export BioCompute Object as JSON
#'
#' @param x BioCompute Object JSON string from \code{\link{convert_json}}
#' @param file JSON file path
#'
#' @return Path to the output file
#'
#' @export export_json
#'
#' @examples
#' file_json <- tempfile(fileext = ".json")
#' generate_example("HCV1a") %>%
#'   convert_json() %>%
#'   export_json(file_json)
#' cat(paste(readLines(file_json), collapse = "\n"))
export_json <- function(x, file) {
  if (!("json" %in% class(x))) stop("input class must be \"json\"")
  writeLines(x, file)
  invisible(file)
}
