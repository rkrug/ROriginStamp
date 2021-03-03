#' Get the active currencies
#'
#' wrapper around \url{https://api.originstamp.com/swagger/swagger-ui.html#/scheduler/getActiveCurrencies}. The
#' function downloads information about the currencies.
#' @param error_on_fail if TRUE, raise error when api call fails, otherwise
#'   return the failed response.
#' @param url the url of the api. The default is to use the url as returned by the function \code{api_url()}
#' @param key the api key. The default is to use the key as returned by the function \code{api_key()}
#'
#' @return object of class \code{OriginStampResponse}.
#' @importFrom curl new_handle handle_setheaders curl_fetch_memory
#' @export
#'
#' @examples
#'
#' \dontrun{
#' # Retrieve complete merkle tree proof
#' get_currencies()
#' }
get_currencies <- function(
  error_on_fail = TRUE,
  url = api_url(),
  key = api_key()
) {

  # Assemble URL ------------------------------------------------------------

  url <- paste(url, "currencies", "get", sep = "/")
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

  # Process return value ----------------------------------------------------

  result <- new_OriginStampResponse( response )

  # Error handling

  if (!isTRUE(content_is_OK(result)) & error_on_fail) {
    stop(content_is_OK(result))
  }

  # Return ------------------------------------------------------------------

  return(result)
}
