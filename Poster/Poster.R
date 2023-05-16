# This script creates the figures and output used for the PSAboot poster located
# at https://github.com/jbryer/PSAboot/Poster

library(PSAboot) # install.packages('PSAboot')
library(psa)     # remotes::install_github('jbryer/psa')

data(tutoring, package = 'TriMatch')

#' Propensity score weighting implementation for bootstrapping.
#' 
#' @inherit boot.strata return params
#' @param estimand which treatment effect to estimate. Values can be ATE, ATT,
#'        ATC, or ATM.
#' @export
boot.weighting <- function(Tr, Y, X, X.trans, formu, estimand = 'ATE', ...) {
	formu.treat <- update.formula(formu, 'treat ~ .')
	df <- cbind(treat = Tr, X)
	ps <- fitted(glm(formu.treat, 
					 data = df, 
					 family = binomial(link = 'logit')))
	
	weights <- psa::calculate_ps_weights(treatment = Tr,
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

tutoring.formu <- treat2 ~ Gender + Ethnicity + Military + ESL + 
	EdMother + EdFather + Age + Employment + Income + Transfer + GPA

tutoring$treat2 <- tutoring$treat != "Control"
covariates <- tutoring[,c("Gender", "Ethnicity", "Military", "ESL",
						  "EdMother", "EdFather", "Age", "Employment",
						  "Income", "Transfer", "GPA")]
tutoring.boot <- PSAboot(Tr = tutoring$treat2,
						 Y = tutoring$Grade,
						 X = covariates,
						 # formu = tutoring.formu,
						 methods = c(getPSAbootMethods(), 'weighting' = boot.weighting),
						 seed = 2112,
						 parallel = FALSE)
ls(tutoring.boot)

summary(tutoring.boot)

plot(tutoring.boot) + xlab('Average Treatment Effect')# + theme_minimal()
ggsave('Poster/treatment_effects.pdf', width = 12, height = 8, units = 'in', dpi = 100)

pdf('Poster/matrixplot.pdf', width = 12, height = 12)
matrixplot(tutoring.boot)
dev.off()

tutoring.balance <- balance(tutoring.boot)
print(tutoring.balance)

plot(tutoring.balance) + theme(legend.position = 'bottom')
ggsave('Poster/balance.pdf', width = 12, height = 8, units = 'in', dpi = 100)

boxplot(tutoring.balance)
ggsave('Poster/balance_boxplot.pdf', width = 12, height = 8, units = 'in', dpi = 100)

boxplot(tutoring.boot)
ggsave('Poster/boxplot.pdf', width = 12, height = 4, units = 'in', dpi = 100)


