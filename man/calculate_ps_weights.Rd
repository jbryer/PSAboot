% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/boot.weighting.R
\name{calculate_ps_weights}
\alias{calculate_ps_weights}
\title{Calculates propensity score weights.}
\usage{
calculate_ps_weights(treatment, ps, estimand = "ATE")
}
\arguments{
\item{treatment}{a logical vector for treatment status.}

\item{ps}{numeric vector of propensity scores}

\item{estimand}{character string indicating which estimand to be used. Possible
values are 
ATE (average treatment effect), 
ATT (average treatment effect for the treated), 
ATC (average treatement effect for the controls), 
ATM (Average Treatment Effect Among the Evenly Matchable), 
ATO (Average Treatment Effect Among the Overlap Populatio)}
}
\description{
Calculates propensity score weights.
}
