#' MatchIt package implementation for bootstrapping.
#' 
#' @inheritParams boot.strata
#' @export
boot.matchit <- function(Tr, Y, X, X.trans, formu, ...) {
	formu <- update.formula(formu, 'treat ~ .')
	df <- cbind(treat=Tr, X)
	row.names(df) <- 1:nrow(df)
	row.names(X) <- 1:nrow(df)
	row.names(X.trans) <- 1:nrow(df)
	mi <- MatchIt::matchit(formu, data=df, ...)
	df$Y <- Y
	index.treated <- row.names(mi$match.matrix)
	index.control <- mi$match.matrix[,1]
	ttest <- t.test(df[index.treated,]$Y, 
					df[index.control,]$Y, paired=TRUE)
	return(list(
		summary=c(estimate=unname(ttest$estimate),
				  ci.min=ttest$conf.int[1],
				  ci.max=ttest$conf.int[2],
				  t=unname(ttest$statistic),
				  p=ttest$p.value ),
		details=list(MatchIt=mi, t.test=ttest),
		balance=balance.matchit(mi, X.trans)
	))
}

#' Returns balance for each covariate using \code{\link{matchit}}
#' 
#' @param mi the results of \code{\link{matchit}}
#' @param covs data frame or matrix of covariates. Factors should already be recoded.
#'        See \code{\link{cv.trans.psa}}
#' @return a named vector with one element per covariate.
#' @export
balance.matchit <- function(mi, covs) {
	bal <- c()
	index.treated <- row.names(mi$match.matrix)
	index.control <- mi$match.matrix[,1]
	for(covar in names(covs)) {
		cov <- data.frame(Treated=covs[index.treated,covar],
						  Control=covs[index.control,covar])
		ttest <- t.test(cov$Treated, cov$Control, paired=TRUE)
		bal[covar] <- ttest$estimate / sd(c(cov[,1],cov[,2]))
		if(is.nan(bal[covar])) {
			bal[covar] <- NA
		}
	}
	return(bal)
}
