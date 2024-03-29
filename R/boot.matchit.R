#' MatchIt package implementation for bootstrapping.
#' 
#' @inheritParams boot.strata
#' @return a list with three elements:
#'         \describe{
#'         \item{\code{summary}}{a named numeric vector (with at minimum \code{estimate}, 
#'         \code{ci.min}, and \code{ci.max} but other values allowed)}
#'         \item{\code{balance}}{a named numeric vector with one element per 
#'         covariate listed in \code{X.trans} representing a balance statistic 
#'         (usually standardized effect size after adjustment)}
#'         \item{\code{details}}{an arbitrary object that contains the full results of the
#'         analysis}
#'         }
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
		balance=balance.matching(row.names(mi$match.matrix), mi$match.matrix[,1], X.trans)
	))
}
