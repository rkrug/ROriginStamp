.ORIGINSTAMP_CACHE <- new.env(FALSE, parent = globalenv())

.onLoad <- function(lib, pkg) {
  set_option("os_url", "https://api.originstamp.org/api/")
  set_option("api_key", "GET API KEY")
}
