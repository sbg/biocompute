# utility function derived from IRanges

#' @importFrom methods is

dots2list <- function(...) {
  list_data <- list(...)
  if (length(list_data) == 1) {
    arg1 <- list_data[[1]]
    if (is.list(arg1) || is(arg1, "List")) {
      list_data <- arg1
    }
    # else if (type == "integer" && class(arg1) == "character")
    # list_data <- strsplitAsListOfIntegerVectors(arg1) # weird special case
  }
  list_data
}
