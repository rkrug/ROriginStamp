WebhookResponse <- R6::R6Class(
  "WebhookResponse",
  list(
    description = function() {
      cat(
        "
		Response object for a webhook request. Contains only the most recent webhook information for target URL, hash and currency.

		currency	integer($int32)
		Currency for which the webhook is triggered, e.g.
		0: Bitcoin
		1: Ethereum

		executed	boolean
		Shows if the webhook was executed.

		hash	string
		The submitted hash in hex representation.

		success	boolean
		Indicates whether the webhook was executed successfully or not.

		tries	integer($int32)
		Returns the number of tries for the webhook execution.
	    "
      )
    },
    currency = integer(0),
    executed = logical(0),
    hash = character(0),
    success = logical(0),
    tries = integer(0)
  )
)

DefaultOfWebhookResponse <- R6::R6Class(
  "DefaultOfWebhookResponse",
  list(
    description = function() {
      cat(
        "
		The default service response object uses error code and message to indicate errors. These errors are handled by the client.

		data	WebhookResponse{...}

		error_code	integer($int32)
		Contains the error of the request. If the error code is 0, everything is fine.

		error_message	string
		Contains the error message, that possibly occurred. If it is empty, everything is fine.
    "
      )
    },
    data = WebhookResponse$new(),
    error_code = integer(0),
    error_message = character(0)
  )
)


WebhookRequest <- R6::R6Class(
  "WebhookRequest",
  list(
    description = function() {
      cat(
        "
		Request object for a webhook request.

		currency	integer($int32)
		example: 0
		Currency ID for which the webhook should be executed. Possible values:
		0: Bitcoin
		1: Ethereum
		2: AION
		100: Südkurier

		hash	string
		example: 9f86d081884c7d659a2feaa0c55ad015a3bf4f1b2b0b822cd15d6c15b0f00a08
		Hash (SHA-256 in HEX) for which a notification is requested.

		target	string
		example: https://originstamp.com/webhook
		Target address to which a POST request should be executed.
  	  "
      )
    },
    currency = integer(0),
    hash = character(0),
    target = character(0)
  )
)




ManualWebhookRequest <- R6::R6Class(
  "ManualWebhookRequest",
  list(
    description = function() {
      cat(
        "
		Request object for a manual webhook request.

		hash*	string
		example: 2c5d36be542f8f0e7345d77753a5d7ea61a443ba6a9a86bb060332ad56dba38e
		SHA-256 Hash in Hex representation.

		webhook_url*	string
		example: http://localhost:80/originstamp/webhook
		The target URL to which we send the timestamp information of the requested hash via a post request.
    	"
      )
    },
    hash = character(0),
    webhook_url = character(0)
  )
)
