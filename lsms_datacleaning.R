
# Set working directory 

setwd("D:/Dropbox/Dropbox/Personal/data_science/assignments/project/")

library(haven)
## merge on the household consumption  
agg_cons <- read_dta("ethiopia_lsms/Consumption Aggregate/cons_agg_w3.dta")
## agg_cons <- agg_cons[,c("household_id", "household_id2", "total_cons_ann", "nom_totcons_aeq", "saq01", "rural")]
agg_cons$urban <- ifelse(agg_cons$rural %in% 2:3, 1, 0)


## this is a listing of all household members, here we'll get data on the household head 
sect1 <- read_dta("ethiopia_lsms/Household/sect1_hh_w3.dta") 
    ## region code - saq01
    ##marital status - hh_s1q08 (have to limit to head)
    ##hh_s1q03 - sex (have to limit to head of household ) 
    ## hh_s1q07 - religion 

sect1_hhead <- sect1[which(sect1$hh_s1q02 == 1),]
sect1_hhead <- sect1_hhead[,c("household_id", "household_id2", "hh_s1q08", "hh_s1q02", "hh_s1q32_b", "hh_s1q03","hh_s1q07", "individual_id", "individual_id2")]
## married household head 
  sect1_hhead$married_hhead <- 0 
  sect1_hhead$married_hhead <- ifelse(sect1_hhead$hh_s1q08 %in% 2:3, 1, 0)
  summary(sect1_hhead$married_hhead) 
## gender of head of household 
  sect1_hhead$female_hhead <- ifelse(sect1_hhead$hh_s1q03 == 2, 1, 0)
  summary(sect1_hhead$female_hhead)
  ## relgiion 
  sect1_hhead$hhead_orthodox <- ifelse(sect1_hhead$hh_s1q07 == 1, 1, 0) 
  sect1_hhead$hhead_protestant <- ifelse(sect1_hhead$hh_s1q07 == 3, 1, 0) 
  sect1_hhead$hhead_islam <- ifelse(sect1_hhead$hh_s1q07 == 4, 1, 0) 
  
  
## head of household illiterate  
  sect1_sondaughter <- sect1[which(sect1$hh_s1q02 == 2),]
  sect1_hhhead_gender<- sect1_hhead[,c("household_id", "household_id2", "female_hhead")]
  sect1_sondaughter<- merge(sect1_sondaughter, sect1_hhhead_gender, by=c("household_id","household_id2"))
    sect1_sondaughter$hhead_illiterate <- ifelse(sect1_sondaughter$hh_s1q15 == 98,1,0)
    sect1_sondaughter$hhead_illiterate <- ifelse(sect1_sondaughter$female_hhead == 1 & sect1_sondaughter$hh_s1q19 == 98,1,sect1_sondaughter$hhead_illiterate)
  summary(sect1_sondaughter$hhead_illiterate)
  sect1_sondaughter<- sect1_sondaughter[,c("household_id", "household_id2", "hhead_illiterate")]   
  sect1_hhead <- merge(sect1_hhead,sect1_sondaughter,by=c("household_id","household_id2"), all.x = TRUE)
    ## assuming not illerate, if not children to prove that they are illiterate
  sect1_hhead$hhead_illiterate[is.na(sect1_hhead$hhead_illiterate)] <- 0
  summary(sect1_hhead$hhead_illiterate) 

  
  ## merge these household head variables onto the household member roster
  lsms <- merge(agg_cons,sect1_hhead,by=c("household_id","household_id2"))
  
## it's key to just use variables that are available in both the LSMS (socioeconomic survey) and the census 

# source of drinking water 
sect9 <- read_dta("ethiopia_lsms/Household/sect9_hh_w3.dta") 
sect9 <- sect9[,c("household_id","household_id2", "hh_s9q13","hh_s9q10","hh_s9q10b","hh_s9q08","hh_s9q21","hh_s9q19_a","hh_s9q05","hh_s9q06","hh_s9q07")]
## hh_s9q13 - source of drinking water
sect9$pipedwater <- ifelse(sect9$hh_s9q13 %in% 1:3, 1, 0) 
summary(sect9$pipedwater)

