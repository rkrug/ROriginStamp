#' Create a timestamp for a for an R object or file.
#'
#' Submit a hash of x to obtain a Trusted Time Stamp for that hash
#' wrapper around \url{https://doc.originstamp.org/#!/default/post_hash_string}
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
#' @param comment a comment for the new timestamp
#' @param notifications notification settings
#' @param url the url of the api. The default is to use the url as returned by the function \code{api_url()}
#' @param key the api key. The default is to use the key as returned by the function \code{api_key()}
#'
#' @return object of type \code{OriginStampResponse}
#'
#' @importFrom curl new_handle handle_setheaders handle_setopt curl_fetch_memory curl_download
#' @importFrom jsonlite fromJSON toJSON
#' @export
#'
#' @examples
#'
#' \dontrun{
#' # create timestamp
#' create_timestamp(
#'   x = letters
#' )
#' }
create_timestamp <- function(
  x,
  error_on_fail = TRUE,
  comment = "test",
  notifications = data.frame(
    currency = 0,
    notification_type = 0,
    target = "originstamp@trashmail.com"
  ),
  url = api_url(),
  key = api_key()
) {

  # Prepare hash ------------------------------------------------------------

  hash <- as.character(hash(x))
  class(hash) <- NULL

  # Assemble URL ------------------------------------------------------------

  url <- paste(url, "timestamp", "create", sep = "/")
  url <- gsub("//", "/", url)
  url <- gsub(":/", "://", url)

  # Assemble body -----------------------------------------------------------

  body <- list(
    comment = comment,
    hash = hash,
    notifications = notifications
  )

  body <- as.character(jsonlite::toJSON(body, auto_unbox = TRUE))
  body <- gsub("\\{\\}", "null", body)

  # POST request ------------------------------------------------------------

  h <- curl::new_handle()

  curl::handle_setheaders(
    h,
    accept = " application/json",
    Authorization = key,
    "content-type" = "application/json"
  )

  curl::handle_setopt(
    h,
    copypostfields = body
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
