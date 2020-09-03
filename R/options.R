#' Get or set the api key for all operations.
#'
#' If the api key \code{api_key() != ""}, that one is returned, otherwise
#' the value of the environmental variable "ORIGINSTAMP_API_KEY" is returned
#' @param key the api key to be used. The old api key is returned invisibly.
#'
#' @return Either the old api key (when \code{key} is supplied) or the current api key (when \code{key} is not supplied)
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
  } else {
    if (old_key == "") {
      old_key <- Sys.getenv("ORIGINSTAMP_API_KEY")
    }
  }
  invisible(old_key)
}

#' Get or set the api url for all operations.
#'
#' @param url the api url to be used. The api url is returned invisibly.
#'
#' @return Either the old api url (when \code{url} is supplied) or the current api url (when \code{url} is not supplied)
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
  }
  invisible(old_url)
}
