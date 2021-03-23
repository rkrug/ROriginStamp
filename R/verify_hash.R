#' Verify a timestamp of a hash
#'
#' There are effectively two ways of verifying a timestamp of a hash:
#'
#' 1. to use OriginStamp. This is the easies approach and is  described
#'   [on their documentation site](https://docs.originstamp.com/howto/verification.html#verify-a-timestamp-with-originstamp).
#'   Similarly, when specifying `use_originstamp = TRUE` the api will be used to retrieve information about the timestamp
#'   using the `get_hash_status()` function.
#' 2. to not use OriginStamp. This directly queries the bitcoin blockchain.
#'   For this, it is essential to have either the xml proof or the pdf certificate of the timestamp as can be downloaded by
#'   the function `get_proof()`. Here, we assume that all verification should be done without any interaction with OriginStamp,
#'   i.e. we **do not** download the proof or certificate automatically. In addition, only timestamps issued after middle
#'   February 2021 can be veryfied using this approach.
#'
#' @param x The object whose timestamp should be verified
#' @param proof either a file name or an URL pointing to the proof or certificate of the timestamp. If `proof` is provided
#' @param use_originstamp if `TRUE`, OriginStamp will be used to verity the timestamp of the hash
#' @param error_on_fail if TRUE, raise error when api call fails, otherwise
#'   return the failed response.
#' @param url the url of the api. The default is to use the url as returned by
#'   the function \code{api_url()}
#' @param key the api key. The default is to use the key as returned by the
#'   function \code{api_key()}
#'
#' @return
#' @md
#'
#' @export
#'
#' @examples
verify_hash <- function(
  x,
  proof = NULL,
  use_originstamp = is.null(proof),
  error_on_fail = TRUE,
  url = api_url(),
  key = api_key()
){
  if (use_originstamp) {
    result <- get_hash_status( x, error_on_fail = FALSE)
    if (result$content$error_code != 0) {
      result <- result$content$error_message
    } else {
      result <- result$content$data$timestamps
      result$timestamp <- as.POSIXct(result$timestamp / 1000, origin =  "1970-1-1")
    }
  } else {

    # Prepare hash ------------------------------------------------------------

    hash <- as.character(hash(x))
    class(hash) <- NULL

    # Extract root hash -----------------------------------------------------

    root_hash <- root_hash(proof, verify = FALSE)

    # Get txid ------------------------------------------------------------

    txid <- txid_from_root_hash( root_hash )


    # Get transaction from txid -----------------------------------------------

    transaction <- transaction_from_txid(txid)

    # Get timestamp time from transaction -----------------------------------------------

    result <- data.frame(
      currency_id = 0,
      transaction = transaction$transaction$txid,
      timestamp = as.POSIXct(transaction$transaction$time, origin = "1970-1-1")
    )
  }

  return (result )
}
