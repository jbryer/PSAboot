#' Matching package implementation for bootstrapping.
#' 
#' @param estimand character string for estimand, either ATE, ATT, or ATC. See
#'        \code{\link{Match}} for more details. 
#' @inheritParams boot.strata
#' @export
boot.matching <- function(Tr, Y, X, estimand='ATE', ...) {
	ps <- fitted(glm(treat ~ ., data=cbind(treat=Tr, X), family='binomial'))
	mr <- Match(Y=Y, Tr=Tr,	X=ps, M=1, estimand=estimand, ...)
	ttest <- t.test(Y[mr$index.treated], Y[mr$index.control], paired=TRUE)
	return(list(
		summary=c(estimate=unname(ttest$estimate),
				  ci.min=ttest$conf.int[1],
				  ci.max=ttest$conf.int[2],
				  t=unname(ttest$statistic),
				  p=ttest$p.value ),
		details=list(Match=mr, t.test=ttest)
	))
}
