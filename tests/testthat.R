library(testthat)
library(ROriginStamp)

if ( Sys.getenv("api_key") == "" ) {
  if ( file.exists("./ONLY_LOCAL_NOT_ON_GITHUB.R") ) {
    source("./ONLY_LOCAL_NOT_ON_GITHUB.R")
  }
}

api_key( Sys.getenv("api_key") )

if ( api_key() != "" ) {
  test_check("ROriginStamp")
}
