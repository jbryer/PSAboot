\name{boot.strata}
\alias{boot.strata}
\title{Stratification implementation for bootstrapping.}
\usage{
  boot.strata(Tr, Y, X, formu, nstrata = 5, ...)
}
\arguments{
  \item{Tr}{vector indicating treatment assignment.}

  \item{Y}{vector of outcome.}

  \item{X}{matrix or data frame of covariates.}

  \item{formu}{the formula to use to estimate propensity
  scores. Note that the dependent varaible (i.e. treatment
  variable) name will be updated using the \code{Tr}
  vector.}

  \item{nstrata}{number of strata to divide the propensity
  scores.}

  \item{...}{other parameters passed from
  \code{\link{PSAboot}}}
}
\value{
  a list with two elements: a named vector (with at minimum
  estimate, ci.min, and ci.max but other values allowd)
  named summary; and an arbitrary object named details that
  contains the full results of the analysis.
}
\description{
  Stratification implementation for bootstrapping.
}

