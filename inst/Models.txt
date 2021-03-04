CurrencyModel{
  description:
    Contains the currency ID and currency name
  currency	string
  Name of the currency (uppercase)

  currency_id	integer($int64)
  ID of the currency, e.g. 0: Bitcoin
  1: Ethereum

}

Default{
  description:
    The default service response object uses error code and message to indicate errors. These errors are handled by the client.
  data	{...}
  error_code	integer($int32)
  Contains the error of the request. If the error code is 0, everything is fine.

  error_message	string
  Contains the error message, that possibly occurred. If it is empty, everything is fine.

}

DefaultOfDownloadLinkResponse{
  description:
    The default service response object uses error code and message to indicate errors. These errors are handled by the client.
  data	DownloadLinkResponse{...}
  error_code	integer($int32)
  Contains the error of the request. If the error code is 0, everything is fine.

  error_message	string
  Contains the error message, that possibly occurred. If it is empty, everything is fine.

}

DefaultOfListOfCurrencyModel{
  description:
    The default service response object uses error code and message to indicate errors. These errors are handled by the client.
  data	[...]
  error_code	integer($int32)
  Contains the error of the request. If the error code is 0, everything is fine.

  error_message	string
  Contains the error message, that possibly occurred. If it is empty, everything is fine.

}

DefaultOfTimestampResponse{
  description:
    The default service response object uses error code and message to indicate errors. These errors are handled by the client.
  data	TimestampResponse{...}
  error_code	integer($int32)
  Contains the error of the request. If the error code is 0, everything is fine.

  error_message	string
  Contains the error message, that possibly occurred. If it is empty, everything is fine.

}

DefaultOfWebhookResponse{
  description:
    The default service response object uses error code and message to indicate errors. These errors are handled by the client.
  data	WebhookResponse{...}
  error_code	integer($int32)
  Contains the error of the request. If the error code is 0, everything is fine.

  error_message	string
  Contains the error message, that possibly occurred. If it is empty, everything is fine.

}

DefaultOfstring{
  description:
    The default service response object uses error code and message to indicate errors. These errors are handled by the client.
  data	string
  Generic response object which contains the response data, e.g. timestamp information.

  error_code	integer($int32)
  Contains the error of the request. If the error code is 0, everything is fine.

  error_message	string
  Contains the error message, that possibly occurred. If it is empty, everything is fine.

}

DownloadLinkResponse{
  description:
    DTO for the download link of a proof request.
  download_url	string
  example: https://example.com/download
  URL to download file.
  file_name	string
  example: file.pdf
  File name of downloaded file.
  file_size_bytes	integer($int64)
  example: 1024
  File size in bytes.
}

ManualWebhookRequest{
  description:
    Request object for a manual webhook request.
  hash*	string
  example: 2c5d36be542f8f0e7345d77753a5d7ea61a443ba6a9a86bb060332ad56dba38e
  SHA-256 Hash in Hex representation.

  webhook_url*	string
  example: http://localhost:80/originstamp/webhook
  The target URL to which we send the timestamp information of the requested hash via a post request.
}

Notification{
  description:
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

}

ProofRequest{
  description:
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

}

TimestampData{
  description:
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

}

TimestampRequest{
  description:
    request object for a timestamp request.
  comment	string
  example: test
  You can add a short comment (max. 256 characters) which can be used for indexing and searching (public).

  hash*	string
  example: 2c5d36be542f8f0e7345d77753a5d7ea61a443ba6a9a86bb060332ad56dba38e
  Hash in HEX representation. We suggest to use SHA-256. This hash will be aggregated and included into the blockchain.

  notifications	[...]
  url	string
  Preprint URL. Insert the generated UUID here. You can generate an UUID-4 and include it into your document: https://originstamp.org/u/uuid4. When submitting the your file, the URL is part of the hash, which finally means it the link to the timestamp is part of the timestamp.

}

TimestampResponse{
  description:
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
}

WebhookRequest{
  description:
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
}

WebhookResponse{
  description:
    response object for a webhook request. Contains only the most recent webhook information for target URL, hash and currency.

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
}

Default«UsageResponse»{
  description:
    The default service response object uses error code and message to indicate errors. These errors are handled by the client.
  data	UsageResponse{...}
  error_code	integer($int32)
  Contains the error of the request. If the error code is 0, everything is fine.

  error_message	string
  Contains the error message, that possibly occurred. If it is empty, everything is fine.

}

UsageResponse{
  description:
    Usage metric for this month.
  certificate_per_month	integer($int64)
  Total number of certificates available per month.
  consumed_certificates	integer($int64)
  Number of certificates requested for the current month.
  consumed_credits	number
  Number of used credits for the current month.
  consumed_timestamps	integer($int64)
  Number of timestamps created for the current month.
  credits_per_month	number
  Represents the total number of credits per month.
  limitation_type	integer($int32)
  Determines which usage metric is applied (0 = credits, 1 = timestamps).

  remaining_credits	number
  Remaining number of credits for the current month.
  timestamps_per_month	integer($int64)
  Total number of timestamps available per month.
}

