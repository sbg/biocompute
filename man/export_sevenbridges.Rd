% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/export-sevenbridges.R
\name{export_sevenbridges}
\alias{export_sevenbridges}
\title{Export BioCompute Object to Seven Bridges Platforms}
\usage{
export_sevenbridges(
  file,
  name = NULL,
  project = NULL,
  token = NULL,
  base_url = "https://api.sbgenomics.com/v2/",
  overwrite = TRUE
)
}
\arguments{
\item{file}{Path to the BCO file.}

\item{name}{Name of the BCO file to create on the platform.
Defaults to the name of the input file.}

\item{project}{Project to upload (export) the BCO file to.
Format: \code{"username/project"}.}

\item{token}{API auth token for the platform.
Generate the token from the platform's Developer Dashboard.}

\item{base_url}{API base URL.
Get the base URL from the platform's Developer Dashboard.}

\item{overwrite}{If \code{TRUE}, will overwrite the existing
BCO file with the same name in that project (if any).
If \code{FALSE}, will not overwrite.}
}
\value{
Response of the file upload request
}
\description{
Export BioCompute Object to Seven Bridges Platforms
}
\examples{
\dontrun{
file_json <- tempfile(fileext = ".json")
generate_example("HCV1a") \%>\%
  convert_json() \%>\%
  export_json(file_json)

try(
  export_sevenbridges(
    file_json,
    project = "rosalind_franklin/project_name",
    token = "your_api_auth_token",
    base_url = "https://cgc-api.sbgenomics.com/v2/"
  )
)
}
}
