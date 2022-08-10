# extract_proof

    Unsopported format. The parameter x needs the extension `.pdf` or `.xml`!

---

    Code
      extract_proof(x = system.file("certificate.Bitcoin.pdf", package = "ROriginStamp"),
      verify = FALSE)
    Warning <simpleWarning>
      
      #############################
       This proof is read from the document as provided.
       It is NOT verified for consistency!
      #############################
    Output
      {xml_document}
      <node type="key" value="5e92ec09501a5d39e251a151f84b5e2228312c445eb23b4e1de6360e27bad54b">
      [1] <left type="mesh" value="7811e3130908fd2678eb2dd3928d245db7f3ed578c21f2ae ...
      [2] <right type="mesh" value="a62eedb07080ce5a21ad26230bcd50ef37cac8cca43a2f1 ...

---

    Code
      extract_proof(x = system.file("certificate.Bitcoin.pdf", package = "ROriginStamp"),
      verify = TRUE)
    Output
      {xml_document}
      <node type="key" value="5e92ec09501a5d39e251a151f84b5e2228312c445eb23b4e1de6360e27bad54b">
      [1] <left type="mesh" value="7811e3130908fd2678eb2dd3928d245db7f3ed578c21f2ae ...
      [2] <right type="mesh" value="a62eedb07080ce5a21ad26230bcd50ef37cac8cca43a2f1 ...

---

    Code
      extract_proof(x = system.file("proof.Bitcoin.xml", package = "ROriginStamp"),
      verify = TRUE)
    Output
      {xml_document}
      <node value="5e92ec09501a5d39e251a151f84b5e2228312c445eb23b4e1de6360e27bad54b" type="key">
      [1] <left value="7811e3130908fd2678eb2dd3928d245db7f3ed578c21f2ae4fbe680424dc ...
      [2] <right value="a62eedb07080ce5a21ad26230bcd50ef37cac8cca43a2f1d946db2d1d47 ...

---

    Code
      extract_proof(x = system.file("proof.Bitcoin.xml", package = "ROriginStamp"),
      verify = TRUE)
    Output
      {xml_document}
      <node value="5e92ec09501a5d39e251a151f84b5e2228312c445eb23b4e1de6360e27bad54b" type="key">
      [1] <left value="7811e3130908fd2678eb2dd3928d245db7f3ed578c21f2ae4fbe680424dc ...
      [2] <right value="a62eedb07080ce5a21ad26230bcd50ef37cac8cca43a2f1d946db2d1d47 ...

