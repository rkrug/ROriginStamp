#' Return the hash of an xml proof or pdf certificate
#'
#' @param x filename or URL pointing either to the xml proof or the pdf certificate issued from OriginStamp.
#'
#' @return an `hash` object containing the hash as used in the proof
#'
#' @md
#'
#' @importFrom xml2 xml_attr
#'
#' @export
#'
#' @examples
#' extract_hash("https://raw.githubusercontent.com/rkrug/ROriginStamp/master/inst/proof.Bitcoin.xml")
#' extract_hash("https://raw.githubusercontent.com/rkrug/ROriginStamp/master/inst/certificate.Bitcoin.pdf")
#'
extract_hash <- function(
  x
) {

  proof <- extract_proof(x)

  nodes <- xml2::xml_find_all(proof, ".//*")
  hash_node <- nodes[xml2::xml_attr(nodes, "type") == "hash"]
  hash <- xml2::xml_attr(hash_node, "value")

  if (length(hash) == 0) {
    stop("The document does not contain a valid proof!")
  }

  return( as.hash(hash) )
}
