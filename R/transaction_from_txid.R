#' Find transaction based on transaction ID
#'
#' \bold{This function is does not work anymore as the host used is not available anymore!}
#' \bold{It is only left in to demonstrate how it could be done.}
#' @param txid a vector containing the transaction ids. Usiully only one
#'
#' @return a list of the transactions identified by the txid
#'
#' @importFrom curl curl_fetch_memory
#' @importFrom jsonlite fromJSON
#'
#' @export
#'
#'
transaction_from_txid <- function(
  txid
) {
  stop(
    "This function is does not work anymore as the host used is not available anymore!\n",
    "It is only left in to demonstrate how it could be done."
  )
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
