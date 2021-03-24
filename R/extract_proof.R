#' Extract the proof from an xml proof or pdf certificate
#'
#' If the v arification fails, the function aborts and raises an error.
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
#' extract_proof("https://raw.githubusercontent.com/rkrug/ROriginStamp/master/inst/proof.Bitcoin.xml")
#' extract_proof("https://raw.githubusercontent.com/rkrug/ROriginStamp/master/inst/certificate.Bitcoin.pdf")
#'
extract_proof <- function(
  x,
  verify = FALSE
) {
  type <- strsplit(x, "\\.")
  type <- tail(type[[1]], 1)

  if (type == "pdf") {
    p <- pdftools::pdf_text(x)
    p <- p[[ grep('<?xml version=\"1.0\" encoding=\"UTF-8\"?', p) ]]
    xml <- paste0( "<?xml version=", gsub(".*<?xml version=","",p) )
    xml <- xml2::read_xml(xml)
  } else if (type == "xml") {
    xml <- xml2::read_xml(x)
  } else {
    stop("Unsopported format. The parameter x needs the extension `.pdf` or `.xml`!")
  }
  if (!verify) {
    warning("\n#############################\n This proof is read from the document as provided.\n It is NOT verified for consistency!\n#############################")
  } else {
    if (!verify_proof( xml )) {
      stop(
        "\n",
        "ATTENTION ATTENTION ATTENTION ATTENTION ATTENTION ATTENTION\n",
        "   This is not a valid proof!!!\n",
        "ATTENTION ATTENTION ATTENTION ATTENTION ATTENTION ATTENTION\n",
        "\n"
      )
    }
  }

  return( xml )
}
