#' Compose BioCompute Object - Usability Domain (v1.3.0)
#'
#' The usability domain
#' (\href{https://github.com/biocompute-objects/BCO_Specification/blob/master/usability-domain.md}{domain definition}).
#'
#' @param text A character vector of free text values that could
#' improves search-ability, provide specific scientific use cases,
#' and a description of the function of the object.
#'
#' @return A list of class \code{bco.domain}
#'
#' @rdname compose_usability
#' @export compose_usability_v1.3.0
#'
#' @examples
#' text <- c(
#'   paste(
#'     "Identify baseline single nucleotide polymorphisms (SNPs)[SO:0000694]",
#'     "(insertions)[SO:0000667], and (deletions)[SO:0000045] that correlate",
#'     "with reduced (ledipasvir)[pubchem.compound:67505836] antiviral drug",
#'     "efficacy in (Hepatitis C virus subtype 1)[taxonomy:31646]"
#'   ),
#'   paste(
#'     "Identify treatment emergent amino acid (substitutions)[SO:1000002]",
#'     "that correlate with antiviral drug treatment failure"
#'   ),
#'   paste(
#'     "Determine whether the treatment emergent amino acid",
#'     "(substitutions)[SO:1000002] identified correlate with treatment",
#'     "failure involving other drugs against the same virus"
#'   )
#' )
#'
#' text %>%
#'   compose_usability() %>%
#'   convert_json()
compose_usability_v1.3.0 <- function(text = NULL) {
  if (is.null(text)) {
    text_vec <- character()
  } else {
    if (!is.vector(text) | is.list(text)) stop("input must be a vector")
    text_vec <- as.character(text)
  }

  domain <- text_vec
  class(domain) <- c(class(domain), "bco.domain")

  domain
}

#' @rdname compose_usability
#' @export compose_usability
compose_usability <- compose_usability_v1.3.0
