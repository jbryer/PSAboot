utils::globalVariables(c('estimate'))

#' Histogram of PSA bootstrap results
#' 
#' 
#' @param x result of `[PSAboot()]`.
#' @param ... other parameters passed to `[ggplot2::geom_histogram()]
#' @method hist PSAboot
#' @return a ggplot2 expression.
#' @export
hist.PSAboot <- function(x, ...) {
	p <- ggplot(x$pooled.summary, aes(x=estimate)) + 
		geom_vline(xintercept=0) +
		geom_histogram(alpha=.5, ...) + 
		facet_wrap(~ method, ncol=1)
	return(p)
}
