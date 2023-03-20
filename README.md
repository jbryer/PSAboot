
# <img src="man/figures/PSAboot.png" align="right" width="120" align="right" /> An R Package for Bootstrapping Propensity Score Analysis

<!-- badges: start -->

[![R-CMD-check](https://github.com/jbryer/PSAboot/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/jbryer/PSAboot/actions/workflows/R-CMD-check.yaml)
[![](https://img.shields.io/badge/devel%20version-1.3.6-blue.svg)](https://github.com/jbryer/PSAboot)
[![](https://www.r-pkg.org/badges/version/PSAboot)](https://cran.r-project.org/package=PSAboot)
[![CRAN
checks](https://badges.cranchecks.info/summary/PSAboot.svg)](https://cran.r-project.org/web/checks/check_results_PSAboot.html)
<!-- badges: end -->

As the popularity of propensity score methods for estimating causal
effects in observational studies increase, the choices researchers have
for which methods to use has also increased. Rosenbaum (2012) suggested
that there are benefits for testing the null hypothesis more than once
in observational studies. With the wide availability of high power
computers resampling methods such as bootstrapping (Efron, 1979) have
become popular for providing more stable estimates of the sampling
distribution. This paper introduces the `PSAboot` package for R that
provides functions for bootstrapping propensity score methods. It
deviates from traditional bootstrapping methods by allowing for
different sampling specifications for treatment and control groups,
mainly to ensure the ratio of treatment-to-control observations are
maintained. Additionally, this framework will provide estimates using
multiple methods for each bootstrap sample. Two examples are discussed:
the classic National Work Demonstration and PSID (Lalonde, 1986) study
and a study on tutoring effects on student grades.

## Installation

You can download from CRAN using:

``` r
install.packages('PSAboot')
```

Or the latest development version using the `remotes` pacakge:

``` r
remotes::install_github('jbryer/PSAboot')
```

## Code of Conduct

Please note that the PSAboot project is released with a [Contributor
Code of
Conduct](https://contributor-covenant.org/version/2/1/CODE_OF_CONDUCT.html).
By contributing to this project, you agree to abide by its terms.
