#' Print results of bootmatch
#' 
#' @param x result of \code{\link{bootmatch}}.
#' @param ... currently unused.
#' @S3method print PSAboot
#' @method print PSAboot
#' @export
print.PSAboot <- function(x, ...) {
	summary(x, ...)
}
