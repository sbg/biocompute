#' Compose BioCompute Object - FHIR Extension (v1.4.2)
#'
#' @param endpoint Character string. The URL of the endpoint of the
#' FHIR server containing the resource.
#' @param version Character string. The FHIR version used.
#' @param resources Data frame with two variables: \code{id} and \code{resource}.
#' Each row is one item of resources to fetch from the endpoint.
#'
#' @return A list of class \code{bco.domain}
#'
#' @rdname compose_fhir
#' @export compose_fhir_v1.4.2
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
#' compose_fhir(fhir_endpoint, fhir_version, fhir_resources) %>% convert_json()
compose_fhir_v1.4.2 <- function(endpoint = NULL, version = NULL, resources = NULL) {
  if (!is.null(resources)) {
    names(resources)[which(names(resources) == "id")] <- "fhir_id"
    names(resources)[which(names(resources) == "resource")] <- "fhir_resource"
    resources_lst <- df2list(resources)
  } else {
    resources_lst <- NULL
  }

  domain <- list("fhir_endpoint" = endpoint, "fhir_version" = version, "fhir_resources" = resources_lst)
  class(domain) <- c(class(domain), "bco.domain")

  domain
}

#' @rdname compose_fhir
#' @export compose_fhir
compose_fhir <- compose_fhir_v1.4.2
