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
#' @importFrom httr GET add_headers stop_for_status content
#' @importFrom jsonlite fromJSON
#' @export
#'
#' @examples
#'   \dontrun{
#'     # get hash info
#'     x <- "2c5d36be542f8f0e7345d77753a5d7ea61a443ba6a9a86bb060332ad56dba38e"
#'     class(x) <- "hash"
#'     get_hash_status(
#'       x = x
#'     )
#'
#'     get_hash_status( x = letters )
#'   }
get_hash_status <- function(
  x,
  error_on_fail = TRUE,
  url = api_url(),
  key = api_key()
) {
  hash <- as.character( hash(x) )
  class(hash) <- NULL

  result <- new_OriginStampResponse()

  # Assemble URL ------------------------------------------------------------

  url <- paste(url, "timestamp", hash, sep = "/")
  url <- gsub("//", "/", url)
  url <- gsub(":/", "://", url)

  # GET request -------------------------------------------------------------

  result$response <- httr::GET(
    url = url,
    ## -H
    config = httr::add_headers(
      accept = "application/json",
      Authorization = key
    )
  )

  # Process return value ----------------------------------------------------

  if (error_on_fail) {
    httr::stop_for_status(result$response)
  }
  ##
  try(
    {
      result$content <- extract_content( result$response )
    },
    silent = TRUE
  )
  ##
  # if (is.null(file)) {
  #   file <- paste0(hash, ".OriginStamp.hash-info.yml")
  # }
  # if (file != "") {
  #   yaml::write_yaml(
  #     x = result$content,
  #     file = file
  #   )
  # }

  # Check if error  ---------------------------------------------------------

  if ((result$content$error_code != 0) & error_on_fail) {
    stop(
      sprintf(
        "OriginStamp API request failed [%s]\n%s\n\n<%s>",
        result$content$error_code,
        result$content$error_message,
        "see https://api.originstamp.com/swagger/swagger-ui.html#/proof/getHashStatus for details"
      )
    )
  }

  ##
  return(result)
}
