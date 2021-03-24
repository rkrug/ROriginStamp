#' Get the transaction id from the root hash
#'
#' This opnly results in valid returns for timestamps after mif February 2021.
#' These are storing the root hash in OP_RETURN and these can therefore be searched.
#' @param root_hash root hash which has been submitted as OP_RETURN
#'
#' @return a vector containing the transaction ids found. Usially only one
#'
#' @importFrom curl curl_fetch_memory
#' @importFrom jsonlite fromJSON
#'
#' @export
#'
#' @examples
#' txid_from_root_hash("bf6eec9f213846a53ed187d41d2b9ed2e954649a45d2883e5df6b107b2eb0b75")
#' txid_from_root_hash("bf6eec9f213846a53ed187d41d2b9ed2e954649a45d2883e5dXXXXXXXXXXXXXX")
#' txid_from_root_hash("love")
#'
txid_from_root_hash <- function(root_hash) {
  url <- paste0("https://api.smartbit.com.au/v1/blockchain/search?q=", root_hash)

  # GET request -------------------------------------------------------------

  response <- curl::curl_fetch_memory( url )

  # Process return value ----------------------------------------------------

  if (response$status_code == 200) {
    result <- jsonlite::fromJSON( rawToChar(response$content) )
    result <- result$results$data$txid
  } else {
    result <- NULL
  }

  return( result)
}
