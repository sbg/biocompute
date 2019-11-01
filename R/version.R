#' Supported and available BCO specification versions
#'
#' @export versions
#'
#' @examples
#' versions()
versions <- function() {
  current <- "1.3.0"
  available <- c("1.3.0")
  list(
    "current" = current,
    "available" = available
  )
}
