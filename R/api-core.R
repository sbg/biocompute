# check request status - returns request content or the message

#' @importFrom httr status_code content

status_check <- function(req, as = "parsed", ...) {
  if (status_code(req) %in% c("200", "201", "202", "204")) {
    res <- content(req, as = as, ...)
    if (!is.null(res)) {
      attr(res, "response") <- req
    }
    return(res)
  } else if (status_code(req) %in% c("401", "403", "404", "503")) {
    msg <- content(req, as = as, ...)$message
    stop(paste0("HTTP Status ", status_code(req), ": ", msg), call. = FALSE)
  } else {
    if ("message" %in% names(content(req, as = as, ...))) {
      msg <- content(req, as = as, ...)$message
    } else {
      msg <- NULL
    }

    if (is.null(msg)) {
      if (status_code(req) %in% names(.sb_api_status_code)) {
        msg <- .sb_api_status_code[[status_code(req)]]
      }
      if (is.null(msg)) {
        print(content(req, as = as, ...))
        stop(paste("Error of unknown type occured", status_code(req)))
      } else {
        stop(paste0("HTTP Status ", status_code(req), ": ", msg), call. = FALSE)
      }
    } else {
      stop(paste0("HTTP Status ", status_code(req), ": ", msg), call. = FALSE)
    }
  }
}

# customize underlying http logic
# (handle_url2, build_url2, GET2, POST2)

#' @importFrom httr handle_find
#' @importFrom utils modifyList

handle_url2 <- function(handle = NULL, url = NULL, ...) {
  if (is.null(url) && is.null(handle)) {
    stop("Must specify at least one of url or handle")
  }
  if (is.null(handle)) handle <- handle_find(url)
  if (is.null(url)) url <- handle$url
  # workaround for `:::` checks
  new <- eval(parse(text = "httr:::named(list(...))"))
  if (length(new) > 0 || eval(parse(text = "httr:::is.url(url)"))) {
    old <- httr::parse_url(url)
    url <- build_url2(modifyList(old, new))
  }

  list(handle = handle, url = url)
}

#' @importFrom curl curl_escape

build_url2 <- function(url) {
  stopifnot(eval(parse(text = "httr:::is.url(url)")))
  scheme <- url$scheme
  hostname <- url$hostname
  if (!is.null(url$port)) {
    port <- paste0(":", url$port)
  }
  else {
    port <- NULL
  }
  path <- url$path
  if (!is.null(url$params)) {
    params <- paste0(";", url$params)
  } else {
    params <- NULL
  }
  if (is.list(url$query)) {
    url$query <- eval(parse(text = "httr:::compact(url$query)"))
    names <- curl_escape(names(url$query))
    values <- as.character(url$query)
    query <- paste0(names, "=", values, collapse = "&")
  } else {
    query <- url$query
  }
  if (!is.null(query)) {
    stopifnot(is.character(query), length(query) == 1)
    query <- paste0("?", query)
  }
  if (is.null(url$username) && !is.null(url$password)) {
    stop("Cannot set password without username")
  }

  paste0(scheme, "://", url$username, if (!is.null(url$password)) {
    ":"
  }, url$password, if (!is.null(url$username)) {
    "@"
  }, hostname, port, "/", path, params, query, if (!is.null(url$fragment)) {
    "#"
  }, url$fragment)
}

GET2 <- function(url = NULL, config = list(), ..., handle = NULL) {
  hu <- handle_url2(handle, url, ...)
  req <- eval(parse(text = 'httr:::request_build("GET", hu$url, config, ...)'))

  return(eval(parse(text = "httr:::request_perform(req, hu$handle$handle)")))
}

POST2 <- function(url = NULL, config = list(), ...,
                  body = NULL, encode = c("json", "form", "multipart"),
                  multipart = TRUE, handle = NULL) {
  if (!missing(multipart)) {
    warning("multipart is deprecated, please use encode argument instead",
      call. = FALSE
    )
    encode <- ifelse(multipart, "multipart", "form")
  }

  encode <- match.arg(encode)
  hu <- handle_url2(handle, url, ...)
  req <- eval(parse(text = 'httr:::request_build("POST", hu$url, httr:::body_config(body, encode), config, ...)'))

  return(eval(parse(text = "httr:::request_perform(req, hu$handle$handle)")))
}
