setwd("/Users/cmdb/qb25-answers/week3")
library (tidyverse)
AF_file <-read_tsv("/Users/cmdb/qb25-answers/week3/gt_long.txt", col_names = FALSE)
ggplot(data = AF_file %>% filter(!is.na(X4),X1 == "A01_62", X2 == "chrII"), 
       aes(x = X3, y = X2, color = factor(X4))) +
  geom_point()



ggplot(data = AF_file %>% filter(!is.na(X4),X1 == "A01_62"), 
       aes(x = X3, y = X1, color = factor(X4))) +
  geom_point()+
  facet_grid(X2 ~.,scales = "free_x",space = "free_x")

ggplot(data = AF_file %>% filter(!is.na(X4)), 
       aes(x = X3, y = X1, color = factor(X4))) +
  geom_point()+
  facet_grid(.~X2,scales = "free_x",space = "free_x")

  
  
  #!is.na means eveyrhtin that is NA inside X4 
