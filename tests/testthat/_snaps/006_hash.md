# hash

    x must be of class character!

---

    Code
      tf <- tempfile()
      write.csv(data.frame(letters, LETTERS, 1:26), tf)
      x <- list(hash = hash(as.hash(
        "2c5d36be542f8f0e7345d77753a5d7ea61a443ba6a9a86bb060332ad56dba38e")),
      r_object = hash(LETTERS), file = hash(tf), file_file = hash.file(tf), LETTERS = as.hash(
        LETTERS))
    Message <simpleMessage>
      Create sha356 hash from character vector x
    Code
      unlink(tf)
      x
    Output
      $hash
      [1] "2c5d36be542f8f0e7345d77753a5d7ea61a443ba6a9a86bb060332ad56dba38e"
      
      $r_object
       [1] "559aead08264d5795d3909718cdd05abd49572e84fe55590eef31a88a08fdffd"
       [2] "df7e70e5021544f4834bbee64a9e3789febc4be81470df629cad6ddb03320a5c"
       [3] "6b23c0d5f35d1b11f9b683f0b0a617355deb11277d91ae091d399c655b87940d"
       [4] "3f39d5c348e5b79d06e842c114e6cc571583bbf44e4b0ebfda1a01ec05745d43"
       [5] "a9f51566bd6705f7ea6ad54bb9deb449f795582d6529a0e22207b8981233ec58"
       [6] "f67ab10ad4e4c53121b6a5fe4da9c10ddee905b978d3788d2723d7bfacbe28a9"
       [7] "333e0a1e27815d0ceee55c473fe3dc93d56c63e3bee2b3b4aee8eed6d70191a3"
       [8] "44bd7ae60f478fae1061e11a7739f4b94d1daf917982d33b6fc8a01a63f89c21"
       [9] "a83dd0ccbffe39d071cc317ddf6e97f5c6b1c87af91919271f9fa140b0508c6c"
      [10] "6da43b944e494e885e69af021f93c6d9331c78aa228084711429160a5bbd15b5"
      [11] "86be9a55762d316a3026c2836d044f5fc76e34da10e1b45feee5f18be7edb177"
      [12] "72dfcfb0c470ac255cde83fb8fe38de8a128188e03ea5ba5b2a93adbea1062fa"
      [13] "08f271887ce94707da822d5263bae19d5519cb3614e0daedc4c7ce5dab7473f1"
      [14] "8ce86a6ae65d3692e7305e2c58ac62eebd97d3d943e093f577da25c36988246b"
      [15] "c4694f2e93d5c4e7d51f9c5deb75e6cc8be5e1114178c6a45b6fc2c566a0aa8c"
      [16] "5c62e091b8c0565f1bafad0dad5934276143ae2ccef7a5381e8ada5b1a8d26d2"
      [17] "4ae81572f06e1b88fd5ced7a1a000945432e83e1551e6f721ee9c00b8cc33260"
      [18] "8c2574892063f995fdf756bce07f46c1a5193e54cd52837ed91e32008ccf41ac"
      [19] "8de0b3c47f112c59745f717a626932264c422a7563954872e237b223af4ad643"
      [20] "e632b7095b0bf32c260fa4c539e9fd7b852d0de454e9be26f24d0d6f91d069d3"
      [21] "a25513c7e0f6eaa80a3337ee18081b9e2ed09e00af8531c8f7bb2542764027e7"
      [22] "de5a6f78116eca62d7fc5ce159d23ae6b889b365a1739ad2cf36f925a140d0cc"
      [23] "fcb5f40df9be6bae66c1d77a6c15968866a9e6cbd7314ca432b019d17392f6f4"
      [24] "4b68ab3847feda7d6c62c1fbcbeebfa35eab7351ed5e78f4ddadea5df64b8015"
      [25] "18f5384d58bcb1bba0bcd9e6a6781d1a6ac2cc280c330ecbab6cb7931b721552"
      [26] "bbeebd879e1dff6918546dc0c179fdde505f2a21591c9a9c96e36b054ec5af83"
      
      $file
      [1] "b1679f608e4c9e55284eb1ee163c7d1255a136ecd12926b4e6ffbf4ce3796801"
      
      $file_file
      [1] "b1679f608e4c9e55284eb1ee163c7d1255a136ecd12926b4e6ffbf4ce3796801"
      
      $LETTERS
       [1] "A" "B" "C" "D" "E" "F" "G" "H" "I" "J" "K" "L" "M" "N" "O" "P" "Q" "R" "S"
      [20] "T" "U" "V" "W" "X" "Y" "Z"
      

