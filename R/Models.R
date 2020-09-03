
Default <- R6::R6Class(
  "Default",
  list(
    description = function() {
      cat(
        "
 	   The default service response object uses error code and message to indicate errors. These errors are handled by the client.

		data	{...}

		error_code	integer($int32)
		Contains the error of the request. If the error code is 0, everything is fine.

		error_message	string
		Contains the error message, that possibly occurred. If it is empty, everything is fine.
 	   "
      )
    },
    data = list(),
    error_code = integer(0),
    error_message	= character(0)
  )
)

TimestampResponse <- R6::R6Class(
  "TimestampResponse",
  list(
    description = function() {
      cat(
        "
  		  Response object for the timestamp response. Create, Status and Webhookshare the same object. This saves customers additional implementation work, as the requests or data only have to be understood once.The difference is that the webhook is only triggered as soon as a tamper-proof timestamp exists.

		comment	string
		The comment which was added in the submission of the hash.

		created	boolean
		Field is set to true if it is a novel hash.If the flag is false, the hash was already submitted before.

		date_created	integer($int64)
		The time when your hash was submitted to OriginStamp. The date is returned in the following format: [ms] since 1.1.1970 (unix epoch), timezone: UTC. This is not considered as a true timestamp.

		hash_string	string
		The submitted hash in hex representation.
		timestamps	[...]
    "
      )
    },
    comment = character(0),
    created = logical(0),
    date_created = integer(0),
    hash_string = character(0),
    timestamps = list()
  )
)

DefaultOfTimestampResponse <- R6::R6Class(
  "DefaultOfTimestampResponse",
  list(
    description = function() {
      cat(
        "
		The default service response object uses error code and message to indicate errors. These errors are handled by the client.

		data	TimestampResponse{...}

		error_code	integer($int32)
		Contains the error of the request. If the error code is 0, everything is fine.

		error_message	string
		Contains the error message, that possibly occurred. If it is empty, everything is fine.
	    "
      )
    },
    data = TimestampResponse$new(),
    error_code = integer(0),
    error_message = character(0),
    get = function( hash ) {
      # Assemble URL ------------------------------------------------------------

      url <- paste(api_url(), "timestamp", hash, sep = "/")
      url <- gsub("//", "/", url)
      url <- gsub(":/", "://", url)

      # GET request -------------------------------------------------------------

      response <- httr::GET(
        url = url,
        ## -H
        config = httr::add_headers(
          accept = "application/json",
          Authorization = api_key()
        )
      )

      httr::stop_for_status(response)

      # Process return value ----------------------------------------------------

      try(
        {
          content <- extractContent( response )
        },
        silent = TRUE
      )

      # Put into self -----------------------------------------------------------

      self$error_code <- content$error_code
      self$error_message <- content$error_message
      ##
      self$data$comment <- content$data$remaining_credits
      self$data$created <- content$data$created
      self$data$date_created <- content$data$date_created
      self$data$hash_string <- content$data$hash_string
      self$data$timestamps <- lapply(
        content$data$timestamps,
        function(ts) {
          x <- TimestampData$new()
          x$transaction <- ts$transaction
          x$private_key <- ts$private_key
          x$timestamp <- ts$timestamp
          x$submit_status <- ts$submit_status
          return(x)
        }
      )

      # Check if error  ---------------------------------------------------------

      if (self$error_code != 0) {
        stop(
          sprintf(
            "OriginStamp API request failed [%s]\n%s\n\n<%s>",
            self$error_code,
            self$error_message,
            "see https://api.originstamp.com/swagger/swagger-ui.html#/proof/getHashStatus for details"
          )
        )
      }

      # Return self -------------------------------------------------------------

      invisible( self )
    },
    post = function() {

      # Assemble URL ------------------------------------------------------------

      url <- paste(api_url(), "timestamp", "create", sep= "/")
      url <- gsub("//", "/", url)
      url <- gsub(":/", "://", url)

      # Assemble body -----------------------------------------------------------

      notifications <- lapply(
        y,
        function(x) {
          x$as_data_frame()
        }
      )
      do.call("rbind", notifications)

      request_body_json <- as.character(
        jsonlite::toJSON(
          list(
            comment = comment,
            hash = hash,
            notifications = notifications
          ),
          auto_unbox = TRUE
        )
      )

      request_body_json <- gsub("\\{\\}", "null", request_body_json)

      # POST request ------------------------------------------------------------

      response <- httr::POST(
        url = url,
        ## -H
        config = httr::add_headers(
          accept = "application/json",
          Authorization = api_key(),
          'Content-Type' = "application/json",
          # body = "request_body_json",
          'user-agent' = "libcurl/7.64.1 r-curl/4.3 httr/1.4.2 ROriginStamp"
        ),
        ## -d
        body = request_body_json #,
        # httr::verbose(data_out = TRUE, data_in = TRUE, info = TRUE)
      )
      httr::stop_for_status(response)

      # Process return value ----------------------------------------------------

      try(
        {
          content <- extractContent( response )
        },
        silent = TRUE
      )

      # Put into self -----------------------------------------------------------

      self$error_code <- content$error_code
      self$error_message <- content$error_message
      ##
      self$data$comment <- content$data$remaining_credits
      self$data$created <- content$data$created
      self$data$date_created <- content$data$date_created
      self$data$hash_string <- content$data$hash_string
      self$data$timestamps <- lapply(
        content$data$timestamps,
        function(ts) {
          x <- TimestampData$new()
          x$transaction <- ts$transaction
          x$private_key <- ts$private_key
          x$timestamp <- ts$timestamp
          x$submit_status <- ts$submit_status
          return(x)
        }
      )

      # Check if error  ---------------------------------------------------------

      if (self$error_code != 0) {
        stop(
          sprintf(
            "OriginStamp API request failed [%s]\n%s\n\n<%s>",
            self$error_code,
            self$error_message,
            "see https://api.originstamp.com/swagger/swagger-ui.html#/proof/createTimestamp for details"
          )
        )
      }

      ##
      return(result)
    }
  )
)



