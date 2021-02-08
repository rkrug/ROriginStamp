# test_that(
#   "error",
#   {
#     expect_snapshot_error(
#       x = {
#         api_key("none")
#         get_key_usage()
#       },
#       class = "error",
#       cran = TRUE
#     )
#   }
# )

test_that(
  "error suppressed",
  {
    expect_snapshot_output(
      x = {
        api_key("dadada")
        get_key_usage(error_on_fail = FALSE) %>%
          unlist(recursive = FALSE) %>%
          names()
      },
      cran = TRUE
    )
  }
)

test_that(
  "correct",
  {
    expect_snapshot_output(
      x = {
        api_key("")
        get_key_usage() %>%
          unlist(recursive = FALSE) %>%
          names()
      },
      cran = TRUE
    )
  }
)
