\name{boot.rpart}
\alias{boot.rpart}
\title{Stratification using classification trees for bootstrapping.}
\usage{
  boot.rpart(Tr, Y, X, X.trans, formu, minStrata = 5, ...)
}
\arguments{
  \item{minStrata}{minimum number of treatment or control
  unitis within a strata to include that strata.}

  \item{Tr}{vector indicating treatment assignment.}

  \item{Y}{vector of outcome.}

  \item{X}{matrix or data frame of covariates.}

  \item{X.trans}{a data frame of \code{X} with factors
  recoded. See \code{\link{cv.trans.psa}}}

  \item{formu}{the formula to use to estimate propensity
  scores. Note that the dependent varaible (i.e. treatment
  variable) name will be updated using the \code{Tr}
  vector.}

  \item{...}{other parameters passed from
  \code{\link{PSAboot}}}
}
\description{
  Stratification using classification trees for
  bootstrapping.
}

