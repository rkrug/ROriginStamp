# txid_from_root_hash

    Code
      x <- transaction_from_txid(txid = "d1d90a5730f0a596dfa4b83e167b02801a74273ffd0cf21e419c3f04ffb3e6df")
      x[[1]]$transaction$confirmations <- NA
      x
    Output
      [[1]]
      [[1]]$success
      [1] TRUE
      
      [[1]]$transaction
      [[1]]$transaction$txid
      [1] "d1d90a5730f0a596dfa4b83e167b02801a74273ffd0cf21e419c3f04ffb3e6df"
      
      [[1]]$transaction$hash
      [1] "d1d90a5730f0a596dfa4b83e167b02801a74273ffd0cf21e419c3f04ffb3e6df"
      
      [[1]]$transaction$block
      [1] 674803
      
      [[1]]$transaction$confirmations
      [1] NA
      
      [[1]]$transaction$version
      [1] "1"
      
      [[1]]$transaction$locktime
      [1] 0
      
      [[1]]$transaction$time
      [1] 1615853224
      
      [[1]]$transaction$first_seen
      [1] 1615852887
      
      [[1]]$transaction$propagation
      NULL
      
      [[1]]$transaction$double_spend
      [1] FALSE
      
      [[1]]$transaction$size
      [1] 266
      
      [[1]]$transaction$vsize
      [1] 266
      
      [[1]]$transaction$input_amount
      [1] "0.04228154"
      
      [[1]]$transaction$input_amount_int
      [1] 4228154
      
      [[1]]$transaction$output_amount
      [1] "0.04201022"
      
      [[1]]$transaction$output_amount_int
      [1] 4201022
      
      [[1]]$transaction$fee
      [1] "0.00027132"
      
      [[1]]$transaction$fee_int
      [1] 27132
      
      [[1]]$transaction$fee_size
      [1] "102.00000000"
      
      [[1]]$transaction$coinbase
      [1] FALSE
      
      [[1]]$transaction$input_count
      [1] 1
      
      [[1]]$transaction$inputs
                                addresses      value value_int
      1 1Stampap27ZbxugEmWPbxNXJxzmYWn2op 0.04228154   4228154
                                                                    txid vout
      1 95aa750d9e365651646497407cad5cecfc9e372fa8e1d699a86f9d1357a18ba2    1
                                                                                                                                                                                                                                                                           script_sig.asm
      1 304402202acfdc5fe6de4971970509e5d24e4c7622cbdd76cb13d85f2e3ecb21ae20de7402201e33ef5f9a0f0278eb22a8f4149096f6dc4c627f3d47ba50c35c51918f95957281 048997ba70cd2005b4e2f21bba96b6fdf8268cd503cb5de2223ee1511780a50936c9403ef6a6e087dad88e88721ad5725938f104e969baff2b4ddac9ab57d2a0c5
                                                                                                                                                                                                                                                                              script_sig.hex
      1 47304402202acfdc5fe6de4971970509e5d24e4c7622cbdd76cb13d85f2e3ecb21ae20de7402201e33ef5f9a0f0278eb22a8f4149096f6dc4c627f3d47ba50c35c51918f9595728141048997ba70cd2005b4e2f21bba96b6fdf8268cd503cb5de2223ee1511780a50936c9403ef6a6e087dad88e88721ad5725938f104e969baff2b4ddac9ab57d2a0c5
              type witness   sequence
      1 pubkeyhash    NULL 4294967295
      
      [[1]]$transaction$output_count
      [1] 2
      
      [[1]]$transaction$outputs
                                addresses      value value_int n
      1                                   0.00000000         0 0
      2 1Stampap27ZbxugEmWPbxNXJxzmYWn2op 0.04201022   4201022 1
                                                                           script_pub_key.asm
      1            OP_RETURN bf6eec9f213846a53ed187d41d2b9ed2e954649a45d2883e5df6b107b2eb0b75
      2 OP_DUP OP_HASH160 04e575307e92a334979d5198cda84d974b3ab20b OP_EQUALVERIFY OP_CHECKSIG
                                                          script_pub_key.hex req_sigs
      1 6a20bf6eec9f213846a53ed187d41d2b9ed2e954649a45d2883e5df6b107b2eb0b75        0
      2                   76a91404e575307e92a334979d5198cda84d974b3ab20b88ac        1
              type                                                       spend_txid
      1   nulldata                                                             <NA>
      2 pubkeyhash 5222827cad650b0b4a4537255152429ae60c69fa74cee3d023644c13e5b1344b
      
      [[1]]$transaction$tx_index
      [1] 625893340
      
      [[1]]$transaction$block_index
      [1] 765
      
      
      

