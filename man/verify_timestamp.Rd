% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/verify_timestamp.R
\name{verify_timestamp}
\alias{verify_timestamp}
\title{Verify a timestamp of a hash}
\usage{
verify_timestamp(
  x,
  proof = NULL,
  use_originstamp = is.null(proof),
  error_on_fail = TRUE,
  url = api_url(),
  key = api_key()
)
}
\arguments{
\item{x}{x an R object (character vector containing file names of existing files or strings) of which a hash will be calculated using the function
\code{hash(x)}. The object whose timestamp should be verified}

\item{proof}{either a file name or an URL pointing to the proof or certificate of the timestamp}

\item{use_originstamp}{if \code{TRUE}, OriginStamp will be used to verity the timestamp of the hash. In this case, \code{proof} is not needed.}

\item{error_on_fail}{if TRUE, raise error when api call fails, otherwise
return the failed response.ß}

\item{url}{the url of the api. The default is to use the url as returned by
the function \code{api_url()}}

\item{key}{the api key. The default is to use the key as returned by the
function \code{api_key()}}
}
\value{
\code{data.frame} with \code{currency_id}, \code{transaction} and
\code{timestamp} if verification was successful. Otherwise these are all set to \code{NULL}.
}
\description{
There are effectively two ways of verifying a timestamp of a hash:
}
\details{
\enumerate{
\item to use OriginStamp. This is the easies approach and is  described
\href{https://docs.originstamp.com/howto/verification.html#verify-a-timestamp-with-originstamp}{on their documentation site}.
Similarly, when specifying \code{use_originstamp = TRUE} the api will be used to retrieve information about the timestamp
using the \code{get_hash_status()} function.
\item to not use OriginStamp. This directly queries the bitcoin blockchain.
\strong{The host used to verify without the proof is not available anymore.}
\strong{Therefore this part does not work anymore.}
\strong{It is only included as an example how it could be done using a different host}
}

For this, it is essential to have either the xml proof or the pdf certificate of the timestamp as can be downloaded by
the function \code{extract_proof()}. Here, we assume that all verification should be done without any interaction with OriginStamp.
\strong{Only timestamps issued after middle February 2021 can be veryfied using this approach (OP_RETURN usage by OriginStamp.}
}
