context("003 get proof")

api_key("none")

test_that(
  "result is as expected",
  {
    expect_error(
      object = get_proof(hash = "2c5d36be542f8f0e7345d77753a5d7ea61a443ba6a9a86bb060332ad56dba38e"),
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
      object = get_proof(hash = "2c5d36be542f8f0e7345d77753a5d7ea61a443ba6a9a86bb060332ad56dba38e")$proof,
      file = "ref_003_get_proof.rda",
      update = TRUE
    )
  }
)
