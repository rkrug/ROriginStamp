library(testthat)
library(ROriginStamp)

if ( Sys.getenv("api_keys") == "" ) {
  if ( file.exists("./ONLY_LOCAL_NOT_ON_GITHUB.R") ) {
    source("./ONLY_LOCAL_NOT_ON_GITHUB.R")
  }
}

ROriginStamp_options(
  api_key = Sys.getenv("api_key")
)

if ( ROriginStamp_options("api_key") != "" ) {
  test_check("ROriginStamp")
}
