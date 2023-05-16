
# <img src="man/figures/PSAboot.png" align="right" width="120" align="right" /> Bootstrapping Propensity Score Analysis

<!-- badges: start -->

[![R-CMD-check](https://github.com/jbryer/PSAboot/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/jbryer/PSAboot/actions/workflows/R-CMD-check.yaml)
[![](https://img.shields.io/badge/devel%20version-1.3.7-blue.svg)](https://github.com/jbryer/PSAboot)
[![](https://www.r-pkg.org/badges/version/PSAboot)](https://cran.r-project.org/package=PSAboot)
[![CRAN
Status](https://badges.cranchecks.info/flavor/release/PSAboot.svg)](https://cran.r-project.org/web/checks/check_results_PSAboot.html)
<!-- badges: end -->

Package website: <https://jbryer.github.io/PSAboot/>  
Poster:
<https://github.com/jbryer/PSAboot/blob/master/Poster/PSAboot_Poster.pdf>

As the popularity of propensity score methods for estimating causal
effects in observational studies increase, the choices researchers have
for which methods to use has also increased. Estimated treatment effects
may be sensitive to choice of method. One approach to test the
sensitivity of method choice is to test the null hypothesis more than
once using more than one method (Rosenbaum, 2012). With the wide
availability of high power computers resampling methods such as
bootstrapping (Efron, 1979) have become popular for providing more
estimates of the sampling distribution. This paper introduces the
`PSAboot` R package that provides functions for bootstrapping propensity
score methods. It deviates from traditional bootstrapping methods by
allowing for different sampling specifications for treatment and control
groups, mainly to ensure the ratio of treatment-to-control observations
are consistent. This approach can also be used in situations where there
is imbalance between the number of treatment and control observations by
allowing for up and/or down sampling. Lastly, by estimating balance
statistics and treatment effects for each bootstrap sample we can
compare the distributions across multiple propensity score methods to
examine the relative performance of these methods.

## Installation

You can download from CRAN using:

``` r
install.packages('PSAboot')
```

Or the latest development version using the `remotes` package:

``` r
remotes::install_github('jbryer/PSAboot')
```

## Code of Conduct

Please note that the PSAboot project is released with a [Contributor
Code of
Conduct](https://contributor-covenant.org/version/2/1/CODE_OF_CONDUCT.html).
By contributing to this project, you agree to abide by its terms.
