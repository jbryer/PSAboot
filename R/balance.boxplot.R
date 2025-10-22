#' Boxplot of the balance statistics for bootstrapped samples.
#' 
#' @param x results of `[balance()]`
#' @param unadjusted.color the color used for the unadjusted effect size.
#' @param pooled.color the color used for the mean bootstrap effect size.
#' @param point.size the size of the points.
#' @param point.alpha the transparency level for the points.
#' @param ... other parameters passed to `[facet_wrap()]`
#' @return a ggplot2 expression.
#' @export 
#' @examples
#' \donttest{
#' library(PSAboot)
#' data(pisa.psa.cols)
#' data(pisausa)
#' bm.usa <- PSAboot(Tr = as.integer(pisausa$PUBPRIV) - 1,
#'     Y = pisausa$Math,
#'     X = pisausa[,pisa.psa.cols],
#'     control.ratio = 5, M = 100, seed = 2112)
#' bm.usa.bal <- balance(bm.usa)
#' boxplot(bm.usa.bal, nrow = 1)
#' }
boxplot.PSAboot.balance <- function(x, 								 
									unadjusted.color = 'red',
									pooled.color = 'blue',
									point.size = 3, 
									point.alpha = .5, 
									...) {
	combined <- data.frame()
	for(i in seq_along(x$balances)) {
		method <- names(x$balances)[i]
		tmp <- as.data.frame(x$balances[[i]])
		tmp$Method <- method
		if(nrow(combined) == 0) {
			combined <- tmp
		} else {
			missing_vars <- names(combined)[!names(combined) %in% names(tmp)]
			for(i in missing_vars) {
				tmp[,i] <- NA
			}
			combined <- rbind(combined, tmp[,names(combined)])
		}
	}
	tmp <- reshape2::melt(combined, id='Method')
	tmp2 <- as.data.frame(x$unadjusted)
	names(tmp2) <- 'value'
	tmp2$variable <- row.names(tmp2)
	tmp3 <- psych::describeBy(tmp$value, 
							  group = list(tmp$Method, tmp$variable), 
							  mat = TRUE, skew = FALSE)
	tmp3 <- tmp3[,c('group1', 'group2', 'mean')]
	names(tmp3) <- c('Method', 'variable', 'value')
	p <- ggplot(tmp, aes(x=variable, y=value)) + 
		geom_boxplot() + 
		geom_point(data=tmp2, color=unadjusted.color, 
				   size=point.size, alpha=point.alpha) +
		geom_point(data=tmp3, color=pooled.color, 
				   size=point.size, alpha=point.alpha) +
		facet_wrap(~ Method, ...) + coord_flip() + 
		xlab('Covariate') + ylab('Balance (Effect Size)')
	return(p)
}
