#' Set Option
#'
#' @param value value for option
#' @param name name of option
#'
#' @return the old value from that Option
#' @export
#'
#' @examples
set_option <- function(name, value) {
  if (exists(name, .ORIGINSTAMP_CACHE)) {
    res <- base::get(name, envir = .ORIGINSTAMP_CACHE)
  } else {
    res <- NULL
  }
  assign(name, value, envir = .ORIGINSTAMP_CACHE)
  invisible(res)
}

#' Get Option
#'
#' @param name name of option
#'
#' @return value of option
#' @export
#'
#' @examples
get_option <- function(name) {
  base::get(name, envir = .ORIGINSTAMP_CACHE)
}

#' Check if option exists
#'
#' @param name name of option
#'
#' @return \code{logical} indicating if option \code{name} exists
#' @export
#'
#' @examples
exists_option <- function(name) {
  exists(name, .ORIGINSTAMP_CACHE)
}
