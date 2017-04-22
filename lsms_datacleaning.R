library(haven)
lsms <- read_dta("D:/Dropbox/Dropbox/Personal/data_science/assignments/project/ethiopia_lsms/Household/sect1_hh_w3.dta") 


census$urban <- factor(census$et2007a_urban,
                       levels = c(1, 2),
                       labels = c("Urban", "Rural"))

install.packages("survey")
library("survey")

lsmsmall.w <- svydesign(ids = ~1, data = lsms, weights = lsms$pw_w3)

head(census$et2007a_urban) 
table(census$et2007a_urban)
207467/1094349 

head(lsms$rural)
lsms$urban <-  ifelse(lsms$rural == 1, 2, 1)
lsms$urban <- factor(lsms$urban,
                     levels = c(1, 2),
                     labels = c("Urban", "Rural"))
