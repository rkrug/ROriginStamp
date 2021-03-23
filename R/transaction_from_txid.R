#' Find transaction based on transaction ID
#'
#' @param txid transaction ID
#'
#' @return The transaction
#'
#' @importFrom curl curl_fetch_memory
#' @importFrom jsonlite fromJSON
#'
#' @export
#'
#' @examples
#'
transaction_from_txid <- function(
  txid
) {
  url <- paste0("https://api.smartbit.com.au/v1/blockchain/tx/", txid )

  # GET request -------------------------------------------------------------

  response <- curl::curl_fetch_memory( url )

  # Process return value ----------------------------------------------------

  result <- jsonlite::fromJSON( rawToChar(response$content) )

  return(result)
}
