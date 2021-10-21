#' BioCompute Objects schema validator (v1.4.2)
#'
#' @param file Path to the BCO JSON file
#'
#' @return None
#'
#' @importFrom jsonvalidate json_validate json_validator
#'
#' @rdname validate_schema
#' @export validate_schema_v1.4.2
#'
#' @note JSON schema validators for BCO domains and complete BCO based on
#' jsonvalidate. Refer to the
#' \href{https://github.com/biocompute-objects/BCO_Specification/tree/1.4.2/ieee-2791-schema}{BioCompute Objects Schema}
#' for specific JSON schemas.
#'
#' @examples
#' bco <- tempfile(fileext = ".json")
#' generate_example("HCV1a") %>%
#'   convert_json() %>%
#'   export_json(bco)
#' bco %>% validate_schema()
validate_schema_v1.4.2 <- function(file) {
  rule_text("0: Validating BioCompute Object")

  txt <- paste(readLines(file), collapse = "")
  schema <- system.file("schemas/1.4.2/2791object.json", package = "biocompute")
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
  validate_domain("provenance_domain", "schemas/1.4.2/provenance_domain.json")

  rule_text("2: Validating Usability Domain")
  validate_domain("usability_domain", "schemas/1.4.2/usability_domain.json")

  rule_text("3: Validating Description Domain")
  validate_domain("description_domain", "schemas/1.4.2/description_domain.json")

  rule_text("4: Validating Execution Domain")
  validate_domain("execution_domain", "schemas/1.4.2/execution_domain.json")

  rule_text("5: Validating Parametric Domain")
  validate_domain("parametric_domain", "schemas/1.4.2/parametric_domain.json")

  rule_text("6: Validating I/O Domain")
  validate_domain("io_domain", "schemas/1.4.2/io_domain.json")

  rule_text("7: Validating Error Domain")
  validate_domain("error_domain", "schemas/1.4.2/error_domain.json")

  invisible(NULL)
}

#' @rdname validate_schema
#' @export validate_schema
validate_schema <- validate_schema_v1.4.2
