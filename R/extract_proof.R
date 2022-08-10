#' Extract the proof from an xml proof or pdf certificate
#'
#' If the v verification fails, the function aborts and raises an error.
#' @param x filename or URL pointing either to the xml proof or the pdf certificate issued from OriginStamp.
#' @param verify if `FALSE`, read the root hash from the xml file. If `TRUE`, verify the root hash using the proof.
#' @param verbose if `TRUE`, details on the verification will be printed which can help to see where the proof is wrong.
#'
#' @return the root hash
#'
#' @md
#'
#' @importFrom xml2 read_xml xml_attr
#' @importFrom pdftools pdf_text
#' @importFrom utils tail
#' @export
#'
#' @examples
#' extract_proof(system.file("certificate.Bitcoin.pdf", package = "ROriginStamp"))
#' extract_proof(system.file("proof.Bitcoin.xml", package = "ROriginStamp"))
#' extract_proof(system.file("proof.Bitcoin.xml", package = "ROriginStamp"), verify = FALSE)
#' ######
#' ## These will produce errors when executed
#'   # extract_proof(system.file("proof.faulty.xml", package = "ROriginStamp"))
#'   # extract_proof(system.file("proof.faulty.xml", package = "ROriginStamp"), verbose = TRUE)
#' ######
#'
extract_proof <- function(
  x,
  verify = TRUE,
  verbose = FALSE
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
    if (!verify_proof( xml, verbose )) {
      stop(
        "\n",
        "#################################################################\n",
        "## ATTENTION ATTENTION ATTENTION ATTENTION ATTENTION ATTENTION ##\n",
        "##              This is not a valid proof!!!                   ##\n",
        "## ATTENTION ATTENTION ATTENTION ATTENTION ATTENTION ATTENTION ##\n",
        "#################################################################\n",
        "\n"
      )
    }
  }

  return( xml )
}
