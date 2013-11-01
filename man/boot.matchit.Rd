\name{boot.matchit}
\alias{boot.matchit}
\title{MatchIt package implementation for bootstrapping.}
\usage{
  boot.matchit(Tr, Y, X, formu, ...)
}
\arguments{
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
  MatchIt package implementation for bootstrapping.
}

