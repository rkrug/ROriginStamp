# extract_root_hash

    Unsopported format. The parameter x needs the extension `.pdf` or `.xml`!

---

    Code
      extract_root_hash(system.file("certificate.Bitcoin.pdf", package = "ROriginStamp"),
      verify = FALSE)
    Warning <simpleWarning>
      
      #############################
       This proof is read from the document as provided.
       It is NOT verified for consistency!
      #############################
    Output
      [1] "5e92ec09501a5d39e251a151f84b5e2228312c445eb23b4e1de6360e27bad54b"

---

    Code
      extract_root_hash(system.file("certificate.Bitcoin.pdf", package = "ROriginStamp"),
      verify = TRUE)
    Warning <simpleWarning>
      Verification of proof not implemented yet!
    Output
      [1] "5e92ec09501a5d39e251a151f84b5e2228312c445eb23b4e1de6360e27bad54b"

---

    Code
      extract_root_hash(system.file("proof.Bitcoin.xml", package = "ROriginStamp"),
      verify = TRUE)
    Warning <simpleWarning>
      Verification of proof not implemented yet!
    Output
      [1] "5e92ec09501a5d39e251a151f84b5e2228312c445eb23b4e1de6360e27bad54b"

---

    Code
      extract_root_hash(system.file("proof.Bitcoin.xml", package = "ROriginStamp"),
      verify = TRUE)
    Warning <simpleWarning>
      Verification of proof not implemented yet!
    Output
      [1] "5e92ec09501a5d39e251a151f84b5e2228312c445eb23b4e1de6360e27bad54b"

