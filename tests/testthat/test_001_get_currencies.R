# test_that(
#   "result is as expected",
#   {
#     expect_snapshot_error(
#       x = {
#         api_key("none")
#         get_currencies()
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
        get_currencies(error_on_fail = FALSE) %>%
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
        get_currencies(error_on_fail = FALSE) %>%
          unlist(recursive = FALSE) %>%
          names()
      },
      cran = TRUE
    )
  }
)
