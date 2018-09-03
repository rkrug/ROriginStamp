context("store hash")
library(ROriginStamp)

set_option(
  "api_key",
  Sys.getenv("api_key")
)

test_that(
  "error if information not in correct format",
  {
    expect_error(
      object = store_hash(
        hash = "53618057a7dd4063c0ed48b6dba2608e467",
        information = list(name = "RMK", comments = "comment1")
      )
    )
  }
)

test_that(
  "result is as expected",
  {
    expect_known_output(
      object = store_hash(
        hash = "53618057a7dd4063c0ed48b6dba2608e46740558",
        information = list(name = "RMK", comments = "comment1")
      ),
      file = file.path(system.file(package = "ROriginStamp", "testdata"), "store_hash.rds")
    )
  }
)

test_that(
  "error or not depending on error_on_fail",
  {
    expect_error( object = store_hash(hash = "53618057a7dd4063c0ed48b6dba2608e467", error_on_fail = TRUE) )
    expect_known_output( object = store_hash(hash = "53618057a7dd4063c0ed48b6dba2608e46", error_on_fail = FALSE), file = file.path(system.file(package = "ROriginStamp", "testdata"), "store_hash_error.rds") )
  }
)

