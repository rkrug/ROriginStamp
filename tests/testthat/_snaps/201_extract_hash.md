# extract_hash

    Unsopported format. The parameter x needs the extension `.pdf` or `.xml`!

---

    Code
      extract_hash(x = system.file("certificate.Bitcoin.pdf", package = "ROriginStamp"),
      verify = FALSE)
    Warning <simpleWarning>
      
      #############################
       This proof is read from the document as provided.
       It is NOT verified for consistency!
      #############################
    Output
      [1] "2c5d36be542f8f0e7345d77753a5d7ea61a443ba6a9a86bb060332ad56dba38e"

---

    Code
      extract_hash(x = system.file("certificate.Bitcoin.pdf", package = "ROriginStamp"),
      verify = TRUE)
    Warning <simpleWarning>
      Verification of proof not implemented yet!
    Output
      [1] "2c5d36be542f8f0e7345d77753a5d7ea61a443ba6a9a86bb060332ad56dba38e"

---

    Code
      extract_hash(system.file("proof.Bitcoin.xml", package = "ROriginStamp"),
      verify = TRUE)
    Warning <simpleWarning>
      Verification of proof not implemented yet!
    Output
      [1] "2c5d36be542f8f0e7345d77753a5d7ea61a443ba6a9a86bb060332ad56dba38e"

---

    Code
      extract_hash(system.file("proof.Bitcoin.xml", package = "ROriginStamp"),
      verify = TRUE)
    Warning <simpleWarning>
      Verification of proof not implemented yet!
    Output
      [1] "2c5d36be542f8f0e7345d77753a5d7ea61a443ba6a9a86bb060332ad56dba38e"