DefaultOfstring <- R6::R6Class(
  "DefaultOfstring",
  list(
    description = function() {
      cat(
        "
 	   The default service response object uses error code and message to indicate errors. These errors are handled by the client.

		data	string
		Generic response object which contains the response data, e.g. timestamp information.

		error_code	integer($int32)
		Contains the error of the request. If the error code is 0, everything is fine.

		error_message	string
		Contains the error message, that possibly occurred. If it is empty, everything is fine.
  	  "
      )
    },
    data = character(0),
    error_code = integer(0),
    error_message = character(0)
  )
)


Notification <- R6::R6Class(
  "Notification",
  list(
    description = function() {
      cat(
        "
		DTO object for notifications.

		currency*	integer($int32)
		example: 0
		0: Bitcoin

		notification_type*	integer($int32)
		example: 0
		0: notify via email
		1: notify a webhook

		target*	string
		example: originstamp@trashmail.com
		Depending on the notification type, specify the target for the notification (e.g. mail address or webhook URL). The webhook URL will receive a POST request after timestamp was successfully created.
   		"
      )
    },
    currency = integer(0),
    notification_type = integer(0),
    target = character(0),
    initialize = function( email, webhook, currency = 0 ) {
      if ( !missing(email) & !missing(webhook) ) {
        stop("Either `email` or `webhook` must be specified or none!")
      }
      if (!missing(email)) {
        self$notification_type <- 0
        self$target <- email
        invisible( self )
      }
      if (!missing(webhook)) {
        self$notification_type <- 1
        self$target <- url
      }
      if (!(currency %in% c(0, 1, 2, 100))) {
        stop("Non valid currency value. Check `Notification$new()$description()`!")
      }
      self$currency <- currency
    },
    as_data_frame = function() {
      df <- data.frame(
        currency = self$currency,
        notification_type = self$notification_type,
        target = self$target
      )
      return(df)
    }
  )
)

