#' @importFrom utils txtProgressBar setTxtProgressBar
#' @importFrom httr headers

upload_file <-
  function(
           token = token, file = NULL, size = NULL, project_id = NULL,
           name = NULL, base_url = NULL, part_size = NULL, part = list(),
           part_finished = 0L, initialized = FALSE, part_length = NULL,
           parallel_uploads = NULL, metadata = list(), overwrite = FALSE,
           verbose = TRUE, ...) {

    # validation
    stopifnot(!is.null(file))

    file <- normalizePath(file)

    if (!file.exists(file)) {
      stop("file does not exist, please provide relative or aboslution path to the file")
    }

    if (is.null(name)) {
      name <- basename(file)
    } else {
      name <- name
    }

    if (is.null(size)) {
      # file.size() is for R >= 3.2
      # to be compatible
      # size <<- file.size(file)
      size <- file.info(file)$size
    } else {
      size <- size
    }

    stopifnot(!is.null(project_id))

    if (is.numeric(size)) {
      if (size == 0) {
        stop("your file is empty file")
      }
      if (!(size <= 5 * 1024^4 & size > 0)) {
        stop("size must be between 0 - 5497558138880 (5TB), inclusive")
      }
    } else {
      stop("size must be numeric between 0 - 5497558138880 (5TB), inclusive")
    }

    if (!is.null(part_size)) {
      if (!(part_size <= 5 * 1024^3 && part_size >= 5 * 1024^2)) {
        stop("part_size must be 5 MB to 5 GB, last part can be < 5 MB")
      }
    }
    if (!is.null(part_length)) {
      if (!(part_length <= 1 && part_length >= 10000)) {
        stop("part_length must be from 1 to 10,000 (inclusive)")
      }
    }

    # initialize

    body <- list(
      "project" = project_id,
      "name" = name,
      "size" = size,
      "part_size" = part_size
    )

    res <- api(
      token = token, path = "upload/multipart",
      query = list(overwrite = overwrite),
      body = body,
      method = "POST",
      base_url = base_url, ...
    )

    upload_id <- res$upload_id

    initialized <- TRUE
    part_size <- as.integer(res$part_size)
    # size <<- res$size
    parallel_uploads <- as.logical(res$parallel_uploads)
    part_length <- as.integer(ceiling(size / part_size))

    # upload

    N <- part_length
    if (verbose) {
      cat_checklist("File size: ", crayon::red(paste0(format(round(size / 1024, 2), nsmall = 2), "kB")))
      cat_checklist("File parts: ", crayon::red(paste0(part_length)))
    }

    if (verbose) {
      pb <- txtProgressBar(min = 0, max = N, style = 3)
    }

    .start <- Sys.time()
    con <- file(file, "rb")

    for (i in 1:N) {
      p <- upload_info_part(token, i, upload_id = upload_id, base_url = base_url)
      url <- p$url
      # b = httr::upload_file(file)
      res <- PUT(url, body = readBin(con, "raw", part_size))
      etag <- headers(res)$etag

      # part[[i]]$etag <<- etag
      upload_complete_part(token, i, etag, upload_id = upload_id, base_url = base_url)
      # part_finished <<- as.integer(i)
      if (verbose) {
        setTxtProgressBar(pb, i)
      }
    }
    if (verbose) {
      close(pb)
    }
    res <- upload_complete_all(token = token, part = part, upload_id = upload_id, base_url = base_url)
    close(con)
    .end <- Sys.time()
    .diff <- .end - .start
    if (verbose) {
      cat_checklist(
        "Upload time:  ",
        crayon::red(ceiling(as.numeric(.diff)), " ", attr(.diff, "unit"), sep = "")
      )

      cat_checklist(
        "Upload speed: ",
        crayon::red(ceiling(size / 1024 / 1024 / as.numeric(.diff)), " Mb/", attr(.diff, "unit"), sep = "")
      )
    }

    # # when we complete we could add meta
    # meta <- .self$metadata$asList()
    fl.id <- res$id
    fl.meta <- paste0(file, ".meta")
    if (length(metadata)) {
      if (file.exists(fl.meta)) {
        message("Ignore meta file: ", fl.meta)
      }
      message("Adding metadata ...")
      set_meta(id = fl.id, metadata, token = token)
      message("Metadata complete")

      # metadata <<- normalizeMeta(metadata)
    } else {
      if (file.exists(fl.meta)) {
        message("loading meta from: ", fl.meta)
        metalist <- jsonlite::fromJSON(fl.meta)
        set_meta(id = fl.id, metadata = metalist, token = token)
        # browser()
        # metalist
        # do.call(Metadata, metalist)
        #
        # metadata <<- do.call(Metadata, metalist)
        # metadata <<- normalizeMeta(metalist)
      }
    }

    invisible(res)
  }

#' @importFrom jsonlite unbox

upload_complete_part <- function(token = token, part_number = NULL, etag = NULL, upload_id = NULL, base_url = NULL) {
  body <- list(
    part_number = unbox(part_number),
    response = list(headers = list(ETag = unbox(etag)))
  )

  res <- api(
    token = token, path = paste0(
      "upload/multipart/",
      upload_id, "/part"
    ),
    body = body,
    method = "POST",
    base_url = base_url
  )
}

upload_complete_all <- function(token = token, part = part, upload_id = NULL, base_url = NULL, ...) {
  # FIXME:
  pl <- lapply(part, function(p) {
    list(
      part_number = unbox(p$part_number),
      response = list(headers = list(ETag = unbox(p$etag)))
    )
  })
  body <- list(parts = pl)

  res <- api(
    token = token, path = paste0(
      "upload/multipart/",
      upload_id, "/complete"
    ),
    body = body,
    method = "POST",
    base_url = base_url, ...
  )
}

upload_delete <- function(token = token, upload_id = NULL, base_url = NULL) {
  api(
    token = token, path = paste0("/upload/multipart/", upload_id),
    method = "DELETE",
    base_url = base_url
  )
}

set_meta <- function(token = token, project_id = NULL, metadata = list(), ...) {
  .query <- list(project = project_id)
  if (length(metadata)) {
    new.meta <- unlist(metadata)
    names(new.meta) <- sapply(
      names(new.meta),
      function(nm) paste("metadata", nm, sep = ".")
    )
    .query <- c(.query, as.list(new.meta))
  }
  api(
    token = token, path = "files", method = "GET",
    query = .query, ...
  )
}

set_meta <- function(..., token = token, id = NULL, metadata = list(), overwrite = FALSE) {
  o <- metadata

  md <- dots2list(...)

  if (length(md)) {
    if (!overwrite) {
      req <- api(
        token = token, path = paste0("files/", id, "/metadata"),
        body = md,
        method = "PATCH",
        ...
      )
    } else {
      req <- api(
        token = token, path = paste0("files/", id, "/metadata"),
        body = md,
        method = "PUT",
        ...
      )
    }
  } else {
    if (overwrite) {
      # overwrite!
      message("reset meta")
      req <- api(
        token = token, path = paste0("files/", id, "/metadata"),
        method = "PUT",
        ...
      )
    } else {
      message("Nothing to add")
      req <- NULL
    }
  }

  # # edit the object only when update is successful
  # metadata <<- req
  req
}

upload_info_part <- function(token = token, part_number = NULL, upload_id = NULL, base_url = NULL, ...) {
  stopifnot(!is.null(part_number))

  res <- api(
    token = token, path = paste0(
      "upload/multipart/",
      upload_id, "/part/", part_number
    ),
    method = "GET",
    base_url = base_url,
    ...
  )
  res
}
