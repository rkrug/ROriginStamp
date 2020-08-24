context("003 get complete seed file")
library(ROriginStamp)

ROriginStamp_options(
  api_key = Sys.getenv("api_key")
)

test_that(
  "result is as expected",
  {
    expect_known_output(
      object = get_complete_seed_file(hash = "53618057a7dd4063c0ed48b6dba2608e46740558", file = tempfile()),
      file = file.path(system.file(package = "ROriginStamp", "testdata"), "get_complete_seed_file.rds")
    )
    expect_known_output(
      object = get_complete_seed_file(hash = "53618057a7dd4063c0ed48b6dba2608e46740558"),
      file = file.path(system.file(package = "ROriginStamp", "testdata"), "get_complete_seed_file.rds")
    )
  }
)

test_that(
  "error or not depending on error_on_fail",
  {
    expect_error(
      object = get_complete_seed_file(hash = "53618057a7dd4063c0ed48b6dba2608e467", error_on_fail = TRUE)
    )
    expect_known_output(
      object = get_complete_seed_file(hash = "53618057a7dd4063c0ed48b6dba2608e46", error_on_fail = FALSE),
      file = file.path(system.file(package = "ROriginStamp", "testdata"), "get_complete_seed_file_error.rds")
    )
  }
)

