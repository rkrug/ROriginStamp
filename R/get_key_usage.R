#' Get the key usage
#'
#' wrapper around \url{https://api.originstamp.com/swagger/swagger-ui.html#/API_Key/getApiKeyUsage}. The
#' function downloads information about the api key.
#' @param error_on_fail if TRUE, raise error when api call fails, otherwise
#'   return the failed response.
#' @param url the url of the api. The default is to use the url as returned by the function \code{api_url()}
#' @param key the api key. The default is to use the key as returned by the function \code{api_key()}
#' @param save_raw_response_to save the response to a file in rds format
#' @param load_raw_response_from load the response from a file in rds format
#'
#' @return object of class \code{OriginStampResponse}.
#' @importFrom curl new_handle handle_setheaders curl_fetch_memory
#' @export
#'
#' @examples
#'
#' \dontrun{
#' # Retrieve complete merkle tree proof
#' get_key_usage()
#' }
get_key_usage <- function(
  error_on_fail = TRUE,
  url = api_url(),
  key = api_key(),
  save_raw_response_to = NULL,
  load_raw_response_from = NULL
) {

  if (!is.null(load_raw_response_from)) {
    response <- readRDS(load_raw_response_from)
  } else {

    # Assemble URL ------------------------------------------------------------

    url <- paste(url, "api_key", "usage", sep = "/")
    url <- gsub("//", "/", url)
    url <- gsub(":/", "://", url)

    # POST request ------------------------------------------------------------

    h <- curl::new_handle()
    curl::handle_setheaders(
      h,
      accept = " application/json",
      Authorization = key
    )

    response <- curl::curl_fetch_memory( url, h )
  }

  if (!is.null(save_raw_response_to)) {
    saveRDS( response, save_raw_response_to)
  }

  # Process return value ----------------------------------------------------

  result <- new_OriginStampResponse( response )

  # Error handling

  if (!isTRUE(content_is_OK(result)) & error_on_fail) {
    stop(content_is_OK(result))
  }

  # Return ------------------------------------------------------------------

  return(result)
}
