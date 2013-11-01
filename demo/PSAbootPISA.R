require(PSAboot)
data(pisa.psa.cols)

##### United States
data(pisausa)
nrow(pisausa)
table(pisausa$PUBPRIV, useNA='ifany')
prop.table(table(pisausa$PUBPRIV, useNA='ifany')) * 100

bm.usa <- PSAboot(Tr=as.integer(pisausa$PUBPRIV) - 1,
			  Y=pisausa$Math,
			  X=pisausa[,pisa.psa.cols],
			  control.ratio=4, M=100, seed=2112)

(bootsum <- summary(bm.usa))
as.data.frame(bootsum)

(p <- plot(bm.usa))
(p <- plot(bm.usa, sort='none'))
(p <- plot(bm.usa, sort='Stratification'))
(p <- plot(bm.usa, sort='Matching'))
(p <- plot(bm.usa, sort='MatchIt'))

matrixplot(bm.usa)
boxplot(bm.usa)
hist(bm.usa)

##### Luxembourg
data(pisalux)
levels(pisalux$PUBPRIV)

t.test(Math ~ PUBPRIV, data=pisalux)
table(as.integer(pisalux$PUBPRIV) - 1)

bm.lux <- PSAboot(Tr=as.integer(pisalux$PUBPRIV) - 1,
				  Y=pisalux$Math,
				  X=pisalux[,pisa.psa.cols],
				  control.ratio=4, M=100, seed=2112)
summary(bm.lux)
plot(bm.lux)
matrixplot(bm.lux)
boxplot(bm.lux)
hist(bm.lux)
