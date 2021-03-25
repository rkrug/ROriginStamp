#' Return the root hash of an xml proof or pdf certificate
#'
#' @param x filename or URL pointing either to the xml proof or the pdf certificate issued from OriginStamp.
#'
#' @return an `hash` object containing the root hash
#'
#' @md
#'
#' @importFrom xml2 xml_attr
#'
#' @export
#'
#' @examples
#' extract_root_hash("https://raw.githubusercontent.com/rkrug/ROriginStamp/master/inst/proof.Bitcoin.xml")
#' extract_root_hash("https://raw.githubusercontent.com/rkrug/ROriginStamp/master/inst/certificate.Bitcoin.pdf")
#'
extract_root_hash <- function(
  x
) {

  proof <- extract_proof(x)

  if (xml2::xml_attr(proof, "type") == "key") {
    root_hash <- xml2::xml_attr(proof, "value")
  } else {
    stop("The document does not contain a valid proof!")
  }

  return( as.hash(root_hash) )
}
