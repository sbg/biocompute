# Seven Bridges API interface
#' @importFrom httr add_headers PUT DELETE PATCH
api <- function(token = NULL, version = "v2", path = NULL,
                method = c("GET", "POST", "PUT", "DELETE", "PATCH"),
                query = NULL, body = list(),
                encode = c("json", "form", "multipart"),
                limit = 100L, offset = 0L,
                advance_access = FALSE, fields = NULL,
                base_url = paste0("https://api.sbgenomics.com/", version, "/"),
                ...) {
  if (is.null(token)) stop("token must be provided")

  method <- match.arg(method)
  encode <- match.arg(encode)

  headers <- c(
    "X-SBG-Auth-Token" = token
    # 'Accept' = 'application/json',
    # 'Content-type' = 'application/json'
  )

  # add optional advance access flag
  if (advance_access) {
    headers <- c(
      headers,
      "X-SBG-advance-access" = "advance"
    )
  }

  # setup query
  query <- c(query, list(limit = limit, offset = offset, fields = fields))
  idx <- !sapply(query, is.null)
  if (any(idx)) {
    query <- query[idx]
  } else {
    query <- NULL
  }

  req <- switch(

    method,

    GET = {
      GET2(paste0(base_url, path),
        add_headers(.headers = headers),
        query = query, ...
      )
    },

    POST = {
      # stopifnot(is.list(body))
      # body_json = toJSON(body, auto_unbox = TRUE)
      POST2(paste0(base_url, path),
        add_headers(.headers = headers),
        query = query,
        body = body, encode = encode, ...
      )
    },

    PUT = {
      # stopifnot(is.list(body))
      # body_json = toJSON(body, auto_unbox = TRUE)
      PUT(paste0(base_url, path),
        add_headers(.headers = headers),
        body = body, encode = encode, ...
      )
    },

    DELETE = {
      DELETE(
        paste0(base_url, path),
        add_headers(.headers = headers), ...
      )
    },

    PATCH = {
      # stopifnot(is.list(body))
      # body_json = toJSON(body, auto_unbox = TRUE)
      PATCH(paste0(base_url, path),
        add_headers(.headers = headers),
        body = body,
        encode = encode, ...
      )
    }
  )

  status_check(req)
}
