api_key <- function(key) {
  old_key <- getOption("ROriginStamp")$api_key
  if (!missing(key)) {
    opt <- getOption("ROriginStamp")
    opt$api_key <- key
    options(ROriginStamp = opt)
  }
  invisible(old_key)
}

api_url <- function(url) {
  old_url <- getOption("ROriginStamp")$api_url
  if (!missing(url)) {
    opt <- getOption("ROriginStamp")
    opt$api_key <- url
    options(ROriginStamp = opt)
  }
  invisible(old_url)
}
