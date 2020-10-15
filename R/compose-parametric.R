#' Compose BioCompute Object - Parametric Domain (v1.3.0)
#'
#' Non-default parameters customizing the computational flow
#' which can affect the output of the calculations
#' (\href{https://github.com/biocompute-objects/BCO_Specification/blob/main/docs/parametric-domain.md}{domain definition}).
#'
#' @param df Data frame. Variables include \code{param} (parameter names),
#' \code{value} (value of the parameters), and \code{step}
#' (step number for each parameter).
#'
#' @return A list of class \code{bco.domain}
#'
#' @importFrom jsonlite toJSON
#'
#' @rdname compose_parametric
#' @export compose_parametric_v1.3.0
#'
#' @examples
#' df_parametric <- data.frame(
#'   "param" = c(
#'     "seed", "minimum_match_len",
#'     "divergence_threshold_percent",
#'     "minimum_coverage", "freq_cutoff"
#'   ),
#'   "value" = c("14", "66", "0.30", "15", "0.10"),
#'   "step" = c(1, 1, 1, 2, 2)
#' )
#'
#' compose_parametric(df_parametric) %>% convert_json()
compose_parametric_v1.3.0 <- function(df = NULL) {
  if (!is.null(df)) {
    # mix types in values under the same key is probably bad practice
    # so we consciously choose to be more strict and make everything character
    domain <- data.frame(
      "param" = as.character(df$param),
      "value" = as.character(df$value),
      "step" = as.character(df$step),
      stringsAsFactors = FALSE
    )
  } else {
    domain <- list()
  }
  class(domain) <- c(class(domain), "bco.domain")

  domain
}

#' @rdname compose_parametric
#' @export compose_parametric
compose_parametric <- compose_parametric_v1.3.0
