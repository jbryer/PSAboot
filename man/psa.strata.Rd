% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/psa.strata.R
\name{psa.strata}
\alias{psa.strata}
\title{Propensity Score Analysis using Stratification}
\usage{
psa.strata(Y, Tr, strata, trim = 0, minStrata = 5)
}
\arguments{
\item{Y}{response variable.}

\item{Tr}{treatment variable.}

\item{strata}{strata identifier.}

\item{trim}{allows for a trimmed mean as outcome measure, where trim is from
0 to .5 (.5 implying median).}

\item{minStrata}{minimum number of treatment or control units within a strata 
to include that strata.}
}
\value{
a character vector containing summary.strata, ATE, se.wtd, approx.t, df, and CI.95.
}
\description{
Propensity Score Analysis using Stratification
}
