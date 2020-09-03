context("004 get key usage")

api_key("none")

test_that(
  "result is as expected",
  {
    expect_error(
      object = get_key_usage(),
      regexp = "OriginStamp API request failed [3201]*."
    )
  }
)


api_key(
  Sys.getenv("api_key")
)

test_that(
  "result is as expected",
  {
    expect_equal(
      object = get_key_usage()$content$error_code,
      expected = 0
    )
  }
)
