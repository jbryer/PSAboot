#' Return the 25th percentile.
#' 
#' @param x numeric vector.
#' @export
#' @return the 25th percetile.
q25 <- function(x) {
	return(unname(quantile(x)[2]))
}

#' Returns the 75th percentile.
#' 
#' @param x numeric vector.
#' @export
#' @return the 75th percentile.
q75 <- function(x) {
	return(unname(quantile(x)[4]))
}
