#' Stratification using classification trees for bootstrapping.
#' 
#' @inheritParams boot.strata
#' @param minStrata minimum number of treatment or control unitis within a strata 
#'        to include that strata.
#' @return a list with two elements: a named vector (with at minimum estimate, 
#'         ci.min, and ci.max but other values allowd) named summary; and an
#'         arbitrary object named details that contains the full results of the
#'         analysis.
#' @export
boot.rpart <- function(Tr, Y, X, minStrata=5, ...) {
	require(rpart)
	tree <- rpart(treat ~ ., data=cbind(treat=Tr, X))
	strata <- tree$where
	sizes <- melt(table(strata, Tr))
	smallStrata <- sizes[sizes$value < minStrata,]$strata
	if(length(smallStrata) > 0) {
		rows <- !strata %in% smallStrata
		Tr <- Tr[rows]
		Y <- Y[rows]
		X <- X[rows,]
		strata <- strata[rows]
	}
	strata.results <- psa.strata(Y=Y, Tr=Tr, strata=strata, ...)
	return(list(
		summary=c(estimate=strata.results$ATE,
				  ci.min=strata.results$CI.95[1],
				  ci.max=strata.results$CI.95[2],
				  se.wtd=strata.results$se.wtd,
				  approx.t=strata.results$approx.t),
		details=strata.results ))
}