sect9$surfacewater <- ifelse(sect9$hh_s9q13 == 14, 1, 0) 
summary(sect9$surfacewater)

sect9$unprotectedwater <- ifelse(sect9$hh_s9q13 == 6, 1, 0) 
sect9$unprotectedwater <- ifelse(sect9$hh_s9q13 == 9, 1, sect9$unprotectedwater) 
summary(sect9$unprotectedwater)


## hh_s9q10 - toilet type 
sect9$notoilet <- ifelse(sect9$hh_s9q10 == 7, 1, 0) 
sect9$flushtoilet <- ifelse(sect9$hh_s9q10 == 1, 1, 0) 
sect9$latrine <- ifelse(sect9$hh_s9q10 %in% 2:4, 1, 0) 

summary(sect9$notoilet)

## hh_s9q10b - shared toilet 
sect9$sharedtoilet <- ifelse(sect9$hh_s9q10b == 2, 0, sect9$hh_s9q10b) 
summary(sect9$sharedtoilet)

## hh_s9q08 - type of kitchen 
sect9$modernkitchen <- ifelse(sect9$hh_s9q08 %in% 4:5, 1, 0) 
summary(sect9$modernkitchen)

## hh_s9q21 - cooking fuel
sect9$advcookingfuel <- ifelse(sect9$hh_s9q21 %in% 7:10, 1, 0) 
summary(sect9$advcookingfuel)

sect9$firewood <- ifelse(sect9$hh_s9q21 == 1, 1, 0) 
summary(sect9$firewood)

## hh_s9q19_a - type of lighting 
sect9$electriclighting <- ifelse(sect9$hh_s9q19_a %in% 1:4, 1, 0) 
summary(sect9$electriclighting)

sect9$kerosenelighting <- ifelse(sect9$hh_s9q19_a %in% 8:9, 1, 0) 
summary(sect9$kerosenelighting)

## hh_s9q05 - wall 
sect9$finishedwalls <- ifelse(sect9$hh_s9q05 %in% c(6, 7, 11, 14:17), 1, 0) 
summary(sect9$finishedwalls)

sect9$woodwalls <- ifelse(sect9$hh_s9q05 %in% 1:3, 1, 0) 
summary(sect9$woodwalls)


## hh_s9q06- roof 
sect9$finishedroof <- ifelse(sect9$hh_s9q06 %in% c(1, 2, 7, 8), 1, 0) 
summary(sect9$finishedroof)

## hh_s9q07 - floor 
sect9$finishedfloor <- ifelse(sect9$hh_s9q07 %in% c(4:9), 1, 0) 
summary(sect9$finishedfloor)

sect9$dirtfloor <- ifelse(sect9$hh_s9q07 == 1, 1, 0) 
summary(sect9$dirtfloor)

sect9 <- sect9[,c("household_id","household_id2", "pipedwater", 
                  "notoilet", "sharedtoilet", "modernkitchen", "advcookingfuel", "electriclighting", "finishedwalls", "finishedroof", "finishedfloor", "dirtfloor", "surfacewater", "unprotectedwater", "kerosenelighting", "firewood", "latrine", "flushtoilet", "woodwalls")]

lsms <- merge(lsms,sect9,by=c("household_id","household_id2"))

## assets 
  # television 
sect10 <- read_dta("ethiopia_lsms/Household/sect10_hh_w3.dta") 
sect10tv <- sect10[sect10$hh_s10q00 == 10,] 
sect10tv <- sect10tv[,c("household_id","household_id2","hh_s10q00", "hh_s10q0a", "hh_s10q01")]
lsms <- merge(lsms,sect10tv,by=c("household_id","household_id2"))
lsms$tv <- ifelse(lsms$hh_s10q01 >0, 1, 0)

  #radio 
sect10radio <- sect10[sect10$hh_s10q00 == 9,] 
sect10radio <- sect10radio[,c("household_id","household_id2","hh_s10q00", "hh_s10q0a", "hh_s10q01")]
sect10radio$radio <- ifelse(sect10radio$hh_s10q01 >0, 1, 0)
lsms <- merge(lsms,sect10radio,by=c("household_id","household_id2"))

