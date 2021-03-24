test_that(
  "txid_from_root_hash",
  {
    expect_snapshot(
      x = txid_from_root_hash( root_hash = as.hash("5e92ec09501a5d39e251a151f84b5e2228312c445eb23b4e1de6360e27bad54b") ),
      cran = TRUE
    )
    expect_snapshot(
      x = txid_from_root_hash( root_hash = as.hash("bf6eec9f213846a53ed187d41d2b9ed2e954649a45d2883e5df6b107b2eb0b75") ),
      cran = TRUE
    )
  }
)
