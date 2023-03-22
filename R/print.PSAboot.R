#' Print results of PSAboot
#' 
#' @param x result of \code{\link{PSAboot}}.
#' @param ... currently unused.
#' @method print PSAboot
#' @return Nothing returned. S3 generic function that calls the [PSAboot::summary()] function.
#' @export
print.PSAboot <- function(x, ...) {
	print(summary(x, ...))
}
