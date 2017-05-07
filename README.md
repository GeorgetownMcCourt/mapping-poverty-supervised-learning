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
> 3.  How do the methods’ accuracy impact the calculation of the number of poor households?

I find that models created by the World Bank methodology make fairly inaccurate predictions of income, and subsequently poverty status. In this work, other approaches to prediction, such as decision trees and random forests, do not create more accurate predictions.

The outline of this report is as follows. First, I will create a baseline accuracy score by replicating the World Bank methodology, while reserving 15 percent of the sample for testing The data is semi-public with registration here: Ethiopia Socioeconomic Survey 2015-2016. Second, I will use other supervised learning approaches to create alternative methodologies, comparing their accuracy to the World Bank methodology. Finally, I conclude by comparing the differences in the size of the “poor” population in the eleven regions of Ethiopia.

## Results and Conclusions
After recreating the methodology on annual consumption data, I found a fairly large mean absolute percent error of 48 in the out-of-sample test. This is substantial error in the prediction. This confirms somewhat the criticism that the approach may not be accurate enough to be useful. In the future, researchers conducting poverty mapping should preserve some sample out of the models to rigorously assess how accurate the model is at predicting poverty.

I then sought to apply supervised learning to create more accurate predictions, namely regression decision trees and regression random forests. Both of these methods showed little improvement over the World Bank’s methodology.

Finally, I sought to classify if a household was poor or not. The World Bank approach found a mean F1 score of 72 on the out-of-sample test. The regression forest found a mean F1 score of 64 on the out-of-sample score. Again, both of these are not particularly accurate predictors of household poverty status.

These classification models were then applied to calculate how many poor households were in each of the eleven regions of Ethiopia. On average the World Bank OLS model was off by 96,000 households, while the random forest was off by 86,000. 100,000 households is quite substantial error.

This work shows that the model matters in classifying poverty and predict total aggregate consumption. None of the models tested in this project are particularly accurate, including the World Bank’s current methodology.

Important policy decisions, such as the allocation of scare national and international development funds, are allocated sub nationally based on the distribution of poverty. Researchers need to recommit themselves to establish more robust methods to map poverty. Although the supervised learning techniques tried here are not vast improvements over the current methodology, researchers should not abandon them in their search for more accurate ways to map poverty.
