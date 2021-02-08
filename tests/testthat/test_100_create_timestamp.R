# test_that(
#   "error",
#   {
#     expect_snapshot_error(
#       x = {
#         api_key("none")
#         create_timestamp(x = "2c5d36be542f8f0e7345d77753a5d7ea61a443ba6a9a86bb060332ad56dba38e")
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
        create_timestamp(
          x = structure("2c5d36be542f8f0e7345d77753a5d7ea61a443ba6a9a86bb060332ad56dba38e", class = c("hash")),
          error_on_fail = FALSE
        ) %>%
          unlist(recursive = FALSE) %>%
          names() %>%
          print()
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
        create_timestamp(x = structure("2c5d36be542f8f0e7345d77753a5d7ea61a443ba6a9a86bb060332ad56dba38e", class = c("hash")))$content %>%
          print()
      },
      cran = TRUE
    )
  }
)
