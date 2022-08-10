#' Verify the proof
#'
#' INTERNAL FUNCTION!
#' Verify the proof. The proof needs to be provided as an xml object
#' @param proof the xml proof of the timestamp
#' @param verbose provide verbose output - mainly for debugging
#'
#' @return `TRUE` if verified successfully, otherwise `FALSE`
#'
#' @md
#'
verify_proof <- function(
  proof,
  verbose = FALSE
) {

  # Extract root key --------------------------------------------------------

  key <- xml2::xml_attr(proof, "value")
  if (verbose) {
    message("key: ", key)
  }

  # Extract child nodes -----------------------------------------------------

  child_nodes <- xml2::xml_children(proof)

  # Extract left and right hashes  ------------------------------------------

  h <- list()
  h[xml2::xml_name(child_nodes[[1]])] <- xml2::xml_attr(child_nodes[[1]], "value")
  h[xml2::xml_name(child_nodes[[2]])] <- xml2::xml_attr(child_nodes[[2]], "value")

  if (verbose) {
    message( "  left : ", h[["left"]] )
    message( "  right: ", h[["right"]])
  }

  if ( openssl::sha256(paste0(h[["left"]], h[["right"]])) != key ) {
    return (FALSE)
  } else {
    next_level <-  which( xml2::xml_length(child_nodes[]) == 2)
    if (length(next_level) == 0) {
      return(TRUE)
    } else {
      verify_proof( child_nodes[[next_level]] )
    }
  }

}

