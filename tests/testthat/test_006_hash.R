test_that(
  "hash",
  {
    expect_snapshot_value(
      x = {
        tf <- tempfile()
        write.csv(data.frame(letters, LETTERS, 1:26), tf)
        x <- list(
          hash     = hash( structure("2c5d36be542f8f0e7345d77753a5d7ea61a443ba6a9a86bb060332ad56dba38e", class = c("hash")) ),
          r_object = hash( LETTERS ),
          file     = hash( tf ),
          null     = hash( NULL )
        )
        unlink(tf)
        x
      },
      style = "serialize",
      cran = TRUE
    )
  }
)
