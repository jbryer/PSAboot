\name{boot.matching}
\alias{boot.matching}
\title{Matching package implementation for bootstrapping.}
\usage{
  boot.matching(Tr, Y, X, formu, estimand = "ATE", ...)
}
\arguments{
  \item{estimand}{character string for estimand, either
  ATE, ATT, or ATC. See \code{\link{Match}} for more
  details.}

  \item{Tr}{vector indicating treatment assignment.}

  \item{Y}{vector of outcome.}

  \item{X}{matrix or data frame of covariates.}

  \item{formu}{the formula to use to estimate propensity
  scores. Note that the dependent varaible (i.e. treatment
  variable) name will be updated using the \code{Tr}
  vector.}

  \item{...}{other parameters passed from
  \code{\link{PSAboot}}}
}
\description{
  Matching package implementation for bootstrapping.
}

