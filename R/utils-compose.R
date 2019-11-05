#' Generate ID for the BioCompute Object
#'
#' @param platform Platform. Default is \code{"sevenbridges"}.
#'
#' @return BioCompute Object ID
#'
#' @export generate_id
#'
#' @examples
#' generate_id()
generate_id <- function(platform = c("sevenbridges")) {
  platform <- match.arg(platform)
  if (platform == "sevenbridges") {
    paste0("https://biocompute.sbgenomics.com/bco/", uuid::UUIDgenerate())
  } else {
    NULL
  }
}

#' Is this a domain object?
#'
#' @param x any object
#'
#' @return Logical. \code{TRUE} if it is a domain object, \code{FALSE} if not.
#'
#' @export is_domain
#'
#' @examples
#' is_domain(compose_description())
is_domain <- function(x) if ("bco.domain" %in% class(x)) TRUE else FALSE

#' Is this a BCO object?
#'
#' @param x any object
#'
#' @return Logical. \code{TRUE} if it is a BCO object, \code{FALSE} if not.
#'
#' @export is_bco
#'
#' @examples
#' generate_example("minimal") %>% is_bco()
is_bco <- function(x) if ("bco" %in% class(x)) TRUE else FALSE

# test if all input objects are null
is_all_null <- function(...) all(sapply(list(...), is.null))

# test if any input objects is null
is_any_null <- function(...) any(sapply(list(...), is.null))

# convert data frame to list (as in list format, not dictionary format)
df2list <- function(df) {
  lst <- vector("list", nrow(df))
  for (i in 1:nrow(df)) lst[[i]] <- setNames(df[i, ], names(df))
  lst
}

