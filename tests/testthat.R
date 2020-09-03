library(testthat)
library(ROriginStamp)


if ( file.exists("./tests/ONLY_LOCAL_NOT_ON_GITHUB.R") ) {
  source("./tests/ONLY_LOCAL_NOT_ON_GITHUB.R")
}

api_key( Sys.getenv("api_key") )

if ( api_key() != "" ) {
  test_check("ROriginStamp")
}
