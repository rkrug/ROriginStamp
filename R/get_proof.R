#' Get the Proof (Merkle Tree) for the hash calculated from an R object or file.
#'
#' Wrapper around \url{https://api.originstamp.com/swagger/swagger-ui.html#/proof/getProof}. The
#' function downloads the merkle tree as proof.
#'
#' The behavior depends on the class of the argument `x`:
#'    - **an object of class `hash` as returned by the package openssl**: the hash is submitted to OriginStamp
#'    - **`character` vector of length 1 containing the name of an existing file**: the hash of the file is
#'      calculated and submitted to OriginStamp
#'    - **any other R object**: the hash is calculated using the function `hash()` and submitted to OriginStamp
#'
#' @md
#' @param x an R object of which a hash will be calculated using the function `hash(x)`. The resulting hash will be submitted to OriginStamp.
#' @param file if provided, file name to store the merkle tree as xml file to.
#' @param error_on_fail if TRUE, raise error when api call fails, otherwise
#'   return the failed response.
#' @param url the url of the api. The default is to use the url as returned by the function \code{api_url()}
#' @param key the api key. The default is to use the key as returned by the function \code{api_key()}
#'
#' @return object of class \code{OriginStampResponse}, with an additional
#'   element, \code{return$proof}, which contains the merkle tree as an
#'   \code{xml_document}.
#' @importFrom httr POST add_headers stop_for_status content
#' @importFrom jsonlite toJSON fromJSON
#' @importFrom xml2 write_xml
#' @export
#'
#' @examples
#'   \dontrun{
#'     # Retrieve complete merkle tree proof
#'     x <- "2c5d36be542f8f0e7345d77753a5d7ea61a443ba6a9a86bb060332ad56dba38e"
#'     class(x) <- "hash"
#'     get_proof(
#'       x = x
#'     )
#'   }
get_proof <- function(
  x,
  file,
  error_on_fail = TRUE,
  url = api_url(),
  key = api_key()
) {
  hash <- as.character( hash(x) )
  class(hash) <- NULL


  class(hash) <- NULL

  result <- new_OriginStampResponse()

  # Assemble URL ------------------------------------------------------------

  url <- paste(url, "timestamp", "proof", "url", sep = "/")
  url <- gsub("//", "/", url)
  url <- gsub(":/", "://", url)

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
      Authorization = key,
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

  if ((result$content$error_code != 0) & error_on_fail) {
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

  if (result$content$error_code == 0) {
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
  }
  return( result )
}
