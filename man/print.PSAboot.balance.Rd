\name{print.PSAboot.balance}
\alias{print.PSAboot.balance}
\title{Print method for balance.}
\usage{
  \method{print}{PSAboot.balance} (x, na.rm = TRUE, ...)
}
\arguments{
  \item{x}{results from \code{\link{balance}}.}

  \item{na.rm}{whether NA balance statistics should be
  removed before averaging them.}

  \item{...}{currently unused.}
}
\description{
  This is a crude measure of overall balance. Absolute
  value of the standardized effect sizes are calculated for
  each covariate. Overall balance statistics are the mean
  of those effect sizes after adjustement for each method
  across all bootstrap samples.
}

