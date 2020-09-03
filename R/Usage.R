
UsageResponse <- R6::R6Class(
  "UsageResponse",
  list(
    description = function() {
      cat(
        "
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
    "
      )
    },
    certificate_per_month = integer(0),
    consumed_certificates = integer(0),
    consumed_credits = numeric(0),
    consumed_timestamps = integer(0),
    credits_per_month = numeric(0),
    limitation_type = integer(0),
    remaining_credits = numeric(0),
    timestamps_per_month = integer(0)
  )
)


DefaultUsageResponse <- R6::R6Class(
  "UsageResponse",
  list(
    description = function() {
      cat(
        "
    	The default service response object uses error code and message to indicate errors. These errors are handled by the client.

		data	UsageResponse{...}

		error_code	integer($int32)
		Contains the error of the request. If the error code is 0, everything is fine.

		error_message	string
		Contains the error message, that possibly occurred. If it is empty, everything is fine.
   	 "
      )
    },
    data = UsageResponse$new(),
    error_code = integer(0),
    error_message = character(0),
    get = function() {
      # Assemble URL ------------------------------------------------------------

      url <- paste(api_url(), "api_key", "usage", sep = "/")
      url <- gsub("//", "/", url)
      url <- gsub(":/", "://", url)

      # POST request ------------------------------------------------------------

      response <- httr::GET(
        url = url,
        ## -H
        config = httr::add_headers(
          accept = "*/*",
          Authorization = api_key()
        )
      )

      httr::stop_for_status(response)

      # Process return value ----------------------------------------------------

      try(
        {
          content <- httr::content(
            x = response,
            as = "text"
          )
          content <- jsonlite::fromJSON( content )
        },
        silent = TRUE
      )


      # Put into self -----------------------------------------------------------

      self$error_code <- content$error_code
      self$error_message <- content$error_message
      self$data$credits_per_month <- content$data$credits_per_month
      self$data$remaining_credits <- content$data$remaining_credits
      self$data$consumed_credits <- content$data$consumed_credits
      self$data$timestamps_per_month <- content$data$timestamps_per_month
      self$data$consumed_timestamps <- content$data$consumed_timestamps
      self$data$ certificate_per_month<- content$data$certificate_per_month
      self$data$consumed_certificates <- content$data$consumed_certificates
      self$data$limitation_type <- content$data$limitation_type

      # Check if error  ---------------------------------------------------------

      if (self$error_code != 0) {
        stop(
          sprintf(
            "OriginStamp API request failed [%s]\n%s\n\n<%s>",
            self$error_code,
            self$error_message,
            "see https://api.originstamp.com/swagger/swagger-ui.html#/API_Key/getApiKeyUsage"
          )
        )
      }


      # Return ------------------------------------------------------------------

      invisible( self )
    }
  )
)
