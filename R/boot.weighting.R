#' Calculates propensity score weights.
#' 
#' @param treatment a logical vector for treatment status.
#' @param ps numeric vector of propensity scores
#' @param estimand character string indicating which estimand to be used. Possible
#'        values are 
#'        ATE (average treatment effect), 
#'        ATT (average treatment effect for the treated), 
#'        ATC (average treatement effect for the controls), 
#'        ATM (Average Treatment Effect Among the Evenly Matchable), 
#'        ATO (Average Treatment Effect Among the Overlap Populatio)
calculate_ps_weights <- function(treatment, ps, estimand = 'ATE') {
	# TODO: this is a copy of a function from the psa package. Use that once it is on CRAN
	weights <- NA
	if(estimand == 'ATE') {
		weights <- (treatment / ps) + ((1 - treatment) / (1 - ps))
	} else if(estimand == 'ATT') {
		weights <- ((ps * treatment) / ps) + ((ps * (1 - treatment)) / (1 - ps))
	} else if(estimand == 'ATC') {
		weights <- (((1 - ps) * treatment) / ps) + (((1 - ps) * (1 - treatment)) / (1 - ps))
	} else if(estimand == 'ATM') {
		weights <- pmin(ps, 1 - ps) / (treatment * ps + (1 - treatment) * (1 - ps))
	} else if(estimand == 'ATO') {
		weights <- (1 - ps) * treatment + ps * (1 - treatment)
	} else {
		stop(paste0('Invalid estimand specified: ', estimand))
	}
	return(weights)
}

#' Propensity score weighting implementation for bootstrapping.
#' 
#' @inherit boot.strata return params
#' @param estimand which treatment effect to estimate. Values can be ATE, ATT,
#'        ATC, or ATM.
#' @importFrom stats quasibinomial binomial lm
#' @export
boot.weighting <- function(Tr, Y, X, X.trans, formu, estimand = 'ATE', ...) {
	formu.treat <- update.formula(formu, 'treat ~ .')
	df <- cbind(treat = Tr, X)
	ps <- fitted(glm(formu.treat, 
					 data = df, 
					 family = binomial(link = 'logit')))
	
	weights <- calculate_ps_weights(treatment = Tr,
										 ps = ps,                          
										 estimand = estimand)
	
	X.trans.scaled <- lapply(X.trans, scale) |> as.data.frame()
	X.trans.scaled$treat <- Tr
	lm_balance <- glm(treat ~ .,
					  data = X.trans.scaled,
					  family = quasibinomial(link = 'logit'),
					  weights = weights) |> summary()
	
	te_lm <- lm(formula = Y ~ treat, 
				data = data.frame(Y = Y, treat = Tr),
				weights = weights) |> summary()
	
	se <- te_lm$coefficients[2,]['Std. Error'] |> unname()
	te <- te_lm$coefficients[2,]['Estimate'] |> unname()
	
	return(list(
		summary = c(estimate = te,
					ci.min = te - 1.96 * se,
					ci.max = te + 1.96 * se,
					se.wtd = se,
					approx.t = unname(te_lm$coefficients[2,]['t value'])),
		details = te_lm,
		balance = lm_balance$coefficients[,'Estimate'][-1]
	))
}
