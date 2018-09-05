pkg_options <- settings::options_manager(
  api_url = "https://api.originstamp.org/api/",
  api_key = "Please get valid API key from https://Originstamp.org!"
)

#' Set or get options for my ROriginStamp package
#'
#' @param ... Option names to retrieve option values or \code{[key]=[value]} pairs to set options.
#'
#' @section Supported options:
#' The following options are supported
#' \itemize{
#'  \item{\code{api_url}} {(\code{character} = \code{"https://api.originstamp.org/api/"}) The url of the OriginStamp API }
#'  \item{\code{api_key}} {(\code{numeric} = \code{"Please get valid API key from Originstamp.org!"}) The api key.  This needs to be obtained from \url{https://originstamp.org/} }
#' }
#'
#' @importFrom settings stop_if_reserved
#' @export
ROriginStamp_options <- function(...){
  # protect against the use of reserved words.
  settings::stop_if_reserved(...)
  pkg_options(...)
}
