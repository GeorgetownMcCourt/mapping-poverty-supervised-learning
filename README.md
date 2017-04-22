# mapping-poverty-supervised-learning
Reexamining World Bank approaches to mapping poverty with supervised learning

## Overview

In the developing world, data are often collected to be representative of the nation or large subnational areas, such as states or provinces. Although these data collection approaches reduce administrative costs, they often cannot provide precise enough estimates at granular geographic levels to target social programs.  

## Background 
In response to this need, the World Bank research department has been conducting a process called [“Poverty Mapping.”](http://econ.worldbank.org/WBSITE/EXTERNAL/EXTDEC/EXTRESEARCH/0,,contentMDK:20699544~pagePK:64214825~piPK:64214943~theSitePK:469382,00.html) Researchers use a survey-to-census imputation model to provide estimates of the proportion of the population living in poverty at more granular geographic levels, such as counties or districts.

This methodology presents several short comings, and it has been the subject of controversy. In 2006, development economists Abhijit Banerjee, Angus Deaton, Nora Lustig, and Ken Rogoff wrote, “The difficult and contentious issue with this work [poverty mapping] is the accuracy of these estimates, and indeed whether they are accurate enough to be useful at all.” 

Still, the World Bank uses this approach. Foremost, the methodology fails to take a scientific approach to prediction. It does not retain any out of sample “test set” to validate the model’s accuracy and the model's calibration is seemingly arbitrary. 

## Research Question and Hypothesis 
This project aims to improve upon the Poverty Mapping methodology. Specifically, it will answer three questions: 
> 1. How accurate is the World Bank’s poverty mapping approach?
> 2. Are there other data science methods that could more accurately predict poverty status than the current poverty mapping approach? 
> 3. If a more accurate approach is identified, does the World Bank methodology lead to prescriptively different decisions for program implementation than the improved approach? 

I hypothesize that the models created by the World Bank methodology make fairly inaccurate predictions of income, and subsequently poverty status. Other approaches to prediction, such as random forests, will be more accurate predictors.        

## Outline of Repository 
### Guide to Answering the Research Questions
To answer these questions, I will focus on Ethiopia. The World Bank classifies Ethiopia as an low income  with about a 37 percent of its population living on less than $2 per day. 

First, I will create a baseline accuracy score by replicating the World Bank methodology, while reserving 15 percent out of the sample for testing. I will score accuracy using the mean absolute percentage error (MAPE) between the predicted and actual income for the reserved sample. The data is free to use with registration here: [2015-2016 Socioeconomic Survey](http://microdata.worldbank.org/index.php/catalog/2783). To see the R code for this step, please see lsms_cleaning and lsms_wbmodel.   

Second, I will use other supervised learning approaches to create alternative methodologies, comparing their accuracy to the World Bank methodology. To see the R code for this step, please see lsms_supervusedlearning. 

Finally, I will use my best supervised learning approach and the poverty mapping model to impute income and/or poverty status into the 2007 census data. [Census data available here](http://microdata.worldbank.org/index.php/catalog/2747) I will then compare if the approaches lead to different prescriptive geogrpahic areas to target for poverty alleviation in Ethiopia. To see the R code for this step, please see census_imputation.

## Results and Conclusions
TO BE ADDED
