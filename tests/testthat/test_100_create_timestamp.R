context("001 create timestamp")

test_that(
  "error",
  {
    expect_error(
      object = {
        api_key("none")
        create_timestamp(hash = "2c5d36be542f8f0e7345d77753a5d7ea61a443ba6a9a86bb060332ad56dba38e")
      },
      regexp = "OriginStamp API request failed [3201]*."
    )
  }
)

test_that(
  "error suppressed",
  {
    expect_known_output(
      object = {
        api_key("dadada")
        create_timestamp(hash = "2c5d36be542f8f0e7345d77753a5d7ea61a443ba6a9a86bb060332ad56dba38e", error_on_fail = FALSE) %>%
          unlist(recursive = FALSE) %>%
          names() %>%
          print()
      },
      file = "ref_100_get_proof_error_suppressed.txt",
      update = TRUE
    )
  }
)


test_that(
  "correct",
  {
    expect_known_output(
      object = {
        api_key("")
        create_timestamp(hash = "2c5d36be542f8f0e7345d77753a5d7ea61a443ba6a9a86bb060332ad56dba38e")$content %>%
          print()
      },
      file = "ref_100_create_timestamp_correct.txt",
      update = TRUE
    )
  }
)
