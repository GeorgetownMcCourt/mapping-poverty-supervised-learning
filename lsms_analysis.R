## this .R script creates the World Bank Approach & then uses other data science methods
## Please run lsms_datacleaning.R before using this script 

## crease train and test sets 
  # a random sample of 85 percent of the households 
  lsms$rand <- runif(nrow(lsms)) 
  lsms$test <- ifelse(lsms$rand > 0.85, 1, 0)
  summary(lsms$test) 

  lsms.test <- lsms[lsms$test == 0,]

## Remove all observations with missing values - needed for RF and helpful for lm 
  
  lsms.test <- lsms.test[,c("total_cons_ann", "married_hhead", "adulteq", "hh_size", "female_hhead","hhead_illiterate", "hhead_orthodox", "hhead_protestant", "hhead_islam",  "pipedwater", "unprotectedwater",  "notoilet", "latrine", "flushtoilet", "modernkitchen", "advcookingfuel", "electriclighting", "finishedwalls",  "woodwalls",  "finishedroof",  "finishedfloor", "dirtfloor", "radio", "tv", "saq01", "urban")]
  lsms.test <- lsms.test[complete.cases(lsms.test),]  
    
## kitchen sink approach  
wb.lm1 <-  lm(log(total_cons_ann) ~ married_hhead + adulteq + log(hh_size) + female_hhead + hhead_illiterate+ hhead_orthodox + hhead_protestant + hhead_islam + pipedwater + unprotectedwater +  notoilet + latrine + flushtoilet +  modernkitchen +  advcookingfuel +  electriclighting +  finishedwalls + woodwalls +  finishedroof +  finishedfloor + dirtfloor + radio + tv + radio*tv + factor(saq01) + urban + factor(saq01)*urban, data = lsms.test) 
summary(wb.lm1)

## predict results
lsms.test$total_cons_ann_loggedpredicted <- predict(wb.lm1, lsms.test)
summary(lsms.test$total_cons_ann_loggedpredicted)
lsms.test$total_cons_ann_predicted <- exp(lsms.test$total_cons_ann_loggedpredicted)

# MAPE function 
mape <- function(yhat, y){
  #yhat = your prediction
  #y = original value
  #Note that code will ignore any missing values
  return(100*mean(abs(yhat/y - 1), na.rm=T))
}
mape(lsms.test$total_cons_ann_predicted, lsms.test$total_cons_ann)

## Random Regression Forest
library(randomForest)

                        
                          
  
lsms.rf <- randomForest(total_cons_ann ~ married_hhead + adulteq + hh_size + female_hhead + hhead_illiterate+ hhead_orthodox + hhead_protestant + hhead_islam + pipedwater + unprotectedwater +  notoilet + latrine + flushtoilet +  modernkitchen +  advcookingfuel +  electriclighting +  finishedwalls + woodwalls +  finishedroof +  finishedfloor + dirtfloor + radio + tv + saq01 + urban, type = regression, data = lsms.test, ntree=2000) 

plot(lsms.rf)  
varImpPlot(lsms.rf, sort = TRUE, n.var = 5)

lsms.rf.tune <- tuneRF(lsms.test[,-1], lsms.test$total_cons_ann, ntreeTry = 2000, mtryStart = 1, stepFactor = 2, improve = 0.00001, trace = TRUE, plot = TRUE)

tune.param <- lsms.rf.tune[lsms.rf.tune[, 2] == min(lsms.rf.tune[, 2]), 1]

lsms.rf <- randomForest(total_cons_ann ~ married_hhead + adulteq + hh_size + female_hhead + hhead_illiterate+ hhead_orthodox + hhead_protestant + hhead_islam + pipedwater + unprotectedwater +  notoilet + latrine + flushtoilet +  modernkitchen +  advcookingfuel +  electriclighting +  finishedwalls + woodwalls +  finishedroof +  finishedfloor + dirtfloor + radio + tv + saq01 + urban, type = regression, data = lsms.test, ntree=2000, mtry = tune.param) 


lsms.test$total_cons_ann_rfpredicted <- predict(lsms.rf, lsms.test)

mape(lsms.test$total_cons_ann_rfpredicted, lsms.test$total_cons_ann)

