#' BioCompute Objects schema validator (v1.3.0)
#'
#' @param file Path to the BCO JSON file
#'
#' @return None
#'
#' @importFrom jsonvalidate json_validate json_validator
#'
#' @rdname validate_schema
#' @export validate_schema_v1.3.0
#'
#' @note JSON schema validators for BCO domains and complete BCO based on
#' jsonvalidate. Refer to the
#' \href{https://github.com/biocompute-objects/BCO_Specification/tree/main/ieee-2791-schema}{BioCompute Objects Schema}
#' for specific JSON schemas.
#'
#' @examples
#' bco <- tempfile(fileext = ".json")
#' generate_example("HCV1a") %>%
#'   convert_json() %>%
#'   export_json(bco)
#' bco %>% validate_schema()
validate_schema_v1.3.0 <- function(file) {
  rule_text("0: Validating BioCompute Object")

  txt <- paste(readLines(file), collapse = "")
  schema <- system.file("schemas/1.3.0-alpha/biocomputeobject.json", package = "biocompute")
  v <- jsonvalidate::json_validator(schema)
  print(v(txt, verbose = TRUE, greedy = TRUE))
  cat("\n")

  validate_domain <- function(domain, schema) {
    lst <- jsonlite::read_json(file)
    txt <- jsonlite::toJSON(lst[[domain]], auto_unbox = TRUE)
    schema <- system.file(schema, package = "biocompute")
    v <- jsonvalidate::json_validator(schema)
    print(v(txt, verbose = TRUE, greedy = TRUE))
    cat("\n")
  }

  validate_domain_extension <- function(domain, schema) {
    lst <- jsonlite::read_json(file)
    txt <- jsonlite::toJSON(lst[["extension_domain"]][[domain]], auto_unbox = TRUE)
    schema <- system.file(schema, package = "biocompute")
    v <- jsonvalidate::json_validator(schema)
    print(v(txt, verbose = TRUE, greedy = TRUE))
    cat("\n")
  }

  rule_text("1: Validating Provenance Domain")
  validate_domain("provenance_domain", "schemas/1.3.0-alpha/provenance_domain.json")

  rule_text("2: Validating Usability Domain")
  validate_domain("usability_domain", "schemas/1.3.0-alpha/usability_domain.json")

  rule_text("3.1: Validating Extension Domain (FHIR Extension)")
  validate_domain_extension("fhir_extension", "schemas/1.3.0-alpha/extension_domain/fhir_extension.json")

  rule_text("3.2: Validating Extension Domain (SCM Extension)")
  validate_domain_extension("scm_extension", "schemas/1.3.0-alpha/extension_domain/scm_extension.json")

  rule_text("4: Validating Description Domain")
  validate_domain("description_domain", "schemas/1.3.0-alpha/description_domain.json")

  rule_text("5: Validating Execution Domain")
  validate_domain("execution_domain", "schemas/1.3.0-alpha/execution_domain.json")

  rule_text("6: Validating Parametric Domain")
  validate_domain("parametric_domain", "schemas/1.3.0-alpha/parametric_domain.json")

  rule_text("7: Validating I/O Domain")
  validate_domain("io_domain", "schemas/1.3.0-alpha/io_domain.json")

  rule_text("8: Validating Error Domain")
  validate_domain("error_domain", "schemas/1.3.0-alpha/error_domain.json")

  invisible(NULL)
}

#' @rdname validate_schema
#' @export validate_schema
validate_schema <- validate_schema_v1.3.0
