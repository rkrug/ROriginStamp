# test_that(
#   "result is as expected",
#   {
#     expect_snapshot_error(
#       x = {
#         api_key("none")
#         get_proof(x = "2c5d36be542f8f0e7345d77753a5d7ea61a443ba6a9a86bb060332ad56dba38e")
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
        get_proof(
          x = structure("2c5d36be542f8f0e7345d77753a5d7ea61a443ba6a9a86bb060332ad56dba38e", class = c("hash")),
          error_on_fail = FALSE
        ) %>%
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
        get_proof(
          x = structure("2c5d36be542f8f0e7345d77753a5d7ea61a443ba6a9a86bb060332ad56dba38e", class = c("hash")),
        )$proof %>%
          as.character()
      },
      cran = TRUE
    )
  }
)
