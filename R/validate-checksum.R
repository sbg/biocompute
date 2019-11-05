#' BioCompute Objects checksum validator (v1.3.0)
#'
#' @param file Path to the BCO JSON file
#'
#' @return Logical. \code{TRUE} if the checksum matched, \code{FALSE} if not.
#'
#' @importFrom digest digest
#'
#' @rdname validate_checksum
#' @export validate_checksum_v1.3.0
#'
#' @note An SHA-256 checksum is
#' \href{https://github.com/biocompute-objects/BCO_Specification/blob/master/top-level.md#203-checksum-checksum}{calculated and stored}
#' in the top level fields when a BioCompute Object is created. In reality,
#' due to the delicate differences in how the data in JSON is represented,
#' parsed, and handled in different languages, there could be false positives
#' in the validation results.
#'
#' @examples
#' bco <- tempfile(fileext = ".json")
#' generate_example("HCV1a") %>%
#'   convert_json() %>%
#'   export_json(bco)
#' bco %>% validate_checksum()
validate_checksum_v1.3.0 <- function(file) {
  rule_text("Loading BioCompute Object")
  lst <- jsonlite::read_json(file, simplifyVector = TRUE)
  lst$bco_spec_version <- NULL
  lst$bco_id <- NULL
  checksum_old <- lst$checksum
  lst$checksum <- NULL

  rule_text("Validating Checksum")
  json <- convert_json(lst)
  checksum_new <- digest::digest(json, algo = "sha256")

  cat_text("Documented checksum: ", checksum_old)
  cat_text("Calculated checksum: ", checksum_new)

  matched <- checksum_old == checksum_new

  if (matched) {
    cat_text("Documented and calculated checksum matched.")
  } else {
    cat_text(
      "Documented and calculated checksum did NOT match.",
      "Due to the minor differences in JSON serialization,",
      "this could be a false positive. Please double check."
    )
  }

  invisible(matched)
}

#' @rdname validate_checksum
#' @export validate_checksum
validate_checksum <- validate_checksum_v1.3.0
