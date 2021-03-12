test_that(
  "test api_key()",
  {
    expect_snapshot_value(
      x = {
        Sys.setenv(ROriginStamp_api_key_bak = Sys.getenv("ROriginStamp_api_key"))
        Sys.setenv(ROriginStamp_api_key = "My_secret_key")
        x <- list(
          api_key("dadada"),
          api_key(),
          api_key(""),
          api_key()
        )
        Sys.setenv(ROriginStamp_api_key = Sys.getenv("ROriginStamp_api_key_bak"))
        x
      },
      cran = TRUE
    )
  }
)

test_that(
  "test api_url()",
  {
    expect_snapshot_value(
      x = {
        list(
          api_url(),
          api_url("https://test.t"),
          api_url(),
          api_url(""),
          api_url(),
          api_url("https://api.originstamp.com/v3"),
          api_url()
        )
      },
      cran = TRUE
    )
  }
)
