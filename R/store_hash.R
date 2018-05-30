#' Storing a hash
#'
#' Store a hash to obtain a Trusted Time Stamp
#' wrapper around https://doc.originstamp.org/#!/default/post_hash_string
#' @return object of type \code{OriginStampResponse}
#' @importFrom httr POST add_headers stop_for_status content
#' @importFrom jsonlite fromJSON toJSON
#' @export
#'
#' @examples
store_hash <- function(
  hash,
  error_on_fail = TRUE,
  information = NULL
) {
  result <- new_OriginStampResponse()
  ##
  url <- paste0(get_option("os_url"), hash)
  request_body_json <- jsonlite::toJSON( information, auto_unbox = TRUE )
  result$response <- httr::POST(
    url,
    httr::add_headers(
      Authorization = get_option("api_key"),
      body = request_body_json
    ),
    httr::content_type_json()
  )
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
  ##
  return(result)
}
