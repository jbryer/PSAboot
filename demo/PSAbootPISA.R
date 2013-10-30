require(PSAboot)
data(pisausa)
data(pisa.psa.cols)

#NOTE: This is not entirely correct but is sufficient for visualization purposes.
#See mitools package for combining multiple plausible values.
pisausa$mathscore <- apply(pisausa[,paste0('PV', 1:5, 'MATH')], 1, sum) / 5
pisausa$readscore <- apply(pisausa[,paste0('PV', 1:5, 'READ')], 1, sum) / 5
pisausa$sciescore <- apply(pisausa[,paste0('PV', 1:5, 'SCIE')], 1, sum) / 5

levels(pisausa$PUBPRIV)
pisausa$PUBPRIV <- relevel(pisausa$PUBPRIV, ref='Public')

nrow(pisausa)
table(pisausa$PUBPRIV, useNA='ifany')
prop.table(table(pisausa$PUBPRIV, useNA='ifany')) * 100

bm <- PSAboot(Tr=as.integer(pisausa$PUBPRIV) - 1,
			  Y=pisausa$mathscore,
			  X=pisausa[,pisa.psa.cols],
			  control.ratio=4, M=100, seed=2112)

(bootsum <- summary(bm))
as.data.frame(bootsum)

(p <- plot(bm))
(p <- plot(bm, sort='none'))
(p <- plot(bm, sort='Stratification'))
(p <- plot(bm, sort='Matching'))
(p <- plot(bm, sort='MatchIt'))


# Histogram of estimated differences
ggplot(bm$summary, aes(x=estimate)) + 
	geom_vline(xintercept=0) +
	geom_histogram(alpha=.5) + 
	facet_wrap(~ method, ncol=1)

# Boxplot of estimated differences
ggplot(bm$summary, aes(y=estimate, x=method)) + geom_hline(xintercept=0) +
	geom_boxplot(alpha=.5) + coord_flip() + xlab('')

PSAboot.matrix.plot(bm)
