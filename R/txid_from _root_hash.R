#' Title
#'
#' @param root_hash root hash which has been submitted as OP_RETURN
#'
#' @return the transaction id
#'
#' @importFrom curl curl_fetch_memory
#' @importFrom jsonlite fromJSON
#'
#' @export
#'
#' @examples
txid_from_root_hash <- function(root_hash) {
  url <- paste0("https://api.smartbit.com.au/v1/blockchain/search?q=", root_hash)

  # GET request -------------------------------------------------------------

  response <- curl::curl_fetch_memory( url )

  # Process return value ----------------------------------------------------

  result <- jsonlite::fromJSON( rawToChar(response$content) )

  return(result$results$data$txid)
}
