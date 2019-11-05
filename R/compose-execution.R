#' Compose BioCompute Object - Execution Domain (v1.3.0)
#'
#' @param script Character string. Points to internal or external
#' references to an object that was used to perform computations
#' for this BCO instance.
#' @param script_driver Character string. Indicate what kind of
#' executable can be launched in order to perform a sequence of
#' commands described in the script in order to run the pipeline.
#' @param software_prerequisites Data frame. The minimal necessary
#' prerequisites, library, and tool versions needed to successfully
#' run the script to produce BCO. Variables include
#' \code{name}, \code{version}, \code{uri}, \code{access_time},
#' and \code{sha1_chksum}.
#' Each row is one item in the output subdomain.
#' @param external_data_endpoints Data frame. The minimal necessary
#' domain-specific external data source access to successfully
#' run the script to produce the BCO. Variables include
#' \code{mediatype}, \code{name}, and \code{url}.
#' Each row is one item in the output subdomain.
#' @param environment_variables Data frame. Key-value pairs
#' useful to configure the execution environment on the
#' target platform. Variables include \code{key} and \code{value}.
#'
#' @return A list of class \code{bco.domain}
#'
#' @importFrom stats setNames
#'
#' @rdname compose_execution
#' @export compose_execution_v1.3.0
#'
#' @examples
#' script <- "https://example.com/workflows/antiviral_resistance_detection_hive.py"
#' script_driver <- "shell"
#' software_prerequisites <- data.frame(
#'   "name" = c("HIVE-hexagon", "HIVE-heptagon"),
#'   "version" = c("babajanian.1", "albinoni.2"),
#'   "uri" = c(
#'     "https://example.com/dna.cgi?cmd=dna-hexagon&cmdMode=-",
#'     "https://example.com/dna.cgi?cmd=dna-heptagon&cmdMode=-"
#'   ),
#'   "access_time" = c(
#'     as.POSIXct("2017-01-24T09:40:17", format = "%Y-%m-%dT%H:%M:%S", tz = "EST"),
#'     as.POSIXct("2017-01-24T09:40:17", format = "%Y-%m-%dT%H:%M:%S", tz = "EST")
#'   ),
#'   "sha1_chksum" = c("d60f506cddac09e9e816531e7905ca1ca6641e3c", NA),
#'   stringsAsFactors = FALSE
#' )
#' external_data_endpoints <- data.frame(
#'   "name" = c("generic name", "access to ftp server", "access to e-utils web service"),
#'   "url" = c(
#'     "protocol://domain:port/application/path",
#'     "ftp://data.example.com:21/",
#'     "https://eutils.ncbi.nlm.nih.gov/entrez/eutils"
#'   ),
#'   stringsAsFactors = FALSE
#' )
#' environment_variables <- data.frame(
#'   "key" = c("HOSTTYPE", "EDITOR"),
#'   "value" = c("x86_64-linux", "vim")
#' )
#'
#' compose_execution(
#'   script, script_driver, software_prerequisites, external_data_endpoints, environment_variables
#' ) %>% convert_json()
compose_execution_v1.3.0 <-
  function(
           script = NULL, script_driver = NULL, software_prerequisites = NULL,
           external_data_endpoints = NULL, environment_variables = NULL) {
    if (is.null(script)) script <- list()
    if (is.null(script_driver)) script_driver <- list()

    if (is.null(software_prerequisites)) {
      sp_lst <- list()
    } else {
      sp <- software_prerequisites
      sp_lst <- df2list(sp)
      for (i in 1:length(sp_lst)) {
        sp_lst[[i]] <-
          list(
            "name" = unlist(unname(sp_lst[[i]]["name"])),
            "version" = unlist(unname(sp_lst[[i]]["version"])),
            "uri" = sp_lst[[i]][c("uri", "access_time", "sha1_chksum")]
          )
      }
    }

    if (is.null(external_data_endpoints)) {
      ede_lst <- list()
    } else {
      ede <- external_data_endpoints
      ede_lst <- df2list(ede)
    }

    if (is.null(environment_variables)) {
      ev_lst <- list()
    } else {
      ev_lst <- as.list(setNames(
        as.character(environment_variables$value),
        as.character(environment_variables$key)
      ))
    }

    domain <- list(
      "script" = script,
      "script_driver" = script_driver,
      "software_prerequisites" = sp_lst,
      "external_data_endpoints" = ede_lst,
      "environment_variables" = ev_lst
    )
    class(domain) <- c(class(domain), "bco.domain")

    domain
  }

#' @rdname compose_execution
#' @export compose_execution
compose_execution <- compose_execution_v1.3.0
