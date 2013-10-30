\name{boot.rpart}
\alias{boot.rpart}
\title{Stratification using classification trees for bootstrapping.}
\usage{
  boot.rpart(Tr, Y, X, minStrata = 5, ...)
}
\arguments{
  \item{minStrata}{minimum number of treatment or control
  unitis within a strata to include that strata.}

  \item{Tr}{vector indicating treatment assignment.}

  \item{Y}{vector of outcome.}

  \item{X}{matrix or data frame of covariates.}

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
  Stratification using classification trees for
  bootstrapping.
}

