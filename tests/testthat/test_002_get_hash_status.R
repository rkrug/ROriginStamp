# test_that(
#   "error",
#   {
#     expect_snapshot_error(
#       x = {
#         api_key("none")
#         get_hash_status(x = "2c5d36be542f8f0e7345d77753a5d7ea61a443ba6a9a86bb060332ad56dba38e")
#       },
#       class= "error",
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
        res <- suppressMessages(
          get_hash_status(
            x = as.hash("2c5d36be542f8f0e7345d77753a5d7ea61a443ba6a9a86bb060332ad56dba38e"),
            error_on_fail = FALSE
          )
        )
        res$content$error_message <- grep("You do not have a valid API key.", res$content$error_message)
        res$headers <- NA
        res
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
        res <- suppressMessages(
          get_hash_status(as.hash("2c5d36be542f8f0e7345d77753a5d7ea61a443ba6a9a86bb060332ad56dba38e"))
        )
        res$headers <- NA
        res
      },
      cran = TRUE
    )
  }
)
