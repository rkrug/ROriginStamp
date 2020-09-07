context("002 get hash status")

api_key("none")

test_that(
  "result is as expected",
  {
    expect_error(
      object = get_hash_status(hash = "2c5d36be542f8f0e7345d77753a5d7ea61a443ba6a9a86bb060332ad56dba38e"),
      regexp = "OriginStamp API request failed [3201]*."
    )
  }
)

api_key("")

test_that(
  "result is as expected",
  {
    expect_known_value(
      object = get_hash_status(hash = "2c5d36be542f8f0e7345d77753a5d7ea61a443ba6a9a86bb060332ad56dba38e")$content,
      file = "ref_002_get_hash_status.rda",
      update = TRUE
    )
  }
)
