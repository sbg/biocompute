#' Compose BioCompute Object - Description Domain (v1.3.0)
#'
#' @param keywords Character vector. A list of keywords to aid in
#' searchability and description of the experiment.
#' @param xref Data frame. A list of the databases and/or ontology IDs
#' that are cross-referenced in the BCO.
#' @param platform Character string. Reference to a particular deployment
#' of an existing platform where this BCO can be reproduced.
#' @param pipeline_meta Data frame. Pipeline metadata.
#' Variables include \code{step_number}, \code{name}, \code{description},
#' and \code{version}.
#' @param pipeline_prerequisite Data frame. Packages or prerequisites
#' for running the tools used. Variables include \code{step_number},
#' \code{name}, \code{uri}, and \code{access_time}.
#' @param pipeline_input Data frame. Input files for the tools.
#' Variables include \code{step_number}, \code{uri}, and \code{access_time}.
#' @param pipeline_output Data frame. Output files for the tools.
#' Variables include \code{step_number}, \code{uri}, and \code{access_time}.
#'
#' @return A list of class \code{bco.domain}
#'
#' @rdname compose_description
#' @export compose_description_v1.3.0
#'
#' @examples
#' keywords <- c("HCV1a", "Ledipasvir", "antiviral resistance", "SNP", "amino acid substitutions")
#' xref <- data.frame(
#'   "namespace" = c("pubchem.compound", "pubmed", "so", "taxonomy"),
#'   "name" = c("PubChem-compound", "PubMed", "Sequence Ontology", "Taxonomy"),
#'   "ids" = I(list(
#'     "67505836",
#'     "26508693",
#'     c("SO:000002", "SO:0000694", "SO:0000667", "SO:0000045"),
#'     "31646"
#'   )),
#'   "access_time" = c(
#'     as.POSIXct("2017-01-20T09:40:17", format = "%Y-%m-%dT%H:%M:%S", tz = "EST"),
#'     as.POSIXct("2017-01-21T09:40:17", format = "%Y-%m-%dT%H:%M:%S", tz = "EST"),
#'     as.POSIXct("2017-01-22T09:40:17", format = "%Y-%m-%dT%H:%M:%S", tz = "EST"),
#'     as.POSIXct("2017-01-23T09:40:17", format = "%Y-%m-%dT%H:%M:%S", tz = "EST")
#'   ),
#'   stringsAsFactors = FALSE
#' )
#'
#' platform <- "Seven Bridges Platform"
#'
#' pipeline_meta <- data.frame(
#'   "step_number" = c("1"),
#'   "name" = c("HIVE-hexagon"),
#'   "description" = c("Alignment of reads to a set of references"),
#'   "version" = c("1.3"),
#'   stringsAsFactors = FALSE
#' )
#'
#' pipeline_prerequisite <- data.frame(
#'   "step_number" = rep("1", 5),
#'   "name" = c(
#'     "Hepatitis C virus genotype 1",
#'     "Hepatitis C virus type 1b complete genome",
#'     "Hepatitis C virus (isolate JFH-1) genomic RNA",
#'     "Hepatitis C virus clone J8CF, complete genome",
#'     "Hepatitis C virus S52 polyprotein gene"
#'   ),
#'   "uri" = c(
#'     "https://www.ncbi.nlm.nih.gov/nuccore/22129792",
#'     "https://www.ncbi.nlm.nih.gov/nuccore/5420376",
#'     "https://www.ncbi.nlm.nih.gov/nuccore/13122261",
#'     "https://www.ncbi.nlm.nih.gov/nuccore/386646758",
#'     "https://www.ncbi.nlm.nih.gov/nuccore/295311559"
#'   ),
#'   "access_time" = c(
#'     as.POSIXct("2017-01-24T09:40:17", format = "%Y-%m-%dT%H:%M:%S", tz = "EST"),
#'     as.POSIXct("2017-01-24T09:40:17", format = "%Y-%m-%dT%H:%M:%S", tz = "EST"),
#'     as.POSIXct("2017-01-24T09:40:17", format = "%Y-%m-%dT%H:%M:%S", tz = "EST"),
#'     as.POSIXct("2017-01-24T09:40:17", format = "%Y-%m-%dT%H:%M:%S", tz = "EST"),
#'     as.POSIXct("2017-01-24T09:40:17", format = "%Y-%m-%dT%H:%M:%S", tz = "EST")
#'   ),
#'   stringsAsFactors = FALSE
#' )
#'
#' pipeline_input <- data.frame(
#'   "step_number" = rep("1", 2),
#'   "uri" = c(
#'     "https://example.com/dna.cgi?cmd=objFile&ids=514683",
#'     "https://example.com/dna.cgi?cmd=objFile&ids=514682"
#'   ),
#'   "access_time" = c(
#'     as.POSIXct("2017-01-24T09:40:17", format = "%Y-%m-%dT%H:%M:%S", tz = "EST"),
#'     as.POSIXct("2017-01-24T09:40:17", format = "%Y-%m-%dT%H:%M:%S", tz = "EST")
#'   ),
#'   stringsAsFactors = FALSE
#' )
#'
#' pipeline_output <- data.frame(
#'   "step_number" = rep("1", 2),
#'   "uri" = c(
#'     "https://example.com/data/514769/allCount-aligned.csv",
#'     "https://example.com/data/514801/SNPProfile*.csv"
#'   ),
#'   "access_time" = c(
#'     as.POSIXct("2017-01-24T09:40:17", format = "%Y-%m-%dT%H:%M:%S", tz = "EST"),
#'     as.POSIXct("2017-01-24T09:40:17", format = "%Y-%m-%dT%H:%M:%S", tz = "EST")
#'   ),
#'   stringsAsFactors = FALSE
#' )
#'
#' compose_description(
#'   keywords, xref, platform,
#'   pipeline_meta, pipeline_prerequisite, pipeline_input, pipeline_output
#' ) %>% convert_json()
compose_description_v1.3.0 <-
  function(
           keywords = NULL, xref = NULL, platform = "Seven Bridges Platform",
           pipeline_meta = NULL, pipeline_prerequisite = NULL,
           pipeline_input = NULL, pipeline_output = NULL) {
    if (is.null(keywords)) keywords <- character()

    if (is.null(xref)) {
      xref_lst <- list()
    } else {
      xref$access_time <- as.character(xref$access_time, format = "%Y-%m-%dT%H:%M:%S%z")
      xref_lst <- df2list(xref)
      for (i in 1:length(xref_lst)) {
        xref_lst[[i]] <-
          list(
            "namespace" = unlist(unname(xref_lst[[i]]["namespace"])),
            "name" = unlist(unname(xref_lst[[i]]["name"])),
            "ids" = unlist(unname(xref_lst[[i]]["ids"])),
            "access_time" = unlist(unname(xref_lst[[i]]["access_time"]))
          )
      }
    }

    if (is.null(pipeline_meta)) {
      ps_lst <- list()
    } else {
      ps_lst <- df2list(pipeline_meta)

      # fill meta
      for (i in 1:length(ps_lst)) {
        ps_lst[[i]] <- list(
          "step_number" = unlist(unname(ps_lst[[i]]["step_number"])),
          "name" = unlist(unname(ps_lst[[i]]["name"])),
          "description" = unlist(unname(ps_lst[[i]]["description"])),
          "version" = unlist(unname(ps_lst[[i]]["version"]))
        )
      }

      # fill prerequisites
      for (i in 1:length(ps_lst)) ps_lst[[i]][["prerequisite"]] <- list()
      if (!is.null(pipeline_prerequisite)) {
        step_number_all <- sapply(ps_lst, "[[", "step_number")
        for (i in 1:nrow(pipeline_prerequisite)) {
          step_idx <- which(step_number_all == pipeline_prerequisite[i, "step_number"])
          # only when we got a matched step number
          if (length(step_idx) != 0L) {
            ps_lst[[step_idx]][["prerequisite"]] <- append(
              ps_lst[[step_idx]][["prerequisite"]],
              list(list(
                "name" = pipeline_prerequisite[i, "name"],
                "uri" = list(
                  "uri" = pipeline_prerequisite[i, "uri"],
                  "access_time" = pipeline_prerequisite[i, "access_time"]
                )
              ))
            )
          }
        }
      }

      # fill inputs
      for (i in 1:length(ps_lst)) ps_lst[[i]][["input_list"]] <- list()
      if (!is.null(pipeline_input)) {
        step_number_all <- sapply(ps_lst, "[[", "step_number")
        for (i in 1:nrow(pipeline_input)) {
          step_idx <- which(step_number_all == pipeline_input[i, "step_number"])
          # only when we got a matched step number
          if (length(step_idx) != 0L) {
            ps_lst[[step_idx]][["input_list"]] <- append(
              ps_lst[[step_idx]][["input_list"]],
              list(list(
                "uri" = pipeline_input[i, "uri"],
                "access_time" = pipeline_input[i, "access_time"]
              ))
            )
          }
        }
      }

      # fill outputs
      for (i in 1:length(ps_lst)) ps_lst[[i]][["output_list"]] <- list()
      if (!is.null(pipeline_output)) {
        step_number_all <- sapply(ps_lst, "[[", "step_number")
        for (i in 1:nrow(pipeline_output)) {
          step_idx <- which(step_number_all == pipeline_output[i, "step_number"])
          # only when we got a matched step number
          if (length(step_idx) != 0L) {
            ps_lst[[step_idx]][["output_list"]] <- append(
              ps_lst[[step_idx]][["output_list"]],
              list(list(
                "uri" = pipeline_output[i, "uri"],
                "access_time" = pipeline_output[i, "access_time"]
              ))
            )
          }
        }
      }
    }

    domain <- list(
      "keywords" = keywords,
      "xref" = xref_lst,
      "platform" = platform,
      "pipeline_steps" = ps_lst
    )
    class(domain) <- c(class(domain), "bco.domain")

    domain
  }

#' @rdname compose_description
#' @export compose_description
compose_description <- compose_description_v1.3.0
