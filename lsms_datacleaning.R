
# Set working directory 

setwd("D:/Dropbox/Dropbox/Personal/data_science/assignments/project/")

library(haven)
## this is a listing of all household members, and it most data set up to the census 
sect1 <- read_dta("ethiopia_lsms/Household/sect1_hh_w3.dta") 
## keep the most variables I care about 
lsms <- sect1[,c("household_id", "household_id2","hh_s1q08","hh_s1q32_a","hh_s1q03", "saq01", "saq02", "rural", "obs")]
    ## region code - saq01
    ##marital status - hh_s1q08 (have to limit to head)
    ##hh_s1q33 hh_s1q32_a - ecnomic activity (have to limit to head)
    ##hh_s1q03 - sex (have to limit to head of household ) 


## merge on the household consumption  
agg_cons <- read_dta("ethiopia_lsms/Consumption Aggregate/cons_agg_w3.dta")
agg_cons <- agg_cons[,c("household_id", "household_id2", "total_cons_ann", "nom_totcons_aeq")]
lsms <- merge(lsms,agg_cons,by=c("household_id","household_id2"))

## it's key to just use variables that are available in both the LSMS (socioeconomic survey) and the census 

# source of drinking water 
sect9 <- read_dta("ethiopia_lsms/Household/sect9_hh_w3.dta") 
sect9 <- sect9[,c("household_id","household_id2", "hh_s9q13","hh_s9q10","hh_s9q10b","hh_s9q08","hh_s9q21","hh_s9q19_a","hh_s9q05","hh_s9q06","hh_s9q06")]
    ## hh_s9q13 - source of drinking water
    ## hh_s9q10 - toilet type 
    ## hh_s9q10b - shared toilet 
    ## hh_s9q08 - type of kitchen 
    ## hh_s9q21 - cooking fuel
    ## hh_s9q19_a - type of lighting 
    ## hh_s9q05 - wall 
    ## hh_s9q06- roof 
    ## hh_s9q06 - floor 
lsms <- merge(lsms,sect9,by=c("household_id","household_id2"))

## assets 
  # television 
sect10 <- read_dta("ethiopia_lsms/Household/sect10_hh_w3.dta") 
sect10tv <- sect10[sect10$hh_s10q00 == 10,] 
sect10tv <- sect10tv[,c("household_id","household_id2","hh_s10q00", "hh_s10q0a", "hh_s10q01")]
lsms <- merge(lsms,sect10tv,by=c("household_id","household_id2"))
  #radio 
sect10radio <- sect10[sect10$hh_s10q00 == 9,] 
sect10radio <- sect10radio[,c("household_id","household_id2","hh_s10q00", "hh_s10q0a", "hh_s10q01")]
lsms <- merge(lsms,sect10radio,by=c("household_id","household_id2"))

## install.packages("survey")
library("survey")

lsmsmall.w <- svydesign(ids = ~1, data = lsms, weights = lsms$pw_w3)


