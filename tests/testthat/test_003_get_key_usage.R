# test_that(
#   "error",
#   {
#     expect_snapshot_error(
#       x = {
#         api_key("none")
#         get_key_usage()
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
        res <- get_key_usage(error_on_fail = FALSE)
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
        res <- get_key_usage()
        res$headers <- NA
        res$content$data$credits_per_month <- NA
        res$content$data$remaining_credits <- NA
        res$content$data$consumed_credits <- NA

        res$content$data$timestamps_per_month <- NA
        res$content$data$consumed_timestamps <- NA

        res$content$data$consumed_certificates <- NA
        res$content$data$limitation_type <- NA

        res$content$data$certificate_per_month <- NA
        res
      },
      cran = FALSE
    )
  }
)
