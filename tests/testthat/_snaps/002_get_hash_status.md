# error suppressed

    $status
    [1] 200
    
    $content
    $content$error_code
    [1] 3201
    
    $content$error_message
    [1] 1
    
    $content$data
    NULL
    
    
    $headers
    [1] NA
    
    attr(,"class")
    [1] "OriginStampResponse"

# correct

    $status
    [1] 200
    
    $content
    $content$error_code
    [1] 0
    
    $content$error_message
    NULL
    
    $content$data
    $content$data$created
    [1] FALSE
    
    $content$data$date_created
    [1] 1.541203e+12
    
    $content$data$comment
    [1] "test"
    
    $content$data$hash_string
    [1] "2c5d36be542f8f0e7345d77753a5d7ea61a443ba6a9a86bb060332ad56dba38e"
    
    $content$data$timestamps
      currency_id                                                      transaction
    1           0 aed3db9ef94953f65e93d56a4e5bcf234d43e27a1b3e7ce0f274cc7ed750d0e2
                                                           private_key    timestamp
    1 5e92ec09501a5d39e251a151f84b5e2228312c445eb23b4e1de6360e27bad54b 1.541204e+12
      submit_status
    1             3
    
    
    
    $headers
    [1] NA
    
    attr(,"class")
    [1] "OriginStampResponse"

