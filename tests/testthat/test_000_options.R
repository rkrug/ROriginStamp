context("000 api_key")

api_key("none")

test_that(
  "returned api key is equal to the one set",
  {
    expect_equal(
      object = api_key(),
      expected = "none"
    )
  }
)

api_key("")

test_that(
  "returned api key is equal to the one in the system environment",
  {
    expect_equal(
      object = api_key(),
      expected = Sys.getenv("ORIGINSTAMP_API_KEY")
    )
  }
)


context("000 api_url")

test_that(
  "returned api key is equal to the original one",
  {
    expect_equal(
      object = api_url(),
      expected = "https://api.originstamp.com/v3"
    )
  }
)

old_url <- api_url("Some rubbish")

test_that(
  "returned api key is equal to the one set",
  {
    expect_equal(
      object = api_url(),
      expected = "Some rubbish"
    )
  }
)

api_url(old_url)
