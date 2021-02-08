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
        get_hash_status(
          x = structure("2c5d36be542f8f0e7345d77753a5d7ea61a443ba6a9a86bb060332ad56dba38e", class = c("hash")),
          error_on_fail = FALSE)$content %>%
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
        get_hash_status(structure("2c5d36be542f8f0e7345d77753a5d7ea61a443ba6a9a86bb060332ad56dba38e", class = c("hash")))$content
      },
      cran = TRUE
    )
  }
)
