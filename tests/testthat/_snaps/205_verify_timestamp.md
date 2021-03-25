# verify_timestamp

    Code
      verify_timestamp(x = as.hash(
        "2d3aa25ffe0748bbe780a218028216985497a60cc22c19f7abd128468d567b86"))
    Message <simpleMessage>
      
      x is already a hash - returning x unprocessed
    Output
        currency_id
      1           0
      2           1
      3           2
      4         100
                                                               transaction
      1   d1d90a5730f0a596dfa4b83e167b02801a74273ffd0cf21e419c3f04ffb3e6df
      2 0xc39b3a4634096675a0ea81089ab20df911e2aace026ae2d1c69f1f7091ee68ab
      3   ce49d2fde8f1c05a195fa6b1f3c82e0bfe9a2771c998278a900c503758ebfd6f
      4                                                         2021-03-16
                                                             private_key
      1 bf6eec9f213846a53ed187d41d2b9ed2e954649a45d2883e5df6b107b2eb0b75
      2 13d10912a2f7f372a4a7484bc7a6f8135a603d93974ea14c025070126786427b
      3 0c235a2bf6e5dbaeba161c1dd6f2d34972ed57dbd9ee32b63191eaf60e16ef30
      4 efdf27717a25f33b5da28c79c5a06024992e8b5a40c0d58a6a1f37fd25b6ac47
                  timestamp submit_status
      1 2021-03-16 01:07:04             3
      2 2021-03-15 08:59:14             3
      3 2021-03-15 08:40:10             3
      4 2021-03-16 03:00:00             3

---

    The `hash` does not match the `proof`.
    Please profide matching `hash` and `proof`!

---

    Code
      verify_timestamp(x = as.hash(
        "2c5d36be542f8f0e7345d77753a5d7ea61a443ba6a9a86bb060332ad56dba38e"))
    Message <simpleMessage>
      
      x is already a hash - returning x unprocessed
    Output
        currency_id                                                      transaction
      1           0 aed3db9ef94953f65e93d56a4e5bcf234d43e27a1b3e7ce0f274cc7ed750d0e2
                                                             private_key
      1 5e92ec09501a5d39e251a151f84b5e2228312c445eb23b4e1de6360e27bad54b
                  timestamp submit_status
      1 2018-11-03 01:07:36             3

---

    Code
      verify_timestamp(x = as.hash(
        "2c5d36be542f8f0e7345d77753a5d7ea61a443ba6a9a86bb060332ad56dba38e"), proof = system.file(
        "certificate.Bitcoin.pdf", package = "ROriginStamp"))
    Message <simpleMessage>
      
      x is already a hash - returning x unprocessed
    Output
      [1] currency_id transaction timestamp  
      <0 rows> (or 0-length row.names)

