ROriginStamp - a simple interface to
[OriginStamp](https://originstamp.org/)
================

-   [Dependencies](#dependencies)
-   [Overview](#overview)
    -   [Background](#background)
        -   [What are Trusted Timestamps?](#what-are-trusted-timestamps)
        -   [How is it done](#how-is-it-done)
    -   [Prerequisites](#prerequisites)
    -   [Installation](#installation)
-   [How to use it](#how-to-use-it)
    -   [Hashing](#hashing)
    -   [Preparation](#preparation)
    -   [`get_key_usage()` - Getting infomation about your OriginStamp
        account](#get_key_usage---getting-infomation-about-your-originstamp-account)
    -   [`get_currencies()` - Getting infomation about your OriginStamp
        account](#get_currencies---getting-infomation-about-your-originstamp-account)
    -   [`create_timestamp()` - Create a new
        timestamp](#create_timestamp---create-a-new-timestamp)
    -   [`get_hash_status()` - Getting the status of a submitted
        hash](#get_hash_status---getting-the-status-of-a-submitted-hash)
    -   [`get_proof()` - Downloading proof of a created
        timestamp](#get_proof---downloading-proof-of-a-created-timestamp)
-   [References](#references)

<!-- README.md is generated from README.Rmd. Please edit that file -->

[![Build
Status](https://travis-ci.org/rkrug/ROriginStamp.svg?branch=master)](https://travis-ci.org/rkrug/ROriginStamp)
[![lifecycle](https://img.shields.io/badge/lifecycle-maturing-orange.svg)](https://www.tidyverse.org/lifecycle/#maturing)
[![Coverage
Status](https://img.shields.io/codecov/c/github/rkrug/ROriginStamp/master.svg)](https://codecov.io/github/rkrug/ROriginStamp?branch=master)

<!-- [![Inline docs](http://inch-ci.org/github/rkrug/ROriginStamp.svg?branch=master)](http://inch-ci.org/github/rkrug/ROriginStamp) -->
<!-- [CII Best Practices Badge](https://bestpractices.coreinfrastructure.org/en/projects/2094) -->

------------------------------------------------------------------------

# Dependencies

This package aims at minimising the number of dependencies It has at the
moment only three direct dependencies, which are not avoidable as `curl`
([Ooms 2019](#ref-curlR)) is used to access the
[OriginStamp](https://originstamp.com) API, `openssl` ([Ooms
2020](#ref-opensslR)) to calculate the hashes, and `jsonlite` ([Ooms
2014](#ref-jsonliteR)) to encode and decode the API communications. The
dependency graph looks as followes:

![Dependency graph](./README_files/figure-gfm/dep_graph-1.png)

# Overview

This packages allows to obtain Trusted Timestamps (TTS) from
[OriginStamp](https://originstamp.com) for R objects and files. To
obtain the TTS, the sha256 hashes are calculated of the object using
[OpenSSL](https://www.openssl.org) by using the opennssl R package
([Ooms 2020](#ref-opensslR)).

## Background

### What are Trusted Timestamps?

From [Wikipedia](https://en.wikipedia.org/wiki/Trusted_timestamping)

> Trusted timestamping is the process of securely keeping track of the
> creation and modification time of a document. Security here means that
> no one—not even the owner of the document—should be able to change it
> once it has been recorded provided that the timestamper’s integrity is
> never compromised.

This allows you, “to prove that \[you are\] the originator of certain
information at a given point in time” (from [OriginStamp
documentation](https://docs.originstamp.com/guide/#about-this-documentation)).

Examples are to prof that you generated the data at a given time, proof
that you had the data before anybody else, etc.

### How is it done

I will cite from the [OriginStamp
documentation](https://docs.originstamp.com/guide/#introduction):

> OriginStamp is a web-based, trusted timestamping service that uses the
> decentralized blockchain to store anonymous, tamper-proof time stamps
> for any digital content. OriginStamp allows users to hash files,
> emails, or plain text, and subsequently store the created hashes in
> the blockchain as well as retrieve and verify time stamps that have
> been committed to the blockchain. OriginStamp is free of charge and
> easy to use.

A detailed description on how their approach works, can also be found in
[their
documentation](https://docs.originstamp.com/guide/originstamp.html#preparation-of-digital-content).

## Prerequisites

Before you can use the package, you have to get an API key from
[OriginStamp](https://docs.originstamp.com). For details, see their [Get
anAPI key
documentation](https://docs.originstamp.com/guide/gettingstarted.html#get-an-api-key).

## Installation

`ROriginStamp` is momentarily only available on github, so you have to
install it by using devtools:

``` r
if (!require(devtools)) {
  install.packages("devtools")
  library(devtools)
}
devtools::install_github("rkrug/ROriginStamp")
```

# How to use it

## Hashing

This package is based on sha256 hashes as calculated by the openssl
package by [Ooms](#ref-opensslR) ([2020](#ref-opensslR)) as OriginStamp
is using sha256 hashes.

The function `hash(x)` is the workhorse for calculating hashes. It
calculates sha256 from R objects as well as, from files. It returns an
object of class `hash`, which is simply a character vector of length 1
with the class `hash` assigned.

The hash is calculated when

1.  `x` is a character vector,
2.  if the `length(x)` is one, and
3.  `x` points to an existing file.

If you want to calculate the hash of an character vector of length one
which is also a file name to an existing file,

``` r
hash(system.file("DESCRIPTION", package = "ROriginStamp"))
```


    Create sha356 hash from R file x [/usr/local/lib/R/4.0/site-library/ROriginStamp/DESCRIPTION]

    sha256 f3:aa:c8:72:ee:02:e7:16:d7:f0:73:2f:37:09:dc:db:3d:33:f3:71:04:8f:e4:fa:b8:f9:f0:60:ae:a4:2d:97 

returns the hash of the file. This is identical to directly call the
hash method which calculates the hash of the file:

``` r
hash.file(system.file("DESCRIPTION", package = "ROriginStamp"))
```


    Create sha356 hash from R file x [/usr/local/lib/R/4.0/site-library/ROriginStamp/DESCRIPTION]

    sha256 f3:aa:c8:72:ee:02:e7:16:d7:f0:73:2f:37:09:dc:db:3d:33:f3:71:04:8f:e4:fa:b8:f9:f0:60:ae:a4:2d:97 

If you want to calculate the hash of the actual R object, you have to
method which handles all R objects:

``` r
hash.default(system.file("DESCRIPTION", package = "ROriginStamp"))
```


    Create sha356 hash from R object x

    sha256 0e:1e:23:1f:37:ff:e4:de:2b:42:1b:3b:e5:7b:0a:f8:6c:6f:9e:63:7b:dc:80:f1:02:37:57:ae:54:66:89:1d 

If `x` is an object of class `hash`, the object x is returned as is:

``` r
identical( 
  hash(letters), 
  hash(hash(letters))
)
```


    Create sha356 hash from R object x

    Create sha356 hash from R object x


    x is already a hash - returning x unprocessed

    [1] TRUE

## Preparation

If you want to do anything more than hashing with this package, you have
to register with [OriginStamp](https://originstamp.com) and get an API
key. You can register for a free account and still use all the
functionality of this package. To get an API key is described in the
[Get an API key
section](https://docs.originstamp.com/guide/gettingstarted.html#get-an-api-key)
of the documentation.

To make this key available to the package, you have to

1.  either set it as an environmental variable, by e.g. using

``` r
Sys.setenv(ROriginStamp_api_key = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx")
```

or 2. use the `api_key()` function to set the api key by running

``` r
api_key("xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx")`
```

## `get_key_usage()` - Getting infomation about your OriginStamp account

To get the key usage statistics is accomplished by using

``` r
get_key_usage()
```

This gives an overview over your usage of your credits. The actual
numbers depend on the plan you are on and the number of credits used
already.

For a detailed description of the return value see [the
Default«UsageResponse» in the models
section](https://api.originstamp.com/swagger/swagger-ui.html#/) of the
API documentation.

## `get_currencies()` - Getting infomation about your OriginStamp account

OriginStamp can work with different blockchain based currencies. The
list of the currencies supported can be retrieved by using

``` r
get_currencies()
```

For a detailed description of the return value see [the
DefaultOfListOfCurrencyModel in the models
section](https://api.originstamp.com/swagger/swagger-ui.html#/) of the
API documentation.

## `create_timestamp()` - Create a new timestamp

Let’s create a new timestamp.

As an example, let’s create a timestamp for 100 random numbers, to make
sure, that the hash has not been timestamped by OriginStamp already.

``` r
obj <- runif(100)
create_timestamp(
  x = obj, 
  comment = "This is a dummy test for creating a timestamp."
)
```

Now let’s submit the same hash again and see what happens:

``` r
create_timestamp(
  x = obj, 
  comment = "This is a dummy test for creating a timestamp a second time."
)
```

The difference is in `$content$data$created` which is `TRUE` when the
submitted hash has not been timestamped already and subsequently
created, and `FALSE` when it already exists. This is an easy way to
check if the submission was successful.

It is important to note, that the timestamps are not created
immediately, but put in a bash cue, which is submitted at certain
intervalls, depending on the currency used. See [the documentation on
currencies](https://docs.originstamp.com/guide/#blockchain-currencies)
for details.

## `get_hash_status()` - Getting the status of a submitted hash

Let’s get information about the status of some hashes submitted. We
start with the status of the just submitted hash of `obj`

``` r
get_hash_status(
  x = obj
)
```

Now lets look at the status of a hash submitted in the past and which is
already processed and timestamped:

``` r
get_hash_status(
  x = as.hash("2c5d36be542f8f0e7345d77753a5d7ea61a443ba6a9a86bb060332ad56dba38e")
)
```

The difference is in `$content$data$timestamps` which is in the case of
a submitted hash but not yet created timestamp an essentially empty
table, while in the case of a created timestamp, a table lie=sting the
timestamp information.

But this information is neither particularly useful, nor userfriendly if
one wan’s to proof the timestamp. For this, let’s move the final
command.

## `get_proof()` - Downloading proof of a created timestamp

The structure of the command is very similar to the previous one, only
that one can specify the type of the proof. This can be either in the
form of a `pdf` file (a ‘certificate’), or as an xml file (a ‘proof’).

``` r
get_proof(
  x = as.hash("2c5d36be542f8f0e7345d77753a5d7ea61a443ba6a9a86bb060332ad56dba38e"), 
  proof_type = "pdf"
)
```

or

``` r
get_proof(
  x = as.hash("2c5d36be542f8f0e7345d77753a5d7ea61a443ba6a9a86bb060332ad56dba38e"), 
  proof_type = "xml"
)
```

The function returns an object containing the url where the document can
be downloaded (`$content$data$download_url`) which is automatically
processed further and the document is downloaded. As file name, the
argument `file` is used. If it is not provided, the file name in the
return value is used, which is of the format for or for

To see the downloaded files, click [here for the
pdf](./inst/certificate.Bitcoin.2c5d36be542f8f0e7345d77753a5d7ea61a443ba6a9a86bb060332ad56dba38e.pdf)
or [here for the
xml](./inst/proof.Bitcoin.2c5d36be542f8f0e7345d77753a5d7ea61a443ba6a9a86bb060332ad56dba38e.xml).

# References

<div id="refs" class="references csl-bib-body hanging-indent">

<div id="ref-jsonliteR" class="csl-entry">

Ooms, Jeroen. 2014. “The Jsonlite Package: A Practical and Consistent
Mapping Between JSON Data and r Objects.” *arXiv:1403.2805 \[Stat.CO\]*.
<https://arxiv.org/abs/1403.2805>.

</div>

<div id="ref-curlR" class="csl-entry">

———. 2019. *Curl: A Modern and Flexible Web Client for r*.
<https://CRAN.R-project.org/package=curl>.

</div>

<div id="ref-opensslR" class="csl-entry">

———. 2020. *Openssl: Toolkit for Encryption, Signatures and Certificates
Based on OpenSSL*. <https://CRAN.R-project.org/package=openssl>.

</div>

</div>
