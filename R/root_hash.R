#' Return the root hash of an xml proof or pdf certificate
#'
#' @param x filename or URL pointing either to the xml proof or the pdf certificate issued from OriginStamp.
#' @param verify if `FALSE`, read the root hash from the xml file. If `TRUE`, verify the root hash using the proof.
#'
#' @return the root hash
#'
#' @md
#'
#' @importFrom xml2 read_xml xml_attr
#' @importFrom pdftools pdf_text
#' @export
#'
#' @examples
#' root_hash("https://raw.githubusercontent.com/rkrug/ROriginStamp/master/inst/proof.Bitcoin.xml")
#' root_hash("https://raw.githubusercontent.com/rkrug/ROriginStamp/master/inst/certificate.Bitcoin.pdf")
#'
root_hash <- function(
  x,
  verify = FALSE
) {
  type <- strsplit(x, "\\.")
  type <- tail(type[[1]], 1)

  if (type == "xml") {
    xml <- xml2::read_xml(x)

    if (!verify) {
      if (xml2::xml_attr(xml, "type") == "key") {
        result <- xml2::xml_attr(xml, "value")
        warning("\n#############################\n This root hash is read from the xml provided,\n It is NOT verified to implement the hash!\n#############################")
      } else {
        result <- FALSE
      }
    } else {
      stop("verify = TRUE not implemented yet!")
    }
  } else if (type == "pdf") {
    p1 <- pdftools::pdf_text(x)[[1]]
    p1 <- strsplit(p1, "\n")
    p1 <- sapply(p1, trimws)
    result <- p1[[11]]
  }

  return( result )
}
