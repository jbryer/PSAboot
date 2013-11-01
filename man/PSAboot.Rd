\name{PSAboot}
\alias{PSAboot}
\title{Bootstrap treatment units for propensity score analysis}
\usage{
  PSAboot(Tr, Y, X, M = 100, control.ratio = 3,
    control.sample.size = (control.ratio * min(table(Tr))),
    control.replace = FALSE,
    treated.sample.size = min(table(Tr)),
    treated.replace = FALSE,
    methods = c(Stratification = boot.strata, ctree = boot.ctree, rpart = boot.rpart, Matching = boot.matching, MatchIt = boot.matchit),
    parallel = TRUE, seed = NULL, ...)
}
\arguments{
  \item{Tr}{numeric (0 or 1) or logical vector of treatment
  indicators.}

  \item{Y}{vector of outcome varaible.}

  \item{X}{matrix or data frame of covariates used to
  estimate the propensity scores.}

  \item{M}{number of bootstrap samples to generate.}

  \item{control.ratio}{the ratio of control units to sample
  relative to the treatment units.}

  \item{control.sample.size}{the size of each bootstrap
  sample of control units.}

  \item{control.replace}{whether to use replacement when
  sampling from control units.}

  \item{treated.sample.size}{the size of each bootstrap
  sample of treatment units. The default uses all treatment
  units for each boostrap sample.}

  \item{treated.replace}{whether to use replacement when
  sampling from treated units.}

  \item{methods}{a named vector of functions for each PSA
  method to use.}

  \item{seed}{random seed. Each iteration, i, will use a
  seed of \code{seed + i}.}

  \item{parallel}{whether to run the bootstrap samples in
  parallel.}

  \item{...}{other parameters passed to \code{\link{Match}}
  and \code{\link{psa.strata}}}
}
\value{
  a list with following elements: \describe{
  \item{overall.summary}{Data frame with the results using
  the complete dateset (i.e. unboostrapped results).}
  \item{overall.details}{Objects returned from each method
  for complete dataset.} \item{pooled.summary}{Data frame
  with results of each boostrap sample.}
  \item{pooled.details}{List of objects returned from each
  method for each boostrap sample.}
  \item{control.sample.size}{sample size used for control
  units.} \item{treated.sample.size}{sample size used for
  treated units.} \item{control.replace}{whether control
  units were sampled with replacement.}
  \item{treated.replace}{whether treated units were sampled
  with replacement.} \item{Tr}{vector of treatment
  assignment.} \item{Y}{vector out outcome.}
  \item{X}{matrix or data frame of covariates.}
  \item{M}{number of bootstrap samples.} }
}
\description{
  Bootstrap treatment units for propensity score analysis
}

