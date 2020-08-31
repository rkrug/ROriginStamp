#' Get the key_ sage
#'
#' wrapper around \url{https://api.originstamp.com/swagger/swagger-ui.html#/API_Key/getApiKeyUsage}. The
#' function downloads information about the api key.
#' @param error_on_fail if TRUE, raise error when api call fails, otherwise
#'   return the failed response.
#'
#' @return object of class \code{OriginStampResponse}.
#' @importFrom httr POST add_headers stop_for_status content
#' @importFrom jsonlite toJSON fromJSON
#' @export
#'
#' @examples
#'   \dontrun{
#'     # Retrieve complete merkle tree proof
#'     get_key_usage()
#'   }
get_key_usage<- function(
  error_on_fail = TRUE
) {
  result <- new_OriginStampResponse()

  # Assemble URL ------------------------------------------------------------

  url <- paste(api_url(), "api_key", "usage", sep = "/")
  url <- gsub("//", "/", url)
  url <- gsub(":/", "://", url)

  # POST request ------------------------------------------------------------

  result$response <- httr::GET(
    url = url,
    ## -H
    config = httr::add_headers(
      accept = "*/*",
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
      result$content <- httr::content(
        x = result$response,
        as = "text"
      )
      result$content <- jsonlite::fromJSON( result$content )
    },
    silent = TRUE
  )


  # Check if error  ---------------------------------------------------------

  if (result$content$error_code != 0) {
    stop(
      sprintf(
        "OriginStamp API request failed [%s]\n%s\n\n<%s>",
        result$content$error_code,
        result$content$error_message,
        "see https://api.originstamp.com/swagger/swagger-ui.html#/API_Key/getApiKeyUsage"
      )
    )
  }


  # Return ------------------------------------------------------------------

  return( result )
}
