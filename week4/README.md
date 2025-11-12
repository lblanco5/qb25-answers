Interpretation 2.2
Estimate Std. Error t value Pr(>|t|)    
(Intercept)  2.50402    0.98064   2.553    0.011 *  
Mother_age   0.37757 

each year of maternal agea adds 0.3 maternal DNMs 
p value <2e-16 *** very significant 

Interpretation 2.3 

Estimate Std. Error t value Pr(>|t|)    
(Intercept) 10.32632    1.70235   6.066 3.08e-09 ***
Father_age   1.35384    0.05353  25.291  < 2e-16 ***

each year of patenal age adds 1.3 paternal DNMs
< 2e-16 *** very significant


step 2.4 

use results from linear_paternal regression model to predict the expected number or parental DNMs for a father 50.5
predict(linear_paternal, newdata=Father_age = 5 DNV = Y X = AGE 
new_obs <-tibble (Father_age = 50.5) #single observatim, one column one value
predict (linear_paternal, newdata = new_obs)
#78.69546 


Step 2.6 statisticsl test maternal vs paternal DNMs per proband
results: 
Paired t-test

data:  merge_data$mother_sum and merge_data$father_sum
t = -61.609, df = 395, p-value < 2.2e-16
alternative hypothesis: true mean difference is not equal to 0
95 percent confidence interval:
 -40.48685 -37.98284
sample estimates:
mean difference 
      -39.23485 --> paternal DNMs are 39x higher than maternal DNMs, correlated with my plot, where paternal DNMs were higher than maternal 
      p-value < 2.2e-16 indicates very significant difference between maternal and paternal 
      p value is the probability of obtaining the result you had by random chance 
      
      
      picked pokemon dataset 
      
      
Predicting base experience from weight     
lm(formula = base_experience ~ weight, data = pokemon_df)

Coefficients:
             Estimate Std. Error t value Pr(>|t|)    
(Intercept) 133.70995    2.60066   51.41   <2e-16 ***
weight        0.25322    0.01899   13.34   <2e-16 ***
 there is a significant poitve relationship between base experience and weight 
      
      
 
 
 Predicting attack from defense     
Call:
lm(formula = attack ~ defense, data = pokemon_df)

Coefficients:
            Estimate Std. Error t value Pr(>|t|)    
(Intercept) 45.65571    2.43082   18.78   <2e-16 ***
defense      0.45657    0.03031   15.06   <2e-16 ***
There i a sifnificant positive relationship between attack and defense 

      
      
