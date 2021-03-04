#' Retrieve Information for the hash calculated from an R object or file.
#'
#' Wrapper around \url{https://api.originstamp.com/swagger/swagger-ui.html#/timestamp/getHashStatus}
#'
#' The behavior depends on the class of the argument `x`:
#'    - **an object of class `hash` as returned by the package openssl**: the hash is submitted to OriginStamp
#'    - **`character` vector of length 1 containing the name of an existing file**: the hash of the file is
#'      calculated and submitted to OriginStamp
#'    - **any other R object**: the hash is calculated using the function `hash()` and submitted to OriginStamp
#'
#' @md
#' @param x an R object of which a hash will be calculated using the function `hash(x)`. The resulting hash will be submitted to OriginStamp.
#' @param error_on_fail if \code{TRUE}, raise error when api call fails, otherwise return the failed response.
#' @param url the url of the api. The default is to use the url as returned by the function \code{api_url()}
#' @param key the api key. The default is to use the key as returned by the function \code{api_key()}
#'
#' @return object of type \code{OriginStampResponse}, \code{content} contains the additional info as \code{list}.
#' @importFrom curl new_handle handle_setheaders curl_fetch_memory
#' @importFrom jsonlite fromJSON
#' @export
#'
#' @examples
#'
#' \dontrun{
#' # get hash info
#' x <- "2c5d36be542f8f0e7345d77753a5d7ea61a443ba6a9a86bb060332ad56dba38e"
#' class(x) <- "hash"
#' get_hash_status(
#'   x = x
#' )
#'
#' get_hash_status(x = letters)
#' }
get_hash_status <- function(
  x,
  error_on_fail = TRUE,
  url = api_url(),
  key = api_key()
) {
  hash <- as.character(hash(x))
  class(hash) <- NULL

  # Assemble URL ------------------------------------------------------------

  url <- paste(url, "timestamp", hash, sep = "/")
  url <- gsub("//", "/", url)
  url <- gsub(":/", "://", url)

  # GET request -------------------------------------------------------------

  h <- curl::new_handle()
  curl::handle_setheaders(
    h,
    accept = " application/json",
    Authorization = key
  )

  response <- curl::curl_fetch_memory( url, h )

  # Process return value ----------------------------------------------------

  result <- new_OriginStampResponse( response )

  # Error handling

  if (!isTRUE(content_is_OK(result)) & error_on_fail) {
    stop(content_is_OK(result))
  }

  ##

  return(result)
}
