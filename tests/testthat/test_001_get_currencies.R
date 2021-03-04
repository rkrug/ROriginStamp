# test_that(
#   "result is as expected",
#   {
#     expect_snapshot_error(
#       x = {
#         api_key("none")
#         get_currencies()
#       },
#       class = "error",
#       cran = FALSE
#     )
#   }
# )

test_that(
  "error suppressed",
  {
    expect_snapshot_output(
      x = {
        api_key("dadada")
        res <- get_currencies(error_on_fail = FALSE)
        res$content$error_message <- grep("You do not have a valid API key.", res$content$error_message)
        res$headers <- NA
        res
      },
      cran = FALSE
    )
  }
)

test_that(
  "correct",
  {
    expect_snapshot_output(
      x = {
        api_key("")
        res <- get_currencies(error_on_fail = FALSE)
        res$headers <- NA
        res
      },
      cran = FALSE
    )
  }
)
