library(testthat)
library(ROriginStamp)


if (file.exists("./tests/ONLY_LOCAL_NOT_ON_GITHUB.R")) {
  source("./tests/ONLY_LOCAL_NOT_ON_GITHUB.R")
}

if (api_key() != "") {
  test_check("ROriginStamp")
}
