\name{bootmatch}
\alias{bootmatch}
\title{Bootstrap treatment units for propensity score analysis}
\usage{
  bootmatch(Tr, Y, X, M = 100, ratio = 3, nstrata = 5,
    sample.size = (ratio * min(table(Tr))), ...)
}
\arguments{
  \item{Tr}{numeric (0 or 1) or logical vector of treatment
  indicators.}

  \item{Y}{vector of outcome varaible.}

  \item{X}{matrix or data frame of covariates used to
  estimate the propensity scores.}

  \item{M}{number of bootstrap samples to generate.}

  \item{ratio}{the ratio of control units to sample
  relative to the treatment units.}

  \item{sample.size}{the size of each bootstrap sample of
  control units.}

  \item{nstrata}{number of strata to use.}

  \item{...}{other parameters passed to \code{\link{Match}}
  and \code{\link{psa.strata}}}
}
\description{
  Bootstrap treatment units for propensity score analysis
}