ProofRequest <- R6::R6Class(
  "ProofRequest",
  list(
    description = function() {
      cat(
        "
		Request object for proof request.

		currency*	integer($int32)
		0: Bitcoin
		1: Ethereum
		2: AION
		100: Südkurier

		hash_string*	string
		example: 2c5d36be542f8f0e7345d77753a5d7ea61a443ba6a9a86bb060332ad56dba38e
		Hash in HEX representation for which the proof should be created. We allow the use of SHA-256. Note: We handle the hashes in lower-case.

		proof_type*	integer($int32)
		example: 0
		Specifies which type of file should be returned. Possible value(s):
		0: proof with a seed file (txt) or proof with a merkle tree (xml)
		1: proof with a PDF file

		Other formats will follow.
    	"
      )
    },
    currency = integer(0),
    hash_string = character(0),
    proof_type = integer(0),
    initialize = function ( currency, hash_string, proof_type ){
      if (!missing(currency)) {
        if ( !(currency %in% c(0, 1, 2, 100)) ) {
          stop("`currency` is not valid. Please see `ProofRequest$new()$description()` for valid values!")
        }
        self$currency <- currency
      }
      if (!missing(proof_type)) {
        if ( !(proof_type %in% c(0, 1)) ) {
          stop("`proof_type` is not valid. Please see `ProofRequest$new()$description()` for valid values!")
        }
        self$proof_type <- proof_type
      }
      if (!missing(hash_string)) {
        self$hash_string <- hash_string
      }
    }
  )
)


TimestampData <- R6::R6Class(
  "TimestampData",
  list(
    description = function() {
      cat(
        "
   		DTO for the timestamp data.

		currency_id	integer($int32)
		0: Bitcoin

		private_key	string
		The private key represents the top hash in the Merkle Tree (see https://en.wikipedia.org/wiki/Merkle_tree ) or the hash of all hashes in the transaction.

		submit_status	integer($int64)
		The submit status of the hash:
		0: the hash was not broadcasted yet
		1: the hash was included into a transaction and broadcasted to the network, but not included into a block
		2: the transaction was included into the latest block
		3: the timestamp for your hash was successfully created.

		timestamp	integer($int64)
		The date is returned in the following format: [ms] since 1.1.1970 (unix epoch), timezone: UTC. This is a true timestamp.

		transaction	string
		If available: the transaction hash of the timestamp.
    "
      )
    },
    currency_id = integer(0),
    private_key = character(0),
    submit_status	= integer(0),
    timestamp	= integer(0),
    transaction	= character(0)
  )
)

TimestampRequest <- R6::R6Class(
  "TimestampRequest",
  list(
    description = function() {
      cat(
        "
 	   Request object for a timestamp request.

		comment	string
		example: test
		You can add a short comment (max. 256 characters) which can be used for indexing and searching (public).

		hash*	string
		example: 2c5d36be542f8f0e7345d77753a5d7ea61a443ba6a9a86bb060332ad56dba38e
		Hash in HEX representation. We suggest to use SHA-256. This hash will be aggregated and included into the blockchain.

		notifications	[...]

		url	string
		Preprint URL. Insert the generated UUID here. You can generate an UUID-4 and include it into your document: https://originstamp.org/u/uuid4. When submitting the your file, the URL is part of the hash, which finally means it the link to the timestamp is part of the timestamp.
    "
      )
    },
    comment = character(0),
    hash = character(0),
    notifications = list(),
    url = character(0),
    initialize = function( comment, hash, notifications, url) {
      if (!missing(comment)) {
        self$comment <- comment
      }
      if (!missing(hash)) {
        self$hash <- hash
      }
      if (!missing(url)) {
        self$url <- url
      }
      if (!missing(notifications)) {
        if (is(notifications, "Notification")) {
          self$notifications <- list(notifications)
        } else if (is(notifications, "list")) {
          cn <- sapply(
            notifications,
            function(x) {
              is(x, "Notification")
            }
          )
          if (!all(cn)) {
            stop("`notificatios` has to be either a `Notification` class or a list with only `Notification` elements!")
          }
          self$notifications <- notifications
        }
      }
    }
  )
)









