test_that(
  "txid_from_root_hash",
  {
    expect_snapshot(
      {
        x <-  transaction_from_txid(
          txid = "d1d90a5730f0a596dfa4b83e167b02801a74273ffd0cf21e419c3f04ffb3e6df"
        )
        x[[1]]$transaction$confirmations <- NA
        x
      },
      cran = TRUE
    )
    expect_snapshot(
      {
        x  <-  transaction_from_txid(
          txid = "aed3db9ef94953f65e93d56a4e5bcf234d43e27a1b3e7ce0f274cc7ed750d0e2"
        )
        x[[1]]$transaction$confirmations <- NA
        x
      },
      cran = TRUE
    )
    expect_snapshot(
      {
        x  <-  transaction_from_txid(
          txid = "Oha"
        )
        x[[1]]$transaction$confirmations <- NA
        x
      },
      cran = TRUE
    )
  }
)
