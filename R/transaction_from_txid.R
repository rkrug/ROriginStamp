#' Find transaction based on transaction ID
#'
#' @param txid a vector containing the transaction ids. Usiully only one
#'
#' @return a list of the transactions identified by the txid
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

  result <- lapply(
    url,
    function(x) {
      response <- curl::curl_fetch_memory( x )
      jsonlite::fromJSON( rawToChar(response$content) )
    }
  )

  return(result)
}
