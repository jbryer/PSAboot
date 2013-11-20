#' Boxplot of the balance statistics for bootstrapped samples.
#' 
#' @param x results of \code{\link{balance}}
#' @param unadjusted.color the color used for the unadjusted effect size.
#' @param pooled.color the color used for the mean bootstrap effect size.
#' @param point.size the size of the points.
#' @param point.alpha the transparency level for the points.
#' @param ... other parameters passed to \code{\link{facet_wrap}}
#' @return a ggplot2 expression.
#' @S3method boxplot PSAboot.balance
#' @method boxplot PSAboot.balance
#' @export
boxplot.PSAboot.balance <- function(x, 								 
									unadjusted.color='red', 
									pooled.color='blue', 
									point.size=3, 
									point.alpha=.5, 
									...) {
	combined <- data.frame()
	for(i in seq_along(x$balances)) {
		method <- names(x$balances)[i]
		tmp <- as.data.frame(x$balances[[i]])
		tmp$Method <- method
		combined <- rbind(combined, tmp)
	}
	tmp <- melt(combined, id='Method')
	tmp2 <- as.data.frame(x$unadjusted)
	names(tmp2) <- 'value'
	tmp2$variable <- row.names(tmp2)
	p <- ggplot(tmp, aes(x=variable, y=value)) + 
		geom_boxplot() + 
		geom_point(data=tmp2, color=unadjusted.color, 
				   size=point.size, alpha=point.alpha) +
		geom_point(aes(y=mean(value, na.rm=TRUE)), color=pooled.color, 
				   size=point.size, alhpa=point.alpha) +
		facet_wrap(~ Method, ...) + coord_flip()
	return(p)
}
