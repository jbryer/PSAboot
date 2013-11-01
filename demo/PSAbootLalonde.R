require(PSAboot)
data(lalonde, package='MatchIt')

# treat ~ re74 + re75 + educ + black + hispan + age

table(lalonde$treat)
boot.lalonde <- PSAboot(Tr=lalonde$treat, Y=lalonde$re78,
						X=lalonde[,c('re74','re75','educ','black','hispan','age')],
						M=100, seed=2112, parallel=TRUE,
						control.sample.size=185, control.replace=TRUE,
						treated.sample.size=185, treated.replace=TRUE)

summary(boot.lalonde)
plot(boot.lalonde)
hist(boot.lalonde)
boxplot(boot.lalonde)
matrixplot(boot.lalonde)
