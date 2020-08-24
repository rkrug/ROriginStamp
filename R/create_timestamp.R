#' Create a timestamp for a hash
#'
#' Submit a hash to obtain a Trusted Time Stamp for that hash
#' wrapper around \url{https://doc.originstamp.org/#!/default/post_hash_string}
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
#'   \dontrun{
#'     # Store hash
#'     store_hash(
#'       hash = "53618057a7dd4063c0ed48b6dba2608e46740558",
#'       information = list(name = "My Name", comments = "A fantastic example")
#'     )
#'   }
create_timestamp <- function(
  hash,
  error_on_fail = TRUE,
  information = list(email = "none", name = "NULL", comment = "Just a test")
) {
  result <- new_OriginStampResponse()
  ##
  if (
    max(
      sapply(
        information,
        length
      )
    ) > 1
  ) {
    stop("Argument 'Information' has to be a list with a maximum length of one per object!")
  }

  # Assemble URL ------------------------------------------------------------

  url <- paste(api_url(), "timestamp", "create", sep= "/")
  gsub("//", "/", url)

  # Assemble body -----------------------------------------------------------

  body <- information
  body$hash <- hash
  body$notifications <- list( currency = 0, notification_type = 0, target = information$email)

  request_body_json <- as.character( jsonlite::toJSON( information, auto_unbox = TRUE ) )
  request_body_json <- gsub("\\{\\}", "null", request_body_json)

  # POST request ------------------------------------------------------------

  result$response <- httr::POST(
    url = url,
    ## -H
    config = httr::add_headers(
      accept = "application/json",
      Authorization = api_key(),
      body = request_body_json,
      'content-type' = "application/json",
      'user-agent' = "OriginStamp cURL Test"
    ),
    ## -d
    body = request_body_json
  )

  # Process return value ----------------------------------------------------

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
