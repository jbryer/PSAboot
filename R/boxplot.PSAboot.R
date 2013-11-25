utils::globalVariables(c('estimate','method','bootstrap.estimate','bootstrap.ci.min',
						 'bootstrap.ci.max','variable'))

#' Boxplot of PSA boostrap results.
#' 
#' @param x result of \code{\link{PSAboot}}.
#' @param ... unused
#' @S3method boxplot PSAboot
#' @method boxplot PSAboot
#' @export
boxplot.PSAboot <- function(x, ...) {
	sum <- as.data.frame(summary(x))
	pooled.mean <- mean(x$pooled.summary$estimate, na.rm=TRUE)
	pooled.sd <- sd(x$pooled.summary$estimate, na.rm=TRUE)
	pooled.ci <- c(ci.min=pooled.mean - (qnorm(0.975) * pooled.sd/sqrt(x$M)),
				   ci.max=pooled.mean + (qnorm(0.975) * pooled.sd/sqrt(x$M)))
	p <- ggplot(x$pooled.summary, aes(y=estimate, x=method)) +
		geom_hline(yintercept=0, alpha=.5, size=2) +
		geom_hline(yintercept=pooled.ci, color='green') + 
		geom_hline(yintercept=pooled.mean, color='blue') +
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
