#' Extract and convert content from response
#'
#'  Convert timestamps to human readable date
#' @param response response as returned from \code{store_hash()} and \code{get_hash_info()}
#'
#' @return content in JSON
#' @importFrom httr content
#' @export
#'
#' @examples
extractContent <- function(
  response
){
  content <- httr::content(
    x = response,
    as = "parsed"
  )
  ##
  content$date_created <- as.character(
    as.Date(
      as.POSIXct(
        x = content$date_created / 1000,
        origin = "1970-01-01"
      )
    )
  )
  ##
  content$single_seed$timestamp <- as.character(
    as.Date(
      as.POSIXct(
        x = content$single_seed$timestamp / 1000,
        origin = "1970-01-01"
      )
    )
  )
  ##
  content$multi_seed$timestamp <- as.character(
    as.Date(
      as.POSIXct(
        x = content$multi_seed$timestamp / 1000,
        origin = "1970-01-01"
      )
    )
  )
  ##
  return(content)
}
