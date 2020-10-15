#' Export BioCompute Object to Seven Bridges Platforms
#'
#' @param file Path to the BCO file.
#' @param name Name of the BCO file to create on the platform.
#' Defaults to the name of the input file.
#' @param project Project to upload (export) the BCO file to.
#' Format: \code{"username/project"}.
#' @param token API auth token for the platform.
#' Generate the token from the platform's Developer Dashboard.
#' @param base_url API base URL.
#' Get the base URL from the platform's Developer Dashboard.
#' @param overwrite If \code{TRUE}, will overwrite the existing
#' BCO file with the same name in that project (if any).
#' If \code{FALSE}, will not overwrite.
#'
#' @return Response of the file upload request
#'
#' @export export_sevenbridges
#'
#' @examples
#' \donttest{
#' file_json <- tempfile(fileext = ".json")
#' generate_example("HCV1a") %>%
#'   convert_json() %>%
#'   export_json(file_json)
#'
#' try(
#'   export_sevenbridges(
#'     file_json,
#'     project = "rosalind_franklin/project_name",
#'     token = "your_api_auth_token",
#'     base_url = "https://cgc-api.sbgenomics.com/v2/"
#'   )
#' )
#' }
export_sevenbridges <-
  function(
           file, name = NULL, project = NULL,
           token = NULL, base_url = "https://api.sbgenomics.com/v2/",
           overwrite = TRUE) {
    rule_text("Starting the upload", line = 2)

    # check if the local file exists
    if (!file.exists(file)) stop("The BCO file does not exist")

    # if the new file name is not set, set it to the local file name
    if (is.null(name)) name <- basename(file)

    # api parameter sanity checks
    if (is.null(project)) stop("Please provide `project`.")
    if (!is_project_slug(project)) stop("Project slug format is `username/project`")

    if (is.null(token)) stop("Please provide `token`.")
    if (!is_token(token)) stop("The API token format is incorrect.")

    cat_checklist("Upload BCO from: ", cat_path_input(name))

    # upload the file
    rule_text("Uploading BCO")
    cat_checklist("Destination project: ", cat_path_output(project))
    resp <- upload_file(
      token = token, base_url = base_url,
      project_id = project, file = file,
      name = name, overwrite = overwrite
    )

    rule_text("DONE", line = 2)

    invisible(resp)
  }
