
DownloadLinkResponse <- R6::R6Class(
  "DownloadLinkResponse",
  list(
    description = function() {
      cat(
        "
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
 	   "
      )
    },
    download_url = character(0),
    file_name = character(0),
    file_size_bytes = integer(0)
  )
)

DefaultOfDownloadLinkResponse <- R6::R6Class(
  "DefaultOfDownloadLinkResponse",
  list(
    description = function() {
      cat(
        "
		The default service response object uses error code and message to indicate errors. These errors are handled by the client.

		data	DownloadLinkResponse{...}

		error_code	integer($int32)
		Contains the error of the request. If the error code is 0, everything is fine.

		error_message	string
		Contains the error message, that possibly occurred. If it is empty, everything is fine.
    "
      )
    },
    data = DownloadLinkResponse$new(),
    error_code = integer(0),
    error_message = character(0)
  )
)
