test_that(
  "result is as expected",
  {
    expect_snapshot_output(
      x = {
        new_OriginStampResponse() %>%
          print()
      },
      cran = FALSE
    )
  }
)
