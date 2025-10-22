#' Returns a summary of the balance for all bootstrap samples.
#' 
#' This method provides some crude overall measures of balance. 
#' 
#' @param psaboot results from `[PSAboot()]`.
#' @param na.rm should NAs be removed. NAs generally occur when there is insufficient
#'        sample for a particular covariate or an unused level.
#' @param pool.fun a function specifying how the effect sizes across all covariates
#'        should be combined. Possible values include `mean()` (default),
#'        `q25()`, `q75()`, `median()`, `max()`, or 
#'        any function that takes a vector of numeric values.
#' @return a list with three elements:
#' \describe{
#' 	\item{unadjusted}{named numeric vector with unadjusted effect size before
#' 	                  adjustment for each covariate}
#' 	\item{complete}{a matrix with adjusted effect size for each covariate (columns)
#' 	                for each method (rows).}
#' 	\item{pooled}{a matrix with mean adjusted effect size for all covariates for each
#' 	              method (columns) and each bootstrap sample (rows).}
#' 	\item{balances}{a list with an M x n covariates matrix for each method.}
#' }
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
#' 
#' }
#' @export
balance <- function(psaboot, na.rm = TRUE, pool.fun = mean) {
	if('factor' %in% sapply(psaboot$X, class)) {
		X.trans <- cv.trans.psa(psaboot$X)[[1]]
	} else {
		X.trans <- psaboot$X
	}
	Tr <- psaboot$Tr
	
	bal.unadj <- c()
	for(i in names(X.trans)) {
		# ttest <- t.test(cov ~ treat, data=cbind(treat=Tr, cov=X.trans[,i]), paired=FALSE)
		ttest <- t.test(X.trans[,i,drop=TRUE], Tr, paired = FALSE)
		bal.unadj[i] <- abs(diff(ttest$estimate) / sd(X.trans[,i]))
	}

	index.balance <- which(substr(names(psaboot$complete.details), 1, 8) == 'balance.')
	index.names <- substr(names(psaboot$complete.details)[index.balance], 9, 
						  max(nchar(names(psaboot$complete.details))))
	bal_names <- names(psaboot$complete.details[[ index.balance[1] ]])
	bal <- c()
	for(i in index.balance) {
		bal <- rbind(bal, psaboot$complete.details[[ i ]][bal_names])
	}
	bal <- abs(bal)
	dimnames(bal)[[1]] <- index.names
	
	boot.bal <- matrix(rep(as.numeric(NA), psaboot$M * length(index.names)), 
					   nrow=psaboot$M, ncol=length(index.names),
					   dimnames=list(1:psaboot$M, index.names))
	balances <- list()
	for(j in index.names) {
		balances[[j]] <- c()
	}
	for(i in 1:psaboot$M) {
		index.balance <- which(substr(names(psaboot$pooled.details[[i]]), 1, 8) == 'balance.')
		index.names <- substr(names(psaboot$pooled.details[[i]])[index.balance], 9, 
							  max(nchar(names(psaboot$pooled.details[[i]]))))
		for(j in seq_along(index.balance)) {
			balances[[index.names[j]]] <- rbind(balances[[index.names[j]]], 
								   abs(psaboot$pooled.details[[i]][[ index.balance[j] ]]))
			boot.bal[i,index.names[j]] <- pool.fun(abs(
				psaboot$pooled.details[[i]][[ index.balance[j] ]]), 
											   na.rm=na.rm)
		}
	}
	
	results <- list()
	results$complete <- abs(bal)
	results$pooled <- abs(boot.bal)
	results$unadjusted <- abs(bal.unadj)
	results$balances <- balances
	results$pool.fun <- pool.fun
	class(results) <- 'PSAboot.balance'
	return(results)
}
