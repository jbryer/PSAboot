\name{balance}
\alias{balance}
\title{Returns a summary of the balance for all bootstrap samples.}
\usage{
  balance(psaboot, na.rm = TRUE)
}
\arguments{
  \item{psaboot}{results from \code{\link{PSAboot}}.}

  \item{na.rm}{should NAs be removed. NAs generally occur
  when there is insufficient sample for a particular
  covariate or an unused level.}
}
\value{
  a list with three elements: \describe{
  \item{unadjusted}{named numeric vector with unadjusted
  effect size before adjustment for each covaraite}
  \item{complete}{a matrix with adjusted effect size for
  each covariate (columns) for each method (rows).}
  \item{pooled}{a matrix with mean adjusted effect size for
  all covariates for each method (columns) and each
  bootstrap sample (rows).} \item{balances}{a list with an
  M x n covariates matrix for each method.} }
}
\description{
  This method provides some crude overall measures of
  balance.
}

