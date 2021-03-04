# hash

    Code
      tf <- tempfile()
    Code
      write.csv(data.frame(letters, LETTERS, 1:26), tf)
    Code
      x <- list(hash = hash(as.hash(
        "2c5d36be542f8f0e7345d77753a5d7ea61a443ba6a9a86bb060332ad56dba38e")),
      r_object = hash(LETTERS), file = suppressMessages(hash(tf)), null = hash(NULL))
    Message <simpleMessage>
      
      x is already a hash - returning x unprocessed
    Message <simpleMessage>
      
      Create sha356 hash from R object x
    Message <simpleMessage>
      
      Create sha356 hash from R object x
    Code
      unlink(tf)
    Code
      x
    Output
      $hash
      [1] "2c5d36be542f8f0e7345d77753a5d7ea61a443ba6a9a86bb060332ad56dba38e"
      
      $r_object
      sha256 7c:56:03:3c:f6:d9:c9:6b:35:3e:5e:40:52:2a:e2:0f:4d:71:73:ef:46:16:45:8f:23:11:aa:0c:ff:ca:a8:a0 
      
      $file
      sha256 b1:67:9f:60:8e:4c:9e:55:28:4e:b1:ee:16:3c:7d:12:55:a1:36:ec:d1:29:26:b4:e6:ff:bf:4c:e3:79:68:01 
      
      $null
      sha256 33:3c:5a:2b:e6:a6:f6:ef:48:30:02:21:b6:46:c8:4d:c3:a9:1d:88:05:c9:23:0c:23:5d:34:97:8b:1f:96:6d 
      

