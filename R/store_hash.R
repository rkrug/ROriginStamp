#' Storing a hash
#'
#' Store a hash to obtain a Trusted Time Stamp
#' wrapper around https://doc.originstamp.org/#!/default/post_hash_string
#'
#' @param hash hash for which shuld be sum=bmitted to OroginStamp
#' @param error_on_fail if \code{TRUE}, raise error when api call fails, otherwise return the failed response.
#' @param information contains information which is stored together with the submitted hash_string. Has to be a named list with each element being of length one


#' @return object of type \code{OriginStampResponse}
#' @importFrom httr POST add_headers stop_for_status content
#' @importFrom jsonlite fromJSON toJSON
#' @export
#'
#' @examples
store_hash <- function(
  hash,
  error_on_fail = TRUE,
  information = list(email = "none", name = NULL, comment = "Just a test")
) {
  result <- new_OriginStampResponse()
  ##
  url <- paste0(get_option("os_url"), hash)
  if (
    max(
      sapply(
        information,
        length
      )
    ) > 1
  ) {
    stop("Argument 'Information' has to be a named list with a maximum length of one per object!")
  }
  request_body_json <- as.character( jsonlite::toJSON( information, auto_unbox = TRUE ) )
  request_body_json <- gsub("\\{\\}", "null", request_body_json)
  result$response <- httr::POST(
    url = url,
    httr::add_headers(
      authorization = get_option("api_key"),
      body = request_body_json,
      'content-type' = "application/json",
      accept = "application/json",
      'user-agent' = "OriginStamp cURL Test"
    ),
    body = request_body_json
  )
  if (error_on_fail) {
    httr::stop_for_status(result$response)
  }
  ##
  try(
    {
      result$content <- extractContent( result$response )
    },
    silent = TRUE
  )
  ##
  return(result)
}
