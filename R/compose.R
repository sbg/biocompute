#' Compose BioCompute Object (v1.4.2)
#'
#' @param tlf Top level fields
#' @param provenance Provenance domain
#' @param usability Usability domain
#' @param extension Extension domain
#' @param description Description domain
#' @param execution Execution domain
#' @param parametric Parametric domain
#' @param io I/O domain
#' @param error Error domain
#'
#' @return A list of class \code{bco}
#'
#' @rdname compose
#' @export compose_v1.4.2
#'
#' @examples
#' tlf <- compose_tlf(
#'   compose_provenance(), compose_usability(), compose_extension(),
#'   compose_description(), compose_execution(), compose_parametric(),
#'   compose_io(), compose_error()
#' )
#' biocompute::compose(
#'   tlf,
#'   compose_provenance(), compose_usability(), compose_extension(),
#'   compose_description(), compose_execution(), compose_parametric(),
#'   compose_io(), compose_error()
#' ) %>% convert_json()
compose_v1.4.2 <-
  function(
           tlf, provenance, usability, extension,
           description, execution, parametric, io, error) {
    bco <- list(
      "spec_version" = tlf["spec_version"],
      "object_id" = tlf["object_id"],
      "etag" = tlf["etag"],
      "provenance_domain" = provenance,
      "usability_domain" = usability,
      "extension_domain" = extension,
      "description_domain" = description,
      "execution_domain" = execution,
      "parametric_domain" = parametric,
      "io_domain" = io,
      "error_domain" = error
    )

    class(bco) <- c(class(bco), "bco")
    bco
  }

#' @rdname compose
#' @export compose
compose <- compose_v1.4.2
