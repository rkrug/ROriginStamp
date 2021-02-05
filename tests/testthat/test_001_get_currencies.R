test_that(
  "result is as expected",
  {
    expect_error(
      object = {
        api_key("none")
        get_currencies()
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
        get_currencies(error_on_fail = FALSE) %>%
          unlist(recursive = FALSE) %>%
          names() %>%
          print()
      },
      file = "ref_001_get_currencies_error_suppressed.txt",
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
        get_currencies(error_on_fail = FALSE) %>%
          unlist(recursive = FALSE) %>%
          names() %>%
          print()
      },
      file = "ref_001_get_currencies_correct.txt",
      update = TRUE
    )
  }
)
