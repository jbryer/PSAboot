\name{plot.bootmatch}
\alias{plot.bootmatch}
\title{Plot the results of bootmatch}
\usage{
  \method{plot}{bootmatch} (x, plot.matching = TRUE,
    plot.stratification = TRUE,
    sort = c("both", "match", "strata", "none"), ...)
}
\arguments{
  \item{x}{result of \code{\link{bootmatch}}.}

  \item{plot.matching}{plot the results of matched
  results.}

  \item{plot.stratification}{plot the results of
  stratification.}

  \item{sort}{how the sort the rows by mean difference.
  Options are to sort using the mean difference from
  matching, stratificaiton, both individually, or no
  sorting.}

  \item{...}{currently unused.}
}
\description{
  Plot the results of bootmatch
}

