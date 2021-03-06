% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/get_currencies.R
\name{get_currencies}
\alias{get_currencies}
\title{Get the active currencies}
\usage{
get_currencies(error_on_fail = TRUE, url = api_url(), key = api_key())
}
\arguments{
\item{error_on_fail}{if TRUE, raise error when api call fails, otherwise
return the failed response.}

\item{url}{the url of the api. The default is to use the url as returned by the function \code{api_url()}}

\item{key}{the api key. The default is to use the key as returned by the function \code{api_key()}}
}
\value{
object of class \code{OriginStampResponse}.
}
\description{
wrapper around \url{https://api.originstamp.com/swagger/swagger-ui.html#/scheduler/getActiveCurrencies}. The
function downloads information about the currencies.
}
\examples{

\dontrun{
# Retrieve complete merkle tree proof
get_currencies()
}
}
