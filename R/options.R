#' Allows the user to set and read the api key to be used as default for all functions in this package.
#' @param key the api key to be used. The old api key is returned invisibly.
#'
#' @return If \code{api_key()} with no arguments, the current value for the api
#'   key is returned or, if it would be \code{(""}, the value of the
#'   environmental variable \code{ROriginStamp_api_key} is returned. If the
#'   argument \code{key} is specified, the api key will be set to the value of
#'   \code{key} and the old api key will be returned invisibly.
#' @export
#'
#' @examples
#' api_key()
#'
api_key <- function(key) {
  old_key <- getOption("ROriginStamp")$api_key

  if (!missing(key)) {
    opt <- getOption("ROriginStamp")
    opt$api_key <- key
    options(ROriginStamp = opt)
    return(invisible(old_key))
  } else {
    if (old_key == "") {
      old_key <- Sys.getenv("ROriginStamp_api_key")
    }
    return(old_key)
  }
}

#' Get or set the api url for all operations.
#'
#' @param url the api url to be used. The api url is returned invisibly.
#'
#' @return Either the old api url (when \code{url} is supplied) or the current
#'   api url (when \code{url} is not supplied)
#' @export
#'
#' @examples
#' api_url()
#'
api_url <- function(url) {
  old_url <- getOption("ROriginStamp")$api_url
  if (!missing(url)) {
    opt <- getOption("ROriginStamp")
    opt$api_url <- url
    options(ROriginStamp = opt)
    return(invisible(old_url))
  } else {
    return(old_url)
  }
}
