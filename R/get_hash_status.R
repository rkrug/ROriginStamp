#' Retrieve hash Information
#'
#' wrapper around \url{https://doc.originstamp.org/#!/default/getHashInformation}
#' @param hash hast from which to download the info
#' @param file file name to store the info to as \code{.yml} file. If \code{NULL}, save to default name (\code{HASH.OriginStamp.hash-inf0.txt}), if \code{""} (default) do not save, otherwise to \code{file}.
#' @param error_on_fail if \code{TRUE}, raise error when api call fails, otherwise return the failed response.
#'
#' @return object of type \code{OriginStampResponse}, \code{content} contains the additional info as \code{list}.
#' @importFrom httr GET add_headers stop_for_status content
#' @importFrom jsonlite fromJSON
#' @importFrom yaml write_yaml
#' @export
#'
#' @examples
#'   \dontrun{
#'     # get hash info
#'     get_hash_status(
#'       hash = "2c5d36be542f8f0e7345d77753a5d7ea61a443ba6a9a86bb060332ad56dba38e"
#'     )
#'   }
get_hash_status <- function(
  hash,
  error_on_fail = TRUE,
  file = ""
) {
  result <- new_OriginStampResponse()

  # Assemble URL ------------------------------------------------------------

  url <- paste(api_url(), "timestamp", hash, sep = "/")
  url <- gsub("//", "/", url)
  url <- gsub(":/", "://", url)

  # GET request -------------------------------------------------------------

  result$response <- httr::GET(
    url = url,
    ## -H
    config = httr::add_headers(
      accept = "application/json",
      Authorization = api_key()
    )
  )

  # Process return value ----------------------------------------------------

  if (error_on_fail) {
    httr::stop_for_status(result$response)
  }
  ##
  try(
    {
      result$content <- extractContent( result$response )
    },
    silent = TRUE
  )
  ##
  if (is.null(file)) {
    file <- paste0(hash, ".OriginStamp.hash-info.yml")
  }
  if (file != "") {
    yaml::write_yaml(
      x = result$content,
      file = file
    )
  }

  # Check if error  ---------------------------------------------------------

  if (result$content$error_code != 0) {
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