---

    Code
      x <- transaction_from_txid(txid = "aed3db9ef94953f65e93d56a4e5bcf234d43e27a1b3e7ce0f274cc7ed750d0e2")
      x[[1]]$transaction$confirmations <- NA
      x
    Output
      [[1]]
      [[1]]$success
      [1] TRUE
      
      [[1]]$transaction
      [[1]]$transaction$txid
      [1] "aed3db9ef94953f65e93d56a4e5bcf234d43e27a1b3e7ce0f274cc7ed750d0e2"
      
      [[1]]$transaction$hash
      [1] "aed3db9ef94953f65e93d56a4e5bcf234d43e27a1b3e7ce0f274cc7ed750d0e2"
      
      [[1]]$transaction$block
      [1] 548512
      
      [[1]]$transaction$confirmations
      [1] NA
      
      [[1]]$transaction$version
      [1] "1"
      
      [[1]]$transaction$locktime
      [1] 0
      
      [[1]]$transaction$time
      [1] 1541203656
      
      [[1]]$transaction$first_seen
      [1] 1541203325
      
      [[1]]$transaction$propagation
      NULL
      
      [[1]]$transaction$double_spend
      [1] FALSE
      
      [[1]]$transaction$size
      [1] 257
      
      [[1]]$transaction$vsize
      [1] 257
      
      [[1]]$transaction$input_amount
      [1] "0.01192993"
      
      [[1]]$transaction$input_amount_int
      [1] 1192993
      
      [[1]]$transaction$output_amount
      [1] "0.01191451"
      
      [[1]]$transaction$output_amount_int
      [1] 1191451
      
      [[1]]$transaction$fee
      [1] "0.00001542"
      
      [[1]]$transaction$fee_int
      [1] 1542
      
      [[1]]$transaction$fee_size
      [1] "6.00000000"
      
      [[1]]$transaction$coinbase
      [1] FALSE
      
      [[1]]$transaction$input_count
      [1] 1
      
      [[1]]$transaction$inputs
                                addresses      value value_int
      1 1Stampap27ZbxugEmWPbxNXJxzmYWn2op 0.01192993   1192993
                                                                    txid vout
      1 a84870aff4032cff0a813ad8926dc381bfa7635fabdcb6c2aff83a2e42e61063    1
                                                                                                                                                                                                                                                                           script_sig.asm
      1 304402206f80ab6c279b0234887d660be3daca4e4117e260e1618fd90c15784046729f8802205c07b74ef436bbdc66c7714bd891e55a50f26284efce14585c23038a235a4ef381 048997ba70cd2005b4e2f21bba96b6fdf8268cd503cb5de2223ee1511780a50936c9403ef6a6e087dad88e88721ad5725938f104e969baff2b4ddac9ab57d2a0c5
                                                                                                                                                                                                                                                                              script_sig.hex
      1 47304402206f80ab6c279b0234887d660be3daca4e4117e260e1618fd90c15784046729f8802205c07b74ef436bbdc66c7714bd891e55a50f26284efce14585c23038a235a4ef38141048997ba70cd2005b4e2f21bba96b6fdf8268cd503cb5de2223ee1511780a50936c9403ef6a6e087dad88e88721ad5725938f104e969baff2b4ddac9ab57d2a0c5
              type witness   sequence
      1 pubkeyhash    NULL 4294967295
      
      [[1]]$transaction$output_count
      [1] 2
      
      [[1]]$transaction$outputs
                                 addresses      value value_int n
      1 1C6R4qvje8SWSyceGGqusPcr6vpaRA59f2 0.00000550       550 0
      2  1Stampap27ZbxugEmWPbxNXJxzmYWn2op 0.01190901   1190901 1
                                                                           script_pub_key.asm
      1 OP_DUP OP_HASH160 79af8d8d72529ac601b02480c0a89b473abdaa60 OP_EQUALVERIFY OP_CHECKSIG
      2 OP_DUP OP_HASH160 04e575307e92a334979d5198cda84d974b3ab20b OP_EQUALVERIFY OP_CHECKSIG
                                        script_pub_key.hex req_sigs       type
      1 76a91479af8d8d72529ac601b02480c0a89b473abdaa6088ac        1 pubkeyhash
      2 76a91404e575307e92a334979d5198cda84d974b3ab20b88ac        1 pubkeyhash
                                                              spend_txid
      1 9c5373ba6ffaa64836462f9179286c7c4dc289dadebf5ad3524e7483d6673a8a
      2 7052c357e4ffc22596784dba3c1a4a2b3afb9790f5d79ace993e4be95f25bfd3
      
      [[1]]$transaction$tx_index
      [1] 353584384
      
      [[1]]$transaction$block_index
      [1] 615
      
      
      

---

    Code
      x <- transaction_from_txid(txid = "Oha")
      x[[1]]$transaction$confirmations <- NA
      x
    Output
      [[1]]
      [[1]]$success
      [1] FALSE
      
      [[1]]$error
      [[1]]$error$code
      [1] "REQ_ERROR"
      
      [[1]]$error$message
      [1] "Oha is an invalid transaction."
      
      
      [[1]]$transaction
      [[1]]$transaction$confirmations
      [1] NA
      
      
      

