# This script creates the figures and output used for the PSAboot poster located
# at https://github.com/jbryer/PSAboot/Poster

library(PSAboot) # remotes::install_github('jbryer/PSAboot') # Development version
library(psa)     # remotes::install_github('jbryer/psa')     # Not on CRAN yet

data(tutoring, package = 'TriMatch')

tutoring.formu <- treat2 ~ Gender + Ethnicity + Military + ESL + 
	EdMother + EdFather + Age + Employment + Income + Transfer + GPA

tutoring$treat2 <- tutoring$treat != "Control"
covariates <- tutoring[,all.vars(tutoring.formu)[-1]]
tutoring.boot <- PSAboot(Tr = tutoring$treat2,
						 Y = tutoring$Grade,
						 X = covariates,
						 # formu = tutoring.formu,
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
