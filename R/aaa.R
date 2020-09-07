.onLoad <- function(libname, pkgname) {
  opt <- list(
    api_url = "https://api.originstamp.com/v3",
    api_key = ""
  )

  options(ROriginStamp = opt)
  invisible()
}
