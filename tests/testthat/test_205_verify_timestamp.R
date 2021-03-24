test_that(
  "verify_timestamp",
  {
    expect_snapshot(
      verify_timestamp(
        x = as.hash("2d3aa25ffe0748bbe780a218028216985497a60cc22c19f7abd128468d567b86")
      ),
      cran = FALSE
    )
    expect_snapshot_error(
      suppressMessages(
        suppressWarnings(
          verify_timestamp(
            x = as.hash("2d3aa25ffe0748bbe780a218028216985497a60cc22c19f7abd128468d567b86"),
            proof = system.file("certificate.Bitcoin.pdf", package = "ROriginStamp")
          )
        )
      ),
      cran = TRUE
    )
    expect_snapshot(
      verify_timestamp(
        x = as.hash("2c5d36be542f8f0e7345d77753a5d7ea61a443ba6a9a86bb060332ad56dba38e")
      ),
      cran = FALSE
    )
    expect_snapshot(
      verify_timestamp(
        x = as.hash("2c5d36be542f8f0e7345d77753a5d7ea61a443ba6a9a86bb060332ad56dba38e"),
        proof = system.file("certificate.Bitcoin.pdf", package = "ROriginStamp")
      ),
      cran = TRUE
    )
  }
)
