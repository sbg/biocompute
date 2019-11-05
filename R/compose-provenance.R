#' Compose BioCompute Object - Provenance Domain (v1.3.0)
#'
#' @param name Character string. Name for the BCO.
#' @param version Character string. Version of this BCO instance object.
#' Should follow the Semantic Versioning format (MAJOR.MINOR.PATCH).
#' @param review Data frame. Reviewer identifiers and descriptions
#' of the status of an object in the review process.
#' @param derived_from Character string. Inheritance/derivation description.
#' @param obsolete_after Date-time object. Expiration date of the object (optional).
#' @param embargo Vector of date-time objects \code{start_time} and \code{end_time}.
#' If the object has a period of time that it is not public,
#' that range can be specified with this.
#' @param created Date-time object. Initial creation time of the object.
#' @param modified Date-time object. The most recent modification time of the object.
#' @param contributors Data frame. Contributor identifiers and descriptions
#' of their contribution types.
#' @param license Character string. Licence URL or other licence information (text).
#'
#' @return A list of class \code{bco.domain}
#'
#' @rdname compose_provenance
#' @export compose_provenance_v1.3.0
#'
#' @examples
#' name <- "HCV1a ledipasvir resistance SNP detection"
#' version <- "1.0.0"
#' review <- data.frame(
#'   "status" = c("approved", "approved"),
#'   "reviewer_comment" = c(
#'     "Approved by [company name] staff. Waiting for approval from FDA Reviewer",
#'     "The revised BCO looks fine"
#'   ),
#'   "date" = c(
#'     as.POSIXct("2017-11-12T12:30:48", format = "%Y-%m-%dT%H:%M:%S", tz = "EST"),
#'     as.POSIXct("2017-12-12T12:30:48", format = "%Y-%m-%dT%H:%M:%S", tz = "America/Los_Angeles")
#'   ),
#'   "reviewer_name" = c("Jane Doe", "John Doe"),
#'   "reviewer_affiliation" = c("Seven Bridges Genomics", "U.S. Food and Drug Administration"),
#'   "reviewer_email" = c("example@sevenbridges.com", "example@fda.gov"),
#'   "reviewer_contribution" = c("curatedBy", "curatedBy"),
#'   "reviewer_orcid" = c("https://orcid.org/0000-0000-0000-0000", NA),
#'   stringsAsFactors = FALSE
#' )
#'
#' derived_from <- "https://github.com/biocompute-objects/BCO_Specification/blob/1.2.1-beta/HCV1a.json"
#' obsolete_after <- as.POSIXct("2018-11-12T12:30:48", format = "%Y-%m-%dT%H:%M:%S", tz = "EST")
#'
#' embargo <- c(
#'   "start_time" = as.POSIXct("2017-10-12T12:30:48", format = "%Y-%m-%dT%H:%M:%S", tz = "EST"),
#'   "end_time" = as.POSIXct("2017-11-12T12:30:48", format = "%Y-%m-%dT%H:%M:%S", tz = "EST")
#' )
#'
#' created <- as.POSIXct("2017-01-20T09:40:17", format = "%Y-%m-%dT%H:%M:%S", tz = "EST")
#'
#' modified <- as.POSIXct("2019-05-10T09:40:17", format = "%Y-%m-%dT%H:%M:%S", tz = "EST")
#'
#' contributors <- data.frame(
#'   "name" = c("Jane Doe", "John Doe"),
#'   "affiliation" = c("Seven Bridges Genomics", "U.S. Food and Drug Administration"),
#'   "email" = c("example@sevenbridges.com", "example@fda.gov"),
#'   "contribution" = I(list(c("createdBy", "curatedBy"), c("authoredBy"))),
#'   "orcid" = c("https://orcid.org/0000-0000-0000-0000", NA),
#'   stringsAsFactors = FALSE
#' )
#'
#' license <- "https://creativecommons.org/licenses/by/4.0/"
#'
#' compose_provenance(
#'   name, version, review, derived_from, obsolete_after,
#'   embargo, created, modified, contributors, license
#' ) %>% convert_json()
compose_provenance_v1.3.0 <-
  function(
           name = NULL, version = NULL, review = NULL, derived_from = NULL,
           obsolete_after = NULL, embargo = NULL, created = NULL,
           modified = NULL, contributors = NULL, license = NULL) {
    name <- if (!is.null(name)) as.character(name) else character()
    version <- if (!is.null(version)) as.character(version) else character()

    if (is.null(review)) {
      rev_lst <- list()
    } else {
      rev_lst <- df2list(review)
      for (i in 1:length(rev_lst)) {
        rev_lst[[i]] <-
          list(
            "status" = unlist(unname(rev_lst[[i]]["status"])),
            "reviewer_comment" = unlist(unname(rev_lst[[i]]["reviewer_comment"])),
            "date" = unlist(unname(rev_lst[[i]]["date"])),
            "reviewer" = rev_lst[[i]][c("reviewer_name", "reviewer_affiliation", "reviewer_email", "reviewer_contribution", "reviewer_orcid")]
          )
      }
    }

    derived_from <- if (!is.null(derived_from)) as.character(derived_from) else character()
    obsolete_after <- if (!is.null(obsolete_after)) as.character(obsolete_after, format = "%Y-%m-%dT%H:%M:%S%z") else character()
    embargo <- if (!is.null(embargo)) as.character(embargo, format = "%Y-%m-%dT%H:%M:%S%z") else character()
    created <- if (!is.null(created)) as.character(created, format = "%Y-%m-%dT%H:%M:%S%z") else character()
    modified <- if (!is.null(modified)) as.character(modified, format = "%Y-%m-%dT%H:%M:%S%z") else character()

    if (is.null(contributors)) {
      ctb_lst <- list()
    } else {
      ctb <- contributors
      ctb_lst <- df2list(ctb)
      for (i in 1:length(ctb_lst)) {
        ctb_lst[[i]] <-
          list(
            "name" = unlist(unname(ctb_lst[[i]]["name"])),
            "affiliation" = unlist(unname(ctb_lst[[i]]["affiliation"])),
            "email" = unlist(unname(ctb_lst[[i]]["email"])),
            "contribution" = unlist(unname(ctb_lst[[i]]["contribution"])),
            "orcid" = unlist(unname(ctb_lst[[i]]["orcid"]))
          )
      }
    }

    license <- if (!is.null(license)) as.character(license) else character()

    domain <- list(
      "name" = name,
      "version" = version,
      "review" = rev_lst,
      "derived_from" = derived_from,
      "obsolete_after" = obsolete_after,
      "embargo" = embargo,
      "created" = created,
      "modified" = modified,
      "contributors" = ctb_lst,
      "license" = license
    )
    class(domain) <- c(class(domain), "bco.domain")

    domain
  }

#' @rdname compose_provenance
#' @export compose_provenance
compose_provenance <- compose_provenance_v1.3.0
