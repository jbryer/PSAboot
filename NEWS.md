# PSAboot 1.3.9

* Documentation fixes to pass CRAN check.

# PSAboot 1.3.8

* Fix for change in t.test with paired data to not use the formula notation.

# PSAboot 1.3.7

* Added propensity score weighting.
* Fixed a bug where the balance table wasn't combined correctly if the covariates were not specified in the correct order.

# PSAboot 1.3.6

* Update to re-release to CRAN.
* Fixes to pass CRAN check. 

# PSAboot 1.3.4

* Update for compatibility with the multilevelPSA package.

# PSAboot 1.3.3

* Fixed new R CMD CHECK notes and warnings.
* Updated for new version of party package.

# PSAboot 1.3.0

* Refactored the function for calculating balance to be shared across all the matching procedures.
* Added a vignette about the impact of matching order.

# PSAboot 1.2.0

* Fixed an issue where under certain circumnstances there could be a NA effect estimate. These are removed.
* Added better error checking for when a classification tree with no splits occurs.

# PSAboot 1.1.0

* The summary function now includes a weighted pooled estimate. This estimate is weighted using the inverse balance estimates so that bootstrap samples with better balance are weighted more to the estimate than those with worse balance.
* You can now specify how the balance estimates are aggregated. Possible values include mean (the default), q25, q75, median, or max.
* Added getPSAbootMethods and global R option "PSAboot.methods" that will return the default set of functions to use in PSAboot.
* Added a number of parameters to the boxplot function including a tufte style from the ggthemes package.

# PSAboot 1.0.0

* Initial version of PSAboot package for bootstrapping propensity score analysis.
