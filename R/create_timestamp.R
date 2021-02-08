#' Create a timestamp for a for an R object or file.
#'
#' Submit a hash of x to obtain a Trusted Time Stamp for that hash
#' wrapper around \url{https://doc.originstamp.org/#!/default/post_hash_string}
#'
#' The behavior depends on the class of the argument `x`:
#'    - **an object of class `hash` as returned by the package openssl**: the hash is submitted to OriginStamp
#'    - **`character` vector of length 1 containing the name of an existing file**: the hash of the file is
#'      calculated and submitted to OriginStamp
#'    - **any other R object**: the hash is calculated using the function `hash()` and submitted to OriginStamp
#'
#' @md
#' @param x an R object of which a hash will be calculated using the function `hash(x)`. The resulting hash will be submitted to OriginStamp.
#' @param error_on_fail if \code{TRUE}, raise error when api call fails, otherwise return the failed response.
#' @param comment a comment for the new timestamp
#' @param notifications notification settings
#' @param url the url of the api. The default is to use the url as returned by the function \code{api_url()}
#' @param key the api key. The default is to use the key as returned by the function \code{api_key()}
#'
#' @return object of type \code{OriginStampResponse}
#'
#' @importFrom httr POST add_headers stop_for_status content
#' @importFrom jsonlite fromJSON toJSON
#' @export
#'
#' @examples
#'   \dontrun{
#'     # create timestamp
#'     create_timestamp(
#'       x = letters
#'     )
#'   }
create_timestamp <- function(
  x,
  error_on_fail = TRUE,
  comment = "test",
  notifications = data.frame(
    currency = 0,
    notification_type = 0,
    target = "originstamp@trashmail.com"
  ),
  url = api_url(),
  key = api_key()
) {
  hash <- as.character( hash(x) )
  class(hash) <- NULL

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

  url <- paste(url, "timestamp", "create", sep= "/")
  url <- gsub("//", "/", url)
  url <- gsub(":/", "://", url)

  # Assemble body -----------------------------------------------------------

  body <- list(
    comment = comment,
    hash = hash,
    notifications = notifications
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
      'Content-Type' = "application/json"#,
      # body = "request_body_json",
      # 'user-agent' = "libcurl/7.64.1 r-curl/4.3 httr/1.4.2 ROriginStamp"
    ),
    ## -d
    body = request_body_json #,
    # httr::verbose(data_out = TRUE, data_in = TRUE, info = TRUE)
  )

  # Process return value ----------------------------------------------------

  if (error_on_fail) {
    httr::stop_for_status(result$response)
  }
  ##
  try(
    {
      result$content <- extract_content( result$response )
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
        "see https://api.originstamp.com/swagger/swagger-ui.html#/proof/createTimestamp for details"
      )
    )
  }

  ##
  return(result)
}
