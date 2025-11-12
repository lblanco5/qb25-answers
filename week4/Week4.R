library(dplyr)
library(tidyverse)
library (broom) #will tidy up my results, tidies up model/objects into tidy tibbles (data frames)
DNM_data <-read_csv("/Users/cmdb/qb25-answers/week4/aau1043_dnm.csv") #load into a tibble using read.csv, this file has the de novo mutations found in different probands/offspring. 
age_data <- read_csv("/Users/cmdb/qb25-answers/week4/aau1043_parental_age.csv") # also a tibble
head (DNM_data)
dnm_counts <- DNM_data %>% group_by(Proband_id) %>% #get the number of DNMS from teach parent per proband, all probands that re the same are treated as ONE group.
  summarise (father_sum = sum(Phase_combined== "father", na.rm = TRUE), #counts the DNMs inherited from the father, TRUE (na.rm) means any missing values wll be ignored at the count. 
    mother_sum = sum (Phase_combined == "mother", na.rm = TRUE)) #counts the DNMs inherited from the mother
#merge counts with ages using age_data, u wanna match the proband IDs to the parental age. 
head (age_data) #merge function keeps only data that are in both tibbles
merge_data <- merge(dnm_counts,age_data, by = "Proband_id")
head(merge_data)
#materal DNM vs maternal age: 
ggplot (data = merge_data,
        aes(x = Mother_age, y = mother_sum))+
  geom_point()+
  labs (
    title = "Maternal DNMs vs Maternal Age",
    x = "Maternal Age",
    y = "Maternal DNMs"
  )+
  theme_minimal()
ggsave("/Users/cmdb/qb25-answers/week4/ex2_a.png", width = 10)
#labs adds specficiations to the graph
#/Users/cmdb/qb25-answers/week4

ggplot (data = merge_data,
        aes(x = father_sum, y = Father_age))+
  geom_point(color = "red")+
  labs (
    title = "Paternal DNMs vs Paternal Age",
    x = "Patneral DNMs",
    y = "Paternal Age"
  ) +
  theme_minimal()
merge_data
ggsave("/Users/cmdb/qb25-answers/week4/ex2_b.png", width = 10)


# how does the DNM sum of mother change across maternal age
linear_maternal <- lm(mother_sum ~ Mother_age, data = merge_data)
summary(linear_maternal) 
# add result to readme.md 

linear_paternal <- lm(father_sum ~ Father_age, data = merge_data)
summary(linear_paternal) 
#add result to readme.md

#use results from linear_paternal regression model to predict the expected number or parental DNMs for a father 50.5
#predict(linear_paternal, newdata=Father_age = 5 DNV = Y X = AGE 
new_obs <-tibble (Father_age = 50.5) #single observatim, one column one value
predict (linear_paternal, newdata = new_obs)
#78.69546 


#compare the distributions of maternal vs paternal DNMs; plot both distributions on the same axes as semi transparent histograms. 

glimpse(merge_data)

wide_data <- merge_data 
long_data <- wide_data %>%
  pivot_longer (
    cols = c(father_sum, mother_sum),
             names_to = "parent", 
             values_to = "DNM"
  )
  print(long_data)
  
ggplot (data = long_data,aes (x = DNM, fill = parent)) +
  geom_histogram(alpha = 0.7, bins = 200) +
labs(title = "Maternal and Paternal DNMs", 
     x = "DNMs", 
     y = "Count")+
  theme_minimal()
ggsave("/Users/cmdb/qb25-answers/week4/ex2_c.png")


#step 2.6 statistical test maternal vs paternal DNMs per proband
t.test(merge_data$mother_sum, merge_data$father_sum, paired = TRUE)

#fit the model using lm () to compare to t test results
merge_data$diff_DNMs <- merge_data$mother_sum - merge_data$father_sum 
lm <- lm(diff_DNMs ~1, data = merge_data)
summary(lm)

#-39, same result as the t test result, same significance too


#exercise 3: explore a new datset 
pokemon_df <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-04-01/pokemon_df.csv')
head(pokemon_df)
summary(pokemon_df)

#weight vs base experience
ggplot(pokemon_df, aes(x = weight, y = base_experience))+
  geom_point(alpha = 0.6) + 
  labs(title = "Weight vs Base Experience",
       x = "Weight",
       y = "Base Experience")+
  theme_minimal()
ggsave("/Users/cmdb/qb25-answers/week4/pokemon1.png")

lm1 <- lm(base_experience ~ weight, data = pokemon_df)
summary(lm1)

#attack vs defense 
ggplot(pokemon_df, aes(x = attack, y = defense, color= type_1))+
  geom_point(alpha = 0.6) + 
  labs(title = "Attack v Defense",
       x = "Attack",
       y = "Defense")+
  theme_minimal()
ggsave("/Users/cmdb/qb25-answers/week4/pokemon2.png")

lm2 <- lm(attack ~ defense, data = pokemon_df)
summary(lm2)







