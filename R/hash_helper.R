#' Calculate sha256 hash from file
#'
#' A helper function to calculate the sha256 hash from a file.
#' This can be a binary or text file.
#' @param file filename
#'
#' @return sha256 hash of the file
#' @importFrom openssl sha256
#' @export
#'
#' @examples
#' hash_file( system.file( "DESCRIPTION", package = "ROriginStamp") )
#'
hash_file <- function( file ){
  f <- file( file, open = "rb" )
  hash <- as.character( openssl::sha256( f ) )
  close(f)
  return(hash)
}
