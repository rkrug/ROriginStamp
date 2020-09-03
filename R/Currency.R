CurrencyModel <- R6::R6Class(
  "currency_model",
  list(
    description = function() {
      cat(
        "
		Contains the currency ID and currency name

		currency	string
		Name of the currency (uppercase)

		currency_id	integer($int64)
		ID of the currency, e.g.
		0: Bitcoin
		1: Ethereum
 	   "
      )
    },
    currency = character(0),
    currency_id	= integer(0)
  )
)


DefaultOfListOfCurrencyModelDefault <- R6::R6Class(
  "DefaultOfListOfCurrencyModelDefault",
  list(
    description = function() {
      cat(
        "
		The default service response object uses error code and message to indicate errors. These errors are handled by the client.

		data	[...]

		error_code	integer($int32)
		Contains the error of the request. If the error code is 0, everything is fine.

		error_message	string
		Contains the error message, that possibly occurred. If it is empty, everything is fine.
    "
      )
    },
    data = list(),
    error_code = integer(0),
    error_message = character(0),
    get = function(
      error_on_fail = TRUE
    ) {

      # Assemble URL ------------------------------------------------------------

      url <- paste(api_url(), "currencies", "get", sep = "/")
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
      ##
      self$data <- list()
      for (i in 1:nrow(content$data)) {
        x <- CurrencyModel$new()
        x$currency_id <- content$data[i,]$currency_id
        x$currency <- content$data[i,]$currency
        self$data[[i]] <- x
      }

      # Check if error  ---------------------------------------------------------

      if (self$error_code != 0) {
        stop(
          sprintf(
            "OriginStamp API request failed [%s]\n%s\n\n<%s>",
            self$error_code,
            self$error_message,
            "see https://api.originstamp.com/swagger/swagger-ui.html#/scheduler/getActiveCurrencies"
          )
        )
      }

      # Return self -------------------------------------------------------------

      invisible( self )
    }
  )
)
