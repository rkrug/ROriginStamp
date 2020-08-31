#' Get the Proof (Merkle Tree)
#'
#' wrapper around \url{https://api.originstamp.com/v3/timestamp/proof/url}. The
#' function downloads the merkle tree as proof.
#' @param hash hash from which to download the seed
#' @param file if provided, file name to store the merkle tree as xml file to.
#' @param error_on_fail if TRUE, raise error when api call fails, otherwise
#'   return the failed response.
#'
#' @return object of class \code{OriginStampResponse}, with an additional
#'   element, \code{return$proof}, which contains the merkle tree as an
#'   \code{xml_document}.
#' @importFrom httr POST add_headers stop_for_status content
#' @importFrom jsonlite toJSON fromJSON
#' @export
#'
#' @examples
#'   \dontrun{
#'     # Retrieve complete merkle tree proof
#'     get_proof(
#'       hash = "2c5d36be542f8f0e7345d77753a5d7ea61a443ba6a9a86bb060332ad56dba38e"
#'     )
#'   }
get_proof <- function(
  hash,
  file,
  error_on_fail = TRUE
) {
  result <- new_OriginStampResponse()

  # Assemble URL ------------------------------------------------------------

  url <- paste(api_url(), "timestamp", "proof", "url", sep = "/")
  url <- gsub("//", "/", url)

  # Assemble body -----------------------------------------------------------

  body <- list(
    currency = 0,
    proof_type = 0,
    hash_string = hash
  )

  request_body_json <- as.character( jsonlite::toJSON( body, auto_unbox = TRUE ) )
  request_body_json <- gsub("\\{\\}", "null", request_body_json)

  # POST request ------------------------------------------------------------

  result$response <- httr::POST(
    url = url,
    ## -H
    config = httr::add_headers(
      accept = "application/json",
      Authorization = api_key(),
      'content-type' = "application/json"
    ),
    body = request_body_json
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
        "see https://api.originstamp.com/swagger/swagger-ui.html#/proof/getProof for details"
      )
    )
  }

  # Download proof --------------------------------------------------------

  if (body$proof_type == 0) {
    result$proof <- httr::content(
      x = httr::GET( result$content$data$download_url ),
      type = "text/xml"
    )
    if (!missing(file)) {
      xml2::write_xml(
        x = result$proof,
        file = file
      )
    }
  }

  return( result )
}
