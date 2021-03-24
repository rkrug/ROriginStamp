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
#'   the function `extract_proof()`. Here, we assume that all verification should be done without any interaction with OriginStamp.
#'   **Only timestamps issued after middle February 2021 can be veryfied using this approach (OP_RETURN usage by OriginStamp.**
#'
#' @param x The object whose timestamp should be verified
#' @param proof either a file name or an URL pointing to the proof or certificate of the timestamp
#' @param use_originstamp if `TRUE`, OriginStamp will be used to verity the timestamp of the hash. In this case, `proof` is not needed.
#' @param error_on_fail if TRUE, raise error when api call fails, otherwise
#'   return the failed response.
#' @param url the url of the api. The default is to use the url as returned by
#'   the function \code{api_url()}
#' @param key the api key. The default is to use the key as returned by the
#'   function \code{api_key()}
#'
#' @return
#'
#' @md
#'
#' @export
#'
#' @examples
verify_timestamp <- function(
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

    hash <- hash(x)

    # Check hash --------------------------------------------------------------

    if (hash != extract_hash(proof, verify = TRUE)) {
      stop( "The `hash` does not match the `proof`.\nPlease profide matching `hash` and `proof`!")
    }

    # Extract root hash -----------------------------------------------------

    root_hash <- extract_root_hash(proof, verify = TRUE)

    # Get txid ------------------------------------------------------------

    txid <- txid_from_root_hash( root_hash )

    if (length(txid) > 1) {
      warning("The root hash returned multiple transactions. Please verify by hand afterwards!")
    }

    # Get transaction from txid and extract timestamps -----------------------------

    if (length(txid) > 0) {
      transaction <- transaction_from_txid(txid)
    } else {
      transaction <- NULL
    }

    # Get timestamp time from transaction -----------------------------------------------

    if (length(transaction) > 0) {
      result <- data.frame(
        currency_id = 0,
        transaction = txid,
        timestamp = sapply(transaction, function(tr) {tr$transaction$time})
      )

      result$timestamp <- as.POSIXct( result$timestamp, origin = "1970-1-1" )
    } else {
      result <- data.frame(
        currency_id = numeric(0),
        transaction = character(0),
        timestamp = as.POSIXct(NULL)
      )
    }
  }

  return (result )
}
