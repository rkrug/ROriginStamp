#' Calculate the hash from a character vector or vector of file names
#'
#' If all elements point to existing files, the hashes of these files
#'   are calculated, otherwise the hashes of the character vector, one per element.
#' @rdname hash
#' @export hash_file
#' @export
hash <- function(x) {
  if (inherits(x, "hash")) {
    hashs <- x
  } else {
    if (class(x) != "character") {
      stop("x must be of class character!")
    }
    if (!all(file.exists(x))) {
      stop("Each element of x must be a file name of an existing file!")
    } else {
      hashs <- hash_file(x)
    }
  }
  return(hashs)
}

#' Calculate the hash from a vector of filenames
#'
#' Calculates the sha256 hash of each file in \code{x}.
#' @rdname hash
#' @export hash_file
#' @export
hash_file <- function(x) {
  if (class(x) != "character") {
    stop("x must be of class character!")
  }
  if (!all(file.exists(x))) {
    stop("All elements in x must be existing file names!")
  }
  hashs <- sapply(
    x,
    function(fn) {
      f <- file(fn, open = "rb")
      on.exit( close(f) )
      hash <- openssl::sha256(f)
      return(as.character(hash))
    }
  )
  names(hashs) <- NULL
  return(as.hash(hashs))
}

#' Calculate the hash from a character vector
#'
#' Calculates the sha256 hash of each element in \code{x}.
#' @rdname hash
#' @export hash.character
#' @export
hash.character <- function(x) {
  if (class(x) != "character") {
    stop("x must be of class character!")
  }
  message("Create sha356 hash from character vector x")
  hash <- openssl::sha256(x)
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
  if (!inherits(x, "character")) {
    stop("x must be of class character!")
  }
  class(x) <- c("hash", "sha256")
  return(x)
}
