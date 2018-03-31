require(devtools)

document()
check_man()
install(build_vignettes=FALSE)
install()
check(cran=TRUE)
build()
build_vignettes()

release()

##### Data Setup
require(pisa)
require(psych)
require(mice)
data(pisa.student)
data(pisa.school)
source('data/pisa.psa.cols.R')

pisa.student$SCHOOLID <- as.integer(pisa.student$SCHOOLID)
pisa.school$SCHOOLID <- as.integer(pisa.school$SCHOOLID)
pisa <- merge(pisa.student[,c('CNT','SCHOOLID',pisa.psa.cols,
							  paste0('PV', 1:5, 'MATH'),
							  paste0('PV', 1:5, 'READ'),
							  paste0('PV', 1:5, 'SCIE'))], 
			  pisa.school[,c('SCHOOLID','CNT','SC02Q01')], 
			  by=c('CNT','SCHOOLID'), all.x=TRUE)
names(pisa)[ncol(pisa)] <- 'PUBPRIV'

pisa$Math <- apply(pisa[,paste0('PV', 1:5, 'MATH')], 1, mean)
pisa$Reading <- apply(pisa[,paste0('PV', 1:5, 'READ')], 1, mean)
pisa$Science <- apply(pisa[,paste0('PV', 1:5, 'SCIE')], 1, mean)

pisa <- pisa[complete.cases(pisa[,c('Math','Reading','Science','PUBPRIV','CNT')]),]

table(pisa$CNT, pisa$PUBPRIV, useNA='ifany')
prop.table(table(pisa$CNT, pisa$PUBPRIV, useNA='ifany'), 1) * 100
describeBy(pisa$Math, group=list(pisa$PUBPRIV, pisa$CNT), mat=TRUE)[,
									c('group1','group2','n','mean','sd')]

# United States
pisausa <- pisa[which(pisa$CNT == 'United States'),]
t.test(Math ~ PUBPRIV, data=pisalux)
mice.out <- mice(pisausa[,substr(names(pisausa), 1, 2) == 'ST'], m=1)
pisausa[,substr(names(pisausa), 1, 2) == 'ST'] <- complete(mice.out)
save(pisausa, file='PSAboot/Data/pisausa.rda')

# Austria, Canada, Finland, Italy, Japan
# Luxembourg
pisalux <- pisa[which(pisa$CNT == 'Luxembourg'),]
t.test(Math ~ PUBPRIV, data=pisalux)
mice.out <- mice(pisalux[,substr(names(pisalux), 1, 2) == 'ST'], m=1)
pisalux[,substr(names(pisalux), 1, 2) == 'ST'] <- complete(mice.out)
save(pisalux, file='PSAboot/Data/pisalux.rda')

# Italy
pisaita <- pisa[which(pisa$CNT == 'Italy'),]
t.test(Math ~ PUBPRIV, data=pisaita)
table(pisaita$PUBPRIV)
mice.out <- mice(pisaita[,substr(names(pisaita), 1, 2) == 'ST'], m=1)
pisaita[,substr(names(pisaita), 1, 2) == 'ST'] <- complete(mice.out)
save(pisaita, file='PSAboot/Data/pisaita.rda')

# Japan
pisajpn <- pisa[which(pisa$CNT == 'Japan'),]
t.test(Math ~ PUBPRIV, data=pisajpn)
table(pisajpn$PUBPRIV)


tools::resaveRdaFiles('PSAboot/Data/')
