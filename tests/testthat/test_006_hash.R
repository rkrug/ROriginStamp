test_that(
  "hash",
  {
    expect_snapshot(
      x = {
        tf <- tempfile()
        write.csv(data.frame(letters, LETTERS, 1:26), tf)
        x <- list(
          hash     = hash(as.hash("2c5d36be542f8f0e7345d77753a5d7ea61a443ba6a9a86bb060332ad56dba38e")),
          r_object = hash(LETTERS),
          file     = suppressMessages( hash(tf) ),
          null     = hash(NULL)
        )
        unlink(tf)
        x
      },
      cran = TRUE
    )
  }
)
