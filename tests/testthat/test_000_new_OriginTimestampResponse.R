test_that(
  "result is as expected",
  {
    expect_known_output(
      object = {
        new_OriginStampResponse() %>%
          print()
      },
      file = "ref_000_new_OriginStampResponse.txt",
      update = TRUE
    )
  }
)
