#' Get the Proof (Merkle Tree) for the hash calculated from an R object or file.
#'
#' Wrapper around \url{https://api.originstamp.com/swagger/swagger-ui.html#/proof/getProof}. The
#' function downloads the merkle tree as proof.
#'
#' @md
#' @param x an R object (character vector containing file names of existing files or strings) of which a hash will be calculated using the function
#'   `hash(x)`. The resulting hash will be submitted to OriginStamp.
#' @param proof_type The type of the proof format. Either "pdf" or "xml" are
#'   supported at the moment by OriginStamp.
#' @param file if provided, file name to store the proof in. Otherwise, the from
#'   OriginStamp is used \code{proof.CURRENCY.HASH.xml} for \code{proof_type == "xml"}
#'   or \code{certificate.CURRENCY.HASH.pdf} for \code{proof_type == "pdf"}.
#' @param error_on_fail if TRUE, raise error when api call fails, otherwise
#'   return the failed response.
#' @param url the url of the api. The default is to use the url as returned by
#'   the function \code{api_url()}
#' @param key the api key. The default is to use the key as returned by the
#'   function \code{api_key()}
#'
#' @return object of class \code{OriginStampResponse}, with an additional
#'   element, \code{file}, which contains the name of the saved certificate or proof.
#'
#' @importFrom curl new_handle handle_setheaders handle_setopt curl_fetch_memory curl_download
#' @importFrom jsonlite toJSON fromJSON
#'
#' @export
#'
#' @examples
#'
#' \dontrun{
#' # Retrieve complete merkle tree proof
#' x <- "2c5d36be542f8f0e7345d77753a5d7ea61a443ba6a9a86bb060332ad56dba38e"
#' class(x) <- "hash"
#' get_proof(
#'   x = x
#' )
#' }
get_proof <- function(
  x,
  file,
  proof_type = "pdf",
  error_on_fail = TRUE,
  url = api_url(),
  key = api_key()
) {

  # encode proof_type -------------------------------------------------------

  proof_type <- switch (
    proof_type,
    xml = 0,
    pdf = 1,
    stop("Not supported proof_type. Allowed are 'pdf' or 'xml'")
  )

  # prepare hash ------------------------------------------------------------

  hash <- as.character(hash(x))
  class(hash) <- NULL

  # Assemble URL ------------------------------------------------------------

  url <- paste(url, "timestamp", "proof", "url", sep = "/")
  url <- gsub("//", "/", url)
  url <- gsub(":/", "://", url)

  # Assemble body -----------------------------------------------------------

  body <- list(
    currency = "0",
    hash_string = hash,
    proof_type = proof_type
  )

  body <- as.character(jsonlite::toJSON(body, auto_unbox = TRUE))
  body <- gsub("\\{\\}", "null", body)

  # POST request ------------------------------------------------------------

  h <- curl::new_handle()

  curl::handle_setheaders(
    h,
    accept = " application/json",
    Authorization = key,
    "content-type" = "application/json"
  )

  curl::handle_setopt(
    h,
    copypostfields = body
  )

  response <- curl::curl_fetch_memory( url, h )

  # Process return value ----------------------------------------------------

  result <- new_OriginStampResponse( response )

  # Error handling

  if (!isTRUE(content_is_OK(result)) & error_on_fail) {
    stop(content_is_OK(result))
  }

  # download proof ----------------------------------------------------------

  if (isTRUE(content_is_OK(result))) {
    h <- curl::new_handle()

    curl::handle_setheaders(
      h,
      Accept = "application/octet-stream"
    )

    result$file <- ifelse(
      missing(file),
      result$content$data$file_name,
      file
    )

    curl::curl_download(
      url = result$content$data$download_url,
      destfile = ifelse(
        missing(file),
        result$file,
        file
      ),
      handle = h
    )
  }

  ##

  return(result)
}
