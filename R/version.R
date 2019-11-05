#' BioCompute Object specification versions
#'
#' @return List of current and all available BioCompute Object
#' specification versions supported by the package.
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