#' Generate example BioCompute Objects
#'
#' @param type Example type. Default is \code{"minimal"}.
#'
#' @return Example BioCompute Object
#'
#' @export generate_example
#'
#' @examples
#' generate_example("minimal") %>% convert_json()
generate_example <- function(type = c("minimal", "HCV1a")) {
  type <- match.arg(type)
  if (type == "minimal") {
    tlf <- compose_tlf(
      compose_provenance(), compose_usability(), compose_extension(),
      compose_description(), compose_execution(), compose_parametric(),
      compose_io(), compose_error(),
      bco_id = "id"
    )
    return(biocompute::compose(
      tlf,
      compose_provenance(), compose_usability(), compose_extension(),
      compose_description(), compose_execution(), compose_parametric(),
      compose_io(), compose_error()
    ))
  }

  if (type == "HCV1a") {
    name <- "HCV1a ledipasvir resistance SNP detection"
    version <- "1.0.0"
    review <- data.frame(
      "status" = c("approved", "approved"),
      "reviewer_comment" = c("Approved by [company name] staff. Waiting for approval from FDA Reviewer", "The revised BCO looks fine"),
      "date" = c(
        as.POSIXct("2017-11-12T12:30:48", format = "%Y-%m-%dT%H:%M:%S", tz = "EST"),
        as.POSIXct("2017-12-12T12:30:48", format = "%Y-%m-%dT%H:%M:%S", tz = "America/Los_Angeles")
      ),
      "reviewer_name" = c("Jane Doe", "John Doe"),
      "reviewer_affiliation" = c("Seven Bridges Genomics", "U.S. Food and Drug Administration"),
      "reviewer_email" = c("example@sevenbridges.com", "example@fda.gov"),
      "reviewer_contribution" = c("curatedBy", "curatedBy"),
      "reviewer_orcid" = c("https://orcid.org/0000-0000-0000-0000", NA),
      stringsAsFactors = FALSE
    )

    derived_from <- "https://github.com/biocompute-objects/BCO_Specification/blob/1.2.1-beta/HCV1a.json"
    obsolete_after <- as.POSIXct("2018-11-12T12:30:48", format = "%Y-%m-%dT%H:%M:%S", tz = "EST")

    embargo <- c(
      "start_time" = as.POSIXct("2017-10-12T12:30:48", format = "%Y-%m-%dT%H:%M:%S", tz = "EST"),
      "end_time" = as.POSIXct("2017-11-12T12:30:48", format = "%Y-%m-%dT%H:%M:%S", tz = "EST")
    )

    created <- as.POSIXct("2017-01-20T09:40:17", format = "%Y-%m-%dT%H:%M:%S", tz = "EST")
    modified <- as.POSIXct("2019-05-10T09:40:17", format = "%Y-%m-%dT%H:%M:%S", tz = "EST")

    contributors <- data.frame(
      "name" = c("Jane Doe", "John Doe"),
      "affiliation" = c("Seven Bridges Genomics", "U.S. Food and Drug Administration"),
      "email" = c("example@sevenbridges.com", "example@fda.gov"),
      "contribution" = I(list(c("createdBy", "curatedBy"), c("authoredBy"))),
      "orcid" = c("https://orcid.org/0000-0000-0000-0000", NA),
      stringsAsFactors = FALSE
    )

    license <- "https://creativecommons.org/licenses/by/4.0/"

    provenance <- compose_provenance(
      name, version, review, derived_from, obsolete_after,
      embargo, created, modified, contributors, license
    )

    text <- c(
      "Identify baseline single nucleotide polymorphisms (SNPs)[SO:0000694], (insertions)[SO:0000667], and (deletions)[SO:0000045] that correlate with reduced (ledipasvir)[pubchem.compound:67505836] antiviral drug efficacy in (Hepatitis C virus subtype 1)[taxonomy:31646]",
      "Identify treatment emergent amino acid (substitutions)[SO:1000002] that correlate with antiviral drug treatment failure",
      "Determine whether the treatment emergent amino acid (substitutions)[SO:1000002] identified correlate with treatment failure involving other drugs against the same virus"
    )

    usability <- compose_usability(text)

    fhir_endpoint <- "https://fhirtest.uhn.ca/baseDstu3"
    fhir_version <- "3"
    fhir_resources <- data.frame(
      "id" = c("21376", "6288583", "25544", "92440", "4588936"),
      "resource" = c(
        "Sequence", "DiagnosticReport", "ProcedureRequest",
        "Observation", "FamilyMemberHistory"
      ),
      stringsAsFactors = FALSE
    )

    fhir <- compose_fhir(fhir_endpoint, fhir_version, fhir_resources)

    scm_repository <- "https://github.com/example/repo1"
    scm_type <- "git"
    scm_commit <- "c9ffea0b60fa3bcf8e138af7c99ca141a6b8fb21"
    scm_path <- "workflow/hive-viral-mutation-detection.cwl"
    scm_preview <- "https://github.com/example/repo1/blob/c9ffea0b60fa3bcf8e138af7c99ca141a6b8fb21/workflow/hive-viral-mutation-detection.cwl"

    scm <- compose_scm(scm_repository, scm_type, scm_commit, scm_path, scm_preview)

    extension <- compose_extension(fhir, scm)

    keywords <- c("HCV1a", "Ledipasvir", "antiviral resistance", "SNP", "amino acid substitutions")
    xref <- data.frame(
      "namespace" = c("pubchem.compound", "pubmed", "so", "taxonomy"),
      "name" = c("PubChem-compound", "PubMed", "Sequence Ontology", "Taxonomy"),
      "ids" = I(list(
        "67505836",
        "26508693",
        c("SO:000002", "SO:0000694", "SO:0000667", "SO:0000045"),
        "31646"
      )),
      "access_time" = c(
        as.POSIXct("2017-01-20T09:40:17", format = "%Y-%m-%dT%H:%M:%S", tz = "EST"),
        as.POSIXct("2017-01-21T09:40:17", format = "%Y-%m-%dT%H:%M:%S", tz = "EST"),
        as.POSIXct("2017-01-22T09:40:17", format = "%Y-%m-%dT%H:%M:%S", tz = "EST"),
        as.POSIXct("2017-01-23T09:40:17", format = "%Y-%m-%dT%H:%M:%S", tz = "EST")
      ),
      stringsAsFactors = FALSE
    )

    platform <- "Seven Bridges Platform"

    pipeline_meta <- data.frame(
      "step_number" = c("1"),
      "name" = c("HIVE-hexagon"),
      "description" = c("Alignment of reads to a set of references"),
      "version" = c("1.3"),
      stringsAsFactors = FALSE
    )

    pipeline_prerequisite <- data.frame(
      "step_number" = rep("1", 5),
      "name" = c(
        "Hepatitis C virus genotype 1",
        "Hepatitis C virus type 1b complete genome",
        "Hepatitis C virus (isolate JFH-1) genomic RNA",
        "Hepatitis C virus clone J8CF, complete genome",
        "Hepatitis C virus S52 polyprotein gene"
      ),
      "uri" = c(
        "https://www.ncbi.nlm.nih.gov/nuccore/22129792",
        "https://www.ncbi.nlm.nih.gov/nuccore/5420376",
        "https://www.ncbi.nlm.nih.gov/nuccore/13122261",
        "https://www.ncbi.nlm.nih.gov/nuccore/386646758",
        "https://www.ncbi.nlm.nih.gov/nuccore/295311559"
      ),
      "access_time" = c(
        as.POSIXct("2017-01-24T09:40:17", format = "%Y-%m-%dT%H:%M:%S", tz = "EST"),
        as.POSIXct("2017-01-24T09:40:17", format = "%Y-%m-%dT%H:%M:%S", tz = "EST"),
        as.POSIXct("2017-01-24T09:40:17", format = "%Y-%m-%dT%H:%M:%S", tz = "EST"),
        as.POSIXct("2017-01-24T09:40:17", format = "%Y-%m-%dT%H:%M:%S", tz = "EST"),
        as.POSIXct("2017-01-24T09:40:17", format = "%Y-%m-%dT%H:%M:%S", tz = "EST")
      ),
      stringsAsFactors = FALSE
    )

    pipeline_input <- data.frame(
      "step_number" = rep("1", 2),
      "uri" = c(
        "https://example.com/dna.cgi?cmd=objFile&ids=514683",
        "https://example.com/dna.cgi?cmd=objFile&ids=514682"
      ),
      "access_time" = c(
        as.POSIXct("2017-01-24T09:40:17", format = "%Y-%m-%dT%H:%M:%S", tz = "EST"),
        as.POSIXct("2017-01-24T09:40:17", format = "%Y-%m-%dT%H:%M:%S", tz = "EST")
      ),
      stringsAsFactors = FALSE
    )

    pipeline_output <- data.frame(
      "step_number" = rep("1", 2),
      "uri" = c(
        "https://example.com/data/514769/allCount-aligned.csv",
        "https://example.com/data/514801/SNPProfile*.csv"
      ),
      "access_time" = c(
        as.POSIXct("2017-01-24T09:40:17", format = "%Y-%m-%dT%H:%M:%S", tz = "EST"),
        as.POSIXct("2017-01-24T09:40:17", format = "%Y-%m-%dT%H:%M:%S", tz = "EST")
      ),
      stringsAsFactors = FALSE
    )

    description <- compose_description(
      keywords, xref, platform,
      pipeline_meta, pipeline_prerequisite, pipeline_input, pipeline_output
    )

    script <- "https://example.com/workflows/antiviral_resistance_detection_hive.py"
    script_driver <- "shell"
    software_prerequisites <- data.frame(
      "name" = c("HIVE-hexagon", "HIVE-heptagon"),
      "version" = c("babajanian.1", "albinoni.2"),
      "uri" = c(
        "https://example.com/dna.cgi?cmd=dna-hexagon&cmdMode=-",
        "https://example.com/dna.cgi?cmd=dna-heptagon&cmdMode=-"
      ),
      "access_time" = c(
        as.POSIXct("2017-01-24T09:40:17", format = "%Y-%m-%dT%H:%M:%S", tz = "EST"),
        as.POSIXct("2017-01-24T09:40:17", format = "%Y-%m-%dT%H:%M:%S", tz = "EST")
      ),
      "sha1_chksum" = c("d60f506cddac09e9e816531e7905ca1ca6641e3c", NA),
      stringsAsFactors = FALSE
    )
    external_data_endpoints <- data.frame(
      "name" = c("generic name", "access to ftp server", "access to e-utils web service"),
      "url" = c(
        "protocol://domain:port/application/path",
        "ftp://data.example.com:21/",
        "https://eutils.ncbi.nlm.nih.gov/entrez/eutils"
      ),
      stringsAsFactors = FALSE
    )
    environment_variables <- data.frame(
      "key" = c("HOSTTYPE", "EDITOR"),
      "value" = c("x86_64-linux", "vim")
    )

    execution <- compose_execution(
      script, script_driver, software_prerequisites, external_data_endpoints, environment_variables
    )

    df_parametric <- data.frame(
      "param" = c(
        "seed", "minimum_match_len",
        "divergence_threshold_percent",
        "minimum_coverage", "freq_cutoff"
      ),
      "value" = c("14", "66", "0.30", "15", "0.10"),
      "step" = c(1, 1, 1, 2, 2),
      stringsAsFactors = FALSE
    )

    parametric <- compose_parametric(df_parametric)

    input_subdomain <- data.frame(
      "filename" = c(
        "Hepatitis C virus genotype 1",
        "Hepatitis C virus type 1b complete genome"
      ),
      "uri" = c(
        "https://www.ncbi.nlm.nih.gov/nuccore/22129792",
        "https://www.ncbi.nlm.nih.gov/nuccore/5420376"
      ),
      "access_time" = c(
        as.POSIXct("2017-01-24T09:40:17", format = "%Y-%m-%dT%H:%M:%S", tz = "EST"),
        as.POSIXct("2017-01-24T09:40:17", format = "%Y-%m-%dT%H:%M:%S", tz = "EST")
      ),
      stringsAsFactors = FALSE
    )

    output_subdomain <- data.frame(
      "mediatype" = c("text/csv", "text/csv"),
      "uri" = c(
        "https://example.com/data/514769/dnaAccessionBased.csv",
        "https://example.com/data/514801/SNPProfile*.csv"
      ),
      "access_time" = c(
        as.POSIXct("2017-01-24T09:40:17", format = "%Y-%m-%dT%H:%M:%S", tz = "EST"),
        as.POSIXct("2017-01-24T09:40:17", format = "%Y-%m-%dT%H:%M:%S", tz = "EST")
      ),
      stringsAsFactors = FALSE
    )

    io <- compose_io(input_subdomain, output_subdomain)

    empirical <- data.frame(
      "key" = c("false_negative_alignment_hits", "false_discovery"),
      "value" = c("<0.0010", "<0.05"),
      stringsAsFactors = FALSE
    )

    algorithmic <- data.frame(
      "key" = c("false_positive_mutation_calls", "false_discovery"),
      "value" = c("<0.00005", "0.005"),
      stringsAsFactors = FALSE
    )

    error <- compose_error(empirical, algorithmic)

    tlf <- compose_tlf(
      provenance, usability, extension, description,
      execution, parametric, io, error
    )

    return(biocompute::compose(
      tlf, provenance, usability, extension, description,
      execution, parametric, io, error
    ))
  }
}
