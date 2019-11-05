#' Compose BioCompute Object - Error Domain (v1.3.0)
#'
#' The error domain can be used to determine what range of input
#' returns outputs that are within the tolerance level defined
#' in this subdomain and therefore can be used to optimize algorithm
#' (\href{https://github.com/biocompute-objects/BCO_Specification/blob/master/error-domain.md}{domain definition}).
#'
#' @param empirical Data frame. Variables include \code{key} and \code{value}.
#' Each row is one item in the empirical error subdomain.
#' @param algorithmic Data frame. Variables include \code{key} and \code{value}.
#' Each row is one item in the algorithmic subdomain.
#'
#' @return A list of class \code{bco.domain}
#'
#' @rdname compose_error
#' @export compose_error_v1.3.0
#'
#' @examples
#' empirical <- data.frame(
#'   "key" = c("false_negative_alignment_hits", "false_discovery"),
#'   "value" = c("<0.0010", "<0.05"),
#'   stringsAsFactors = FALSE
#' )
#'
#' algorithmic <- data.frame(
#'   "key" = c("false_positive_mutation_calls", "false_discovery"),
#'   "value" = c("<0.00005", "0.005"),
#'   stringsAsFactors = FALSE
#' )
#'
#' compose_error(empirical, algorithmic) %>% convert_json()
compose_error_v1.3.0 <- function(empirical = NULL, algorithmic = NULL) {
  empirical_lst <- if (!is.null(empirical)) as.list(setNames(as.character(empirical$value), as.character(empirical$key))) else list()
  algorithmic_lst <- if (!is.null(algorithmic)) as.list(setNames(as.character(algorithmic$value), as.character(algorithmic$key))) else list()

  domain <- list("empirical_error" = empirical_lst, "algorithmic_error" = algorithmic_lst)
  class(domain) <- c(class(domain), "bco.domain")

  domain
}

#' @rdname compose_error
#' @export compose_error
compose_error <- compose_error_v1.3.0
