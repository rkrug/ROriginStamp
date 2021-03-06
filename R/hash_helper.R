#' Calculate sha256 hash
#'
#' A generic function function to calculate the sha256 hash from an R object or from a file.
#'
#' The behavior depends on the class of the argument `x`:
#'    - **an object of class `sha256` as returned by the package openssl**: the hash is returned as is
#'    - **`character` vector of length 1 containing the name of an existing file**: the sha256 hash of the file is calculated
#'    - **any other R object**: is serialized using `serialize(x, connection = NULL,
#'      ascii = FALSE, xdr = TRUE, version = 2, refhook = NULL)`` and the sha256 hash is
#'      created from that serialized object.
#'
#' The methods doing the work are:
#'    - `hash.hash(x)`: returns the object `x`
#'    - `hash.file()`: assumes `x` is an existing file and tries to calculate the hash from the file
#'    - `hash.default()`: calculates the hash from the serialized R object `x`
#' _NB_: These functions do assume the object `x` is what they expect it to be.
#' It is recommended to use the generic function `hash()` as this functiuon
#' auti=omatically selects the most appropriate method. Only use these if you
#' need to force a certain method (e.g. calculate the hash of a file name
#' instead of the existing file).
#'
#' _Remark_: if a hash is in  haracter form, it can be converted to a `hash`
#' object, by assigning the class `hash` (see example).
#' @md
#' @param x object
#' @param ... additional arguments for methods - not used at the moment
#'
#' @return sha256 hash object
#' @importFrom openssl sha256
#'
#' @rdname hash
#'
#' @export
#'
#' @examples
#' ## hash of a file:
#'
#' hash(system.file("DESCRIPTION", package = "ROriginStamp"))
#'
#' ## convert a character vector to a hash:
#'
#' x <- "2c5d36be542f8f0e7345d77753a5d7ea61a443ba6a9a86bb060332ad56dba38e"
#' class(x) <- "hash"
#' hash(x)
hash <- function(x) {
  if (is.character(x) && (length(x) == 1) && file.exists(x)) {
    hash.file(x)
  } else {
    UseMethod("hash", x)
  }
}

#'
#' Return x as is.
#' @rdname hash
#' @export hash.hash
#' @export
hash.hash <- function(x, ...) {
  message("\nx is already a hash - returning x unprocessed")
  return(x)
}

#'
#' Calculates the hash of the object x.
#' @rdname hash
#' @export hash.default
#' @export
hash.default <- function(x, ...) {
  message("\nCreate sha356 hash from R object x")
  x_ser <- serialize(x, connection = NULL, ascii = FALSE, xdr = TRUE, version = 2, refhook = NULL)
  hash <- openssl::sha256(x_ser)
  return(hash)
}

#'
#' Calculates the hash of the file \code{x}. Is called automatically as described in the Details section.
#' @rdname hash
#' @export hash.file
#' @export
hash.file <- function(x) {
  message("\nCreate sha356 hash from R file x [", x, "]")
  f <- file(x, open = "rb")
  hash <- openssl::sha256(f)
  close(f)
  return(hash)
}

#' Convert x into hash
#'
#' When \code{length(x) == 1} and x can be converted to a character by using the
#' \code{as.character()} function, x is converted to a hash object. This does
#' \bold{not} imply an=y hashing, just type conversion!
#'
#' Only really useful to convert a hash represented as a string into an object of class \code{hash}.
#' @param x a vector which can be, by using \code{as.character(x)}, converted to a character vector of length 1
#'
#' @return the to a character converted object x with the class \code{hash} assigned
#' @export
#'
#' @examples
#' as.hash("2c5d36be542f8f0e7345d77753a5d7ea61a443ba6a9a86bb060332ad56dba38e")
#'
as.hash <- function(x) {
  x <- as.character(x)
  if (length(x) != 1) {
    stop("'as.character(x)' has to result in a character vector of length of exactly 1!")
  }
  class(x) <- "hash"
  return(x)
}
