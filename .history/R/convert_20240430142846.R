#' Convert BioCompute Object or domain to JSON string
#'
#' @param x BioCompute Object or domain
#' @param pretty Prettify the JSON string? Default is \code{TRUE}.
#' @param auto_unbox Unbox all atomic vectors of length 1? Default is \code{TRUE}.
#' @param na How to represent NA values: must be \code{"null"} or \code{"string"}.
#' Default is \code{"string"}.
#' @param ... Additional parameters for \code{\link[jsonlite]{toJSON}}.
#'
#' @return JSON string of the BioCompute Object
#'
#' @export convert_json
#'
#' @examples
#' compose_description() %>% convert_json()
#' generate_example("minimal") %>% convert_json()
convert_json <- function(x, pretty = TRUE, auto_unbox = TRUE, na = "string", ...) {
  jsonlite::toJSON(x, pretty = pretty, auto_unbox = auto_unbox, na = na, ...)
}

#' Convert BioCompute Object or domain to YAML string
#'
#' @param x BioCompute Object or domain
#' @param ... Additional parameters for \code{\link[yaml]{as.yaml}}.
#'
#' @return YAML string of the BioCompute Object
#'
#' @importFrom yaml as.yaml
#'
#' @export convert_yaml
#'
#' @examples
#' compose_description() %>%
#'   convert_yaml() %>%
#'   cat()
#' generate_example("minimal") %>%
#'   convert_yaml() %>%
#'   cat()
convert_yaml <- function(x, ...) {
  yaml::as.yaml(x, ...)
}
