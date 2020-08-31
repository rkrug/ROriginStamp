#' Create a timestamp for a hash
#'
#' Submit a hash to obtain a Trusted Time Stamp for that hash
#' wrapper around \url{https://doc.originstamp.org/#!/default/post_hash_string}
#'
#' @param hash hash for which shuld be sum=bmitted to OroginStamp
#' @param error_on_fail if \code{TRUE}, raise error when api call fails, otherwise return the failed response.
#' @param comment a comment for the new timestamp
#' @param notifications notification settings
#'
#' @return object of type \code{OriginStampResponse}
#'
#' @importFrom httr POST add_headers stop_for_status content
#' @importFrom jsonlite fromJSON toJSON
#' @export
#'
#' @examples
#'   \dontrun{
#'     # Store hash
#'     store_hash(
#'       hash = "2c5d36be542f8f0e7345d77753a5d7ea61a443ba6a9a86bb060332ad56dba38e",
#'       information = list(name = "My Name", comments = "A fantastic example")
#'     )
#'   }
create_timestamp <- function(
  hash,
  error_on_fail = TRUE,
  comment = "None",
  notifications = list(
    currency = 0,
    notification_type = 0,
    target = "originstamp@trashmail.com"
  )
) {
  result <- new_OriginStampResponse()
  ##
  # if (
  #   max(
  #     sapply(
  #       information,
  #       length
  #     )
  #   ) > 1
  # ) {
  #   stop("Argument 'Information' has to be a list with a maximum length of one per object!")
  # }

  # Assemble URL ------------------------------------------------------------

  url <- paste(api_url(), "timestamp", "create", sep= "/")
  url <- gsub("//", "/", url)
  url <- gsub(":/", "://", url)

  # Assemble body -----------------------------------------------------------

  body <- list(
    comment = comment,
    hash = hash,
    notifications = notifications,
    url = "string"
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
      'Content-Type' = "application/json"#,
      # body = "request_body_json",
      # 'user-agent' = "libcurl/7.64.1 r-curl/4.3 httr/1.4.2 ROriginStamp"
    ),
    ## -d
    body = request_body_json,
    httr::verbose(data_out = TRUE, data_in = TRUE, info = TRUE)
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

  # Check if error  ---------------------------------------------------------

  if (result$content$error_code != 0) {
    stop(
      sprintf(
        "OriginStamp API request failed [%s]\n%s\n\n<%s>",
        result$content$error_code,
        result$content$error_message,
        "see https://api.originstamp.com/swagger/swagger-ui.html#/proof/createTimestamp for details"
      )
    )
  }

  ##
  return(result)
}
