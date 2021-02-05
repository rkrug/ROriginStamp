test_that(
  "result is as expected",
  {
    expect_error(
      object = {
        api_key("none")
        get_proof(hash = "2c5d36be542f8f0e7345d77753a5d7ea61a443ba6a9a86bb060332ad56dba38e")
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
        get_proof(hash = "2c5d36be542f8f0e7345d77753a5d7ea61a443ba6a9a86bb060332ad56dba38e", error_on_fail = FALSE) %>%
          unlist(recursive = FALSE) %>%
          names() %>%
          print()
      },
      file = "ref_004_get_proof_error_suppressed.txt",
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
        get_proof(hash = "2c5d36be542f8f0e7345d77753a5d7ea61a443ba6a9a86bb060332ad56dba38e")$proof %>%
          as.character() %>%
          cat()
      },
      file = "ref_004_get_proof_correct.txt",
      update = TRUE
    )
  }
)
