#' Compose BioCompute Object - SCM Extension (v1.4.2)
#'
#' @param scm_repository Character string. Base URL of the SCM repository.
#' @param scm_type Character string. Type of SCM database. Must be one of
#' \code{"git"}, \code{"svn"}, \code{"hg"}, or \code{"other"}.
#' @param scm_commit Character string. Revision within the SCM repository.
#' Should be a repository-wide commit identifier or name of a tag,
#' but may be a name of a branch.
#' @param scm_path Character string. Path from the repository to the
#' source code referenced. Should not start with \code{/}.
#' @param scm_preview Character string. The full URI for the source code
#' referenced by the BioCompute Object.
#'
#' @return A list of class \code{bco.domain}
#'
#' @rdname compose_scm
#' @export compose_scm_v1.4.2
#'
#' @examples
#' scm_repository <- "https://github.com/example/repo"
#' scm_type <- "git"
#' scm_commit <- "c9ffea0b60fa3bcf8e138af7c99ca141a6b8fb21"
#' scm_path <- "workflow/hive-viral-mutation-detection.cwl"
#' scm_preview <- "https://github.com/example/repo/blob/master/mutation-detection.cwl"
#'
#' compose_scm(scm_repository, scm_type, scm_commit, scm_path, scm_preview) %>% convert_json()
compose_scm_v1.4.2 <-
  function(
           scm_repository = NULL, scm_type = c("git", "svn", "hg", "other"),
           scm_commit = NULL, scm_path = NULL, scm_preview = NULL) {
    scm_type <- match.arg(scm_type)

    if (!is.null(scm_path)) {
      if (substr(as.character(scm_path), 1, 1) == "/") {
        stop("scm_path should not start with `/`")
      }
    }

    domain <- list(
      "scm_repository" = scm_repository,
      "scm_type" = scm_type,
      "scm_commit" = scm_commit,
      "scm_path" = scm_path,
      "scm_preview" = scm_preview
    )
    class(domain) <- c(class(domain), "bco.domain")

    domain
  }

#' @rdname compose_scm
#' @export compose_scm
compose_scm <- compose_scm_v1.4.2
