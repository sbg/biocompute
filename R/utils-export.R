# check if a string follows the format of a project slug
#' @importFrom stringr str_count
is_project_slug <- function(x) {
  str_count(x, "/") == 1L & substr(x, 1, 1) != "/" & substr(x, nchar(x), nchar(x)) != "/"
}

# check if a string follows the format of an api token
is_token <- function(x) nchar(x) == 32L & grepl("[[:alnum:]]", x)
