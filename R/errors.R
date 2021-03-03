#' Check and raise error
#'
#' @param OriginStampResponse object of type \code{OriginStampResponse}
#'
#' @return error message or \code{TRUE} if no error.
#'
content_is_OK <- function(OriginStampResponse) {
  if ( OriginStampResponse$content$error_code != 0) {
    result <- sprintf(
      "OriginStamp API request failed [%s]\n%s\n\n<%s>",
      OriginStampResponse$content$error_code,
      OriginStampResponse$content$error_message,
      "see https://api.originstamp.com/swagger/swagger-ui.html for further info."
    )
  } else {
    result <- TRUE
  }
  return(result)
}
