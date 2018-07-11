context("options")
library(ROriginStamp)

test_that(
  "check get_option",
  {
    expect_equal( object = get_option( name = "os_url" ), expected = "https://api.originstamp.org/api/")
    expect_equal( object = get_option( name = "api_key" ), expected = "51996e47-1260-4c6b-b8ad-bdccdd320a64")
    expect_error( object = get_option( name = "DoesNotExist" ) )
  }
)

test_that(
  "check set_option",
  {
    expect_null( object = set_option( name = "newoption", "First Value" ))
    expect_equal( object = set_option( name = "newoption", "Second Value" ), expected = "First Value")
    expect_equal( object = get_option( name = "newoption" ), expected = "Second Value")
  }
)

test_that(
  "check option_exists",
  {
    expect_true( object = exists_option( name = "os_url" ) )
    expect_false( object = exists_option( name = "Does Not Exist" ) )
  }
)

