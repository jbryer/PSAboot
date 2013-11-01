#' MatchIt package implementation for bootstrapping.
#' 
#' @inheritParams boot.strata
#' @export
boot.matchit <- function(Tr, Y, X, formu, ...) {
	formu <- update.formula(formu, 'treat ~ .')
	df <- cbind(treat=Tr, X)
	mi <- matchit(formu, data=df)
	df$Y <- Y
	ttest <- t.test(df[row.names(mi$match.matrix),]$Y, 
					df[mi$match.matrix,]$Y, paired=TRUE)
	return(list(
		summary=c(estimate=unname(ttest$estimate),
				  ci.min=ttest$conf.int[1],
				  ci.max=ttest$conf.int[2],
				  t=unname(ttest$statistic),
				  p=ttest$p.value ),
		details=list(MatchIt=mi, t.test=ttest)
	))
}
