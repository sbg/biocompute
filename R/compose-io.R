#' Compose BioCompute Object - Input and Output Domain (v1.4.2)
#'
#' This domain contains the list of global input and output files
#' created by the computational workflow, excluding the intermediate files.
#'
#' @param input Data frame. Variables include
#' \code{filename}, \code{uri}, and \code{access_time}.
#' Each row is one item in the input subdomain.
#' @param output Data frame. Variables include
#' \code{mediatype}, \code{uri}, and \code{access_time}.
#' Each row is one item in the output subdomain.
#'
#' @return A list of class \code{bco.domain}
#'
#' @rdname compose_io
#' @export compose_io_v1.4.2
#'
#' @examples
#' input_subdomain <- data.frame(
#'   "filename" = c(
#'     "Hepatitis C virus genotype 1",
#'     "Hepatitis C virus type 1b complete genome"
#'   ),
#'   "uri" = c(
#'     "https://www.ncbi.nlm.nih.gov/nuccore/22129792",
#'     "https://www.ncbi.nlm.nih.gov/nuccore/5420376"
#'   ),
#'   "access_time" = c(
#'     as.POSIXct("2017-01-24T09:40:17", format = "%Y-%m-%dT%H:%M:%S", tz = "EST"),
#'     as.POSIXct("2017-01-24T09:40:17", format = "%Y-%m-%dT%H:%M:%S", tz = "EST")
#'   ),
#'   stringsAsFactors = FALSE
#' )
#'
#' output_subdomain <- data.frame(
#'   "mediatype" = c("text/csv", "text/csv"),
#'   "uri" = c(
#'     "https://example.com/data/514769/dnaAccessionBased.csv",
#'     "https://example.com/data/514801/SNPProfile*.csv"
#'   ),
#'   "access_time" = c(
#'     as.POSIXct("2017-01-24T09:40:17", format = "%Y-%m-%dT%H:%M:%S", tz = "EST"),
#'     as.POSIXct("2017-01-24T09:40:17", format = "%Y-%m-%dT%H:%M:%S", tz = "EST")
#'   ),
#'   stringsAsFactors = FALSE
#' )
#'
#' compose_io(input_subdomain, output_subdomain) %>% convert_json()
compose_io_v1.4.2 <- function(input = NULL, output = NULL) {
  if (!is.null(input)) {
    input$access_time <- as.character(input$access_time, format = "%Y-%m-%dT%H:%M:%S%z")
    input_lst <- df2list(input)
    for (i in 1:length(input_lst)) {
      input_lst[[i]] <- list("uri" = input_lst[[i]])
    }
  } else {
    input_lst <- list()
  }

  if (!is.null(output)) {
    output$access_time <- as.character(output$access_time, format = "%Y-%m-%dT%H:%M:%S%z")
    output_lst <- df2list(output)
    for (i in 1:length(output_lst)) {
      output_lst[[i]] <-
        list(
          "mediatype" = unlist(unname(output_lst[[i]]["mediatype"])),
          "uri" = output_lst[[i]][c("uri", "access_time")]
        )
    }
  } else {
    output_lst <- list()
  }

  domain <- list("input_subdomain" = input_lst, "output_subdomain" = output_lst)
  class(domain) <- c(class(domain), "bco.domain")

  domain
}

#' @rdname compose_io
#' @export compose_io
compose_io <- compose_io_v1.4.2
