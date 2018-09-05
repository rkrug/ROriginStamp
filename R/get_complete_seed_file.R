#' Get complete Seed File
#'
#' wrapper around \url{https://doc.originstamp.org/#!/default/get_download_seed_hash_string}
#' @param hash hast from which to download the seed
#' @param file file name to store the seed to. If \code{NULL}, save to default name (\code{HASH.OriginStamp.seed.txt}), if \code{""} (default) do not save, otherwise to \code{file}.
#' @param error_on_fail if TRUE, raise error when api call fails, otherwise return the failed response.
#'
#' @return object of class \code{OriginStampResponse}, \code{content} contains seed
#' @importFrom httr GET add_headers stop_for_status content
#' @importFrom jsonlite fromJSON
#' @export
#'
#' @examples
#'   \dontrun{
#'     # Retrieve complete seed filf
#'     get_complete_seed_file(
#'       hash = "53618057a7dd4063c0ed48b6dba2608e46740558"
#'     )
#'   }
get_complete_seed_file <- function(
  hash,
  file = "",
  error_on_fail = TRUE
) {
  result <- new_OriginStampResponse()
  ##
  url <- paste0(ROriginStamp_options("api_url"), "download/seed/", hash)
  result$response <- httr::GET(
    url = url,
    httr::add_headers( Authorization = ROriginStamp_options("api_key") )
  )
  if (error_on_fail) {
    httr::stop_for_status(result$response)
  }
  ##
  try(
    {
      result$content <- httr::content(
        x = result$response,
        as = "text"
      )
      result$content <- jsonlite::fromJSON( result$content )
    },
    silent = TRUE
  )
  ##
  if (is.null(file)) {
    file <- paste0(hash, ".OriginStamp.seed.txt")
  }
  if (file != "") {
    writeLines(
      text = result$content,
      con = file,
      sep = ""
    )
    return( invisible( result ) )
  } else {
    return( result )
  }
  ##
}
