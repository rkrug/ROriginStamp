.ORIGINSTAMP_CACHE <- new.env(FALSE, parent = globalenv())

.onLoad <- function(lib, pkg) {
  set_option("os_url", "https://api.originstamp.org/api/")
  set_option("api_key", "51996e47-1260-4c6b-b8ad-bdccdd320a64")
}
