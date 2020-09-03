context("001 create timestamp")

api_key("none")

test_that(
  "result is as expected",
  {
    expect_error(
      object = create_timestamp(hash = "2c5d36be542f8f0e7345d77753a5d7ea61a443ba6a9a86bb060332ad56dba38e"),
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
    expect_known_value(
      object = create_timestamp(hash = "2c5d36be542f8f0e7345d77753a5d7ea61a443ba6a9a86bb060332ad56dba38e")$content,
      file = "ref_001_create_timestamp.rda",
      update = TRUE
    )
  }
)
