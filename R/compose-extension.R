#' Compose BioCompute Object - Extension Domain (v1.3.0)
#'
#' @param fhir FHIR extension domain composed by \code{\link{compose_fhir}}.
#' @param scm SCM extension domain composed by \code{\link{compose_scm}}.
#'
#' @return A list of class \code{bco.domain}
#'
#' @rdname compose_extension
#' @export compose_extension_v1.3.0
#'
#' @examples
#' fhir_endpoint <- "https://fhirtest.uhn.ca/baseDstu3"
#' fhir_version <- "3"
#' fhir_resources <- data.frame(
#'   "id" = c("21376", "6288583", "25544", "92440", "4588936"),
#'   "resource" = c(
#'     "Sequence", "DiagnosticReport", "ProcedureRequest",
#'     "Observation", "FamilyMemberHistory"
#'   ),
#'   stringsAsFactors = FALSE
#' )
#'
#' fhir <- compose_fhir(fhir_endpoint, fhir_version, fhir_resources)
#'
#' scm_repository <- "https://github.com/example/repo"
#' scm_type <- "git"
#' scm_commit <- "c9ffea0b60fa3bcf8e138af7c99ca141a6b8fb21"
#' scm_path <- "workflow/hive-viral-mutation-detection.cwl"
#' scm_preview <- "https://github.com/example/repo/blob/master/mutation-detection.cwl"
#'
#' scm <- compose_scm(scm_repository, scm_type, scm_commit, scm_path, scm_preview)
#'
#' compose_extension(fhir, scm) %>% convert_json()
compose_extension_v1.3.0 <- function(fhir = NULL, scm = NULL) {
  if (is.null(fhir)) fhir_lst <- list() else fhir_lst <- fhir
  if (is.null(scm)) scm_lst <- list() else scm_lst <- scm

  domain <- list(
    "fhir_extension" = fhir_lst,
    "scm_extension" = scm_lst
  )
  class(domain) <- c(class(domain), "bco.domain")

  domain
}

#' @rdname compose_extension
#' @export compose_extension
compose_extension <- compose_extension_v1.3.0
