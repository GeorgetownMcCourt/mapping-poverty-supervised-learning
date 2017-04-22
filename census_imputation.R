
## This .r script takes the models created in the lsms_datacleaning script and imputes them into the census data set 



census <- read_dta("D:/Dropbox/Dropbox/Personal/data_science/assignments/project/et_cen_hh_2007/et_cen_hh_2007.dta")
head(census$et2007a_formtype)
## keep only the observations with the long form questionaire
census <- census[census$et2007a_formtype==2,]