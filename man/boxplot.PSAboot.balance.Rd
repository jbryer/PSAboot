\name{boxplot.PSAboot.balance}
\alias{boxplot.PSAboot.balance}
\title{Boxplot of the balance statistics for bootstrapped samples.}
\usage{
  \method{boxplot}{PSAboot.balance} (x,
    unadjusted.color = "red", pooled.color = "blue",
    point.size = 3, point.alpha = 0.5, ...)
}
\arguments{
  \item{x}{results of \code{\link{balance}}}

  \item{unadjusted.color}{the color used for the unadjusted
  effect size.}

  \item{pooled.color}{the color used for the mean bootstrap
  effect size.}

  \item{point.size}{the size of the points.}

  \item{point.alpha}{the transparency level for the
  points.}

  \item{...}{other parameters passed to
  \code{\link{facet_wrap}}}
}
\value{
  a ggplot2 expression.
}
\description{
  Boxplot of the balance statistics for bootstrapped
  samples.
}

