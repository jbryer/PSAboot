require(TriMatch)
require(PSAboot)
data(tutoring, package='TriMatch')

tutoring$treatbool <- tutoring$treat != 'Control'
covs <- tutoring[,c('Gender', 'Ethnicity', 'Military', 'ESL', 'EdMother', 'EdFather',
					'Age', 'Employment', 'Income', 'Transfer', 'GPA')]
Y  <- tutoring$Grade
Tr <- tutoring$treatbool

table(tutoring$treatbool)
tutoring.boot <- PSAboot(Tr=Tr, Y=Y, X=covs, seed=2112,
						 control.sample.size=918, control.replace=TRUE,
						 treated.sample.size=224, treated.replace=TRUE)
summary(tutoring.boot)
as.data.frame(summary(tutoring.boot))
plot(tutoring.boot)
boxplot(tutoring.boot)
matrixplot(tutoring.boot)

tutoring.bal <- balance(tutoring.boot)
tutoring.bal
plot(tutoring.bal)
boxplot(tutoring.bal)

# Details are available within the returned object
tutoring.bal$unadjusted
tutoring.bal$complete
tutoring.bal$pooled


