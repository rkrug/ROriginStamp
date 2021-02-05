test_that(
  "error",
  {
    expect_error(
      object = {
        api_key("none")
        get_key_usage()
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
        get_key_usage(error_on_fail = FALSE) %>%
          unlist(recursive = FALSE) %>%
          names() %>%
          print()
      },
      file = "ref_003_get_key_usage_error_suppressed.txt",
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
        get_key_usage() %>%
          unlist(recursive = FALSE) %>%
          names() %>%
          print()
      },
      file = "ref_003_get_key_usage_correct.txt",
      update = TRUE
    )
  }
)
