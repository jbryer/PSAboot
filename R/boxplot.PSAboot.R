#' Boxplot of PSA boostrap results.
#' 
#' @param x result of \code{\link{PSAboot}}.
#' @param ... unused
#' @S3method boxplot PSAboot
#' @method boxplot PSAboot
#' @export
boxplot.PSAboot <- function(x, ...) {
	sum <- as.data.frame(summary(x))
	p <- ggplot(x$pooled.summary, aes(y=estimate, x=method)) +
		geom_hline(yintercept=0) +
		geom_hline(yintercept=mean) +
		geom_hline(yintercept=mean(x$pooled.summary$estimate), color='blue') +
		geom_errorbar(data=sum, aes(x=method, y=bootstrap.estimate, ymin=bootstrap.ci.min, 
					ymax=bootstrap.ci.max), color='green', width=0.5, size=3) +
		geom_boxplot(alpha=.5) + 
		geom_point(data=sum, aes(y=bootstrap.estimate, x=method), 
				   color='blue', size=5, alpha=.5) +
		geom_point(data=x$complete.summary, aes(y=estimate, x=method), 
				   color='red', size=3, alpha=.5) +
		coord_flip() + xlab('')
	return(p)
}
