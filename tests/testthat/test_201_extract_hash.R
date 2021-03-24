test_that(
  "extract_hash",
  {
    expect_snapshot_error(
      extract_proof("ddd"),
      cran = FALSE
    )
    expect_snapshot(
      x = extract_hash(
        x = system.file("certificate.Bitcoin.pdf", package = "ROriginStamp"),
        verify = FALSE
      ),
      cran = TRUE
    )
    expect_snapshot(
      x = extract_hash(
        x = system.file("certificate.Bitcoin.pdf", package = "ROriginStamp"),
        verify = TRUE
      ),
      cran = TRUE
    )
    expect_snapshot(
      x = extract_hash(system.file("proof.Bitcoin.xml", package = "ROriginStamp"),
                       verify = TRUE
      ),
      cran = TRUE
    )
    expect_snapshot(
      x = extract_hash(system.file("proof.Bitcoin.xml", package = "ROriginStamp"),
                       verify = TRUE
      ),
      cran = TRUE
    )
  }
)
