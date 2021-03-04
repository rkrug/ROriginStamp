# test_that(
#   "result is as expected",
#   {
#     expect_snapshot_error(
#       x = {
#         api_key("none")
#         get_proof(x = "2c5d36be542f8f0e7345d77753a5d7ea61a443ba6a9a86bb060332ad56dba38e")
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
        res <- suppressMessages(
          get_proof(
            x = as.hash("2c5d36be542f8f0e7345d77753a5d7ea61a443ba6a9a86bb060332ad56dba38e"),
            file = tempfile(fileext = ".xml"),
            proof_type = "xml",
            error_on_fail = FALSE
          )
        )
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
        res <- suppressMessages(
          get_proof(
            x = as.hash("2c5d36be542f8f0e7345d77753a5d7ea61a443ba6a9a86bb060332ad56dba38e"),
            file = tempfile(fileext = ".xml"),
            proof_type = "xml",
            error_on_fail = FALSE
          )
        )
        res$headers <- NA
        res$content$data$download_url <- NA
        fn <- res$file
        res$file <- "file"
        res
      },
      cran = FALSE
    )
    expect_snapshot_file(
      path = fn,
      name = "proof.xml",
      binary = TRUE,
      cran = FALSE
    )
    unlink(fn)
  }
)
