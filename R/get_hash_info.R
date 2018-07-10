#' Retrieve hash Information
#'
#' wrapper around https://doc.originstamp.org/#!/default/getHashInformation
#' @param hash hast from which to download the info
#' @param file file name to store the info to as \code{.yml} file. If \code{NULL}, save to default name (\code{HASH.OriginStamp.hash-inf0.txt}), if \code{""} (default) do not save, otherwise to \code{file}.
#' @param error_on_fail if \code{TRUE}, raise error when api call fails, otherwise return the failed response.
#'
#' @return object of type \code{OriginStampResponse}, \code{content} contains the additional info as \code{list}.
#' @importFrom httr GET add_headers stop_for_status content
#' @importFrom jsonlite fromJSON
#' @importFrom yaml write_yaml
#' @export
#'
#' @examples
get_hash_info <- function(
  hash,
  error_on_fail = TRUE,
  file = ""
) {
  result <- new_OriginStampResponse()
  ##
  url <- paste0(get_option("os_url"), hash)
  result$response <- httr::GET(
    url = url,
    httr::add_headers( Authorization = get_option("api_key") )
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
    file <- paste0(hash, ".OriginStamp.hash-info.yml")
  }
  if (file != "") {
    yaml::write_yaml(
      x = result$content,
      file = file
    )
  }
  ##
  return(result)
}
