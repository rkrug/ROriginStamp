#' Return the transaction id from the pdf certificate
#'
#' @param x filename or URL pointing either to the the pdf certificate issued from OriginStamp.
#'
#' @return the transaction id
#'
#' @importFrom pdftools pdf_text
#' @export
#'
#' @examples
#' transaction("https://raw.githubusercontent.com/rkrug/ROriginStamp/master/inst/certificate.Bitcoin.pdf")
#'
transaction <- function(
  x
) {
  p1 <- pdftools::pdf_text(x)[[1]]
  p1 <- strsplit(p1, "\n")
  p1 <- sapply(p1, trimws)
  result <- p1[[9]]

  return( result )
}
