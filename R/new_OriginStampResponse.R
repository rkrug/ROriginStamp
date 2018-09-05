#' New \code{OriginStampResponse} object
#'
#' Create new \code{OriginStampResponse} object. The object contains the following fields:
#' \describe{
#'   \item{content}{The returned object, converted into a format suitable for R. The exact format depends on the type of request.}
#'   \item{response}{The actual respons from the call via the \code{httr} package as an object of type \code{response}.}
#' }
#'
#' @return object of class \code{OriginStampResponse}
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
new_OriginStampResponse <- function() {
  result <- list(
    content = NA,
    response = NA
  )
  class(result) <- "OriginStampResponse"
  return(result)
}
