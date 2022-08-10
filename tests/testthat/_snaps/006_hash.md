# hash

    x must be of class character!

---

    Each element of x must be a file name of an existing file!

---

    Code
      tf <- tempfile()
      write.csv(data.frame(letters, LETTERS, 1:26), tf)
      x <- list(hash = hash(as.hash(
        "2c5d36be542f8f0e7345d77753a5d7ea61a443ba6a9a86bb060332ad56dba38e")), file = hash(
        tf), file_file = hash_file(tf), LETTERS = as.hash(LETTERS))
      unlink(tf)
      x
    Output
      $hash
      [1] "2c5d36be542f8f0e7345d77753a5d7ea61a443ba6a9a86bb060332ad56dba38e"
      
      $file
      [1] "b1679f608e4c9e55284eb1ee163c7d1255a136ecd12926b4e6ffbf4ce3796801"
      
      $file_file
      [1] "b1679f608e4c9e55284eb1ee163c7d1255a136ecd12926b4e6ffbf4ce3796801"
      
      $LETTERS
       [1] "A" "B" "C" "D" "E" "F" "G" "H" "I" "J" "K" "L" "M" "N" "O" "P" "Q" "R" "S"
      [20] "T" "U" "V" "W" "X" "Y" "Z"
      

