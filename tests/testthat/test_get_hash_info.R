context("get hash info")
library(ROriginStamp)

test_that(
  "result is as expected",
  {
    expect_known_output( object = get_hash_info(hash = "53618057a7dd4063c0ed48b6dba2608e46740558"), file = file.path(system.file(package = "ROriginStamp", "testdata"), "get_hash_info.rds") )
  }
)

test_that(
  "error or not depending on error_on_fail",
  {
    expect_error( object = get_hash_info(hash = "53618057a7dd4063c0ed48b6dba2608e467", error_on_fail = TRUE) )
    expect_known_output( object = get_hash_info(hash = "53618057a7dd4063c0ed48b6dba2608e46", error_on_fail = FALSE), file = file.path(system.file(package = "ROriginStamp", "testdata"), "get_hash_info_error.rds") )
  }
)

