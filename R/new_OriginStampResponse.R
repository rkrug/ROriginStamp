#' New \code{OriginStampResponse} object
#'
#' Create new \code{OriginStampResponse} object. The object contains the following fields:
#' \describe{
#'   \item{status}{TThe status code of the request. 200 if OK. see \url{https://api.originstamp.com/swagger/swagger-ui.html} for details.}
#'   \item{content}{The returned object, converted into a format suitable for R. The exact format depends on the type of request.}
#'   \item{headers}{The returned eaders.}
#' }
#'
#' @param response a response from a call to \code{curl::curl_fetch_memory()} which is used to fill the return values of the new object
#'
#' @return object of class \code{OriginStampResponse}
#' @importFrom jsonlite fromJSON
#' @export
#'
#' @examples
#' x <- new_OriginStampResponse()
#' x
#' # $content
#' # [1] NA
#' #
#' # $response
#' # [1] NA
#' #
#' # attr(,"class")
#' # [1] "OriginStampResponse"
new_OriginStampResponse <- function( response = NULL ) {
  result <- list(
    status = NA,
    content = NA,
    headers = NA
  )
  class(result) <- "OriginStampResponse"

  ##

  if (!is.null(response)) {
    result$status  <- response$status_code
    result$content <- jsonlite::fromJSON( rawToChar(response$content) )
    result$headers <- strsplit(
      rawToChar(response$headers),
      split = "\r\n"
    )
  }

  ##

  return(result)
}
