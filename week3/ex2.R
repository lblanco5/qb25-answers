setwd("/Users/cmdb/qb25-answers/week3")
library (tidyverse)
AF_file <-read_tsv("/Users/cmdb/qb25-answers/week3/AF.txt", col_names = FALSE)
ggplot(data = AF_file, aes(x = X1)) + 
  geom_histogram (bins = 11) + xlab("AF") + ylab ("counts")
ggsave ("AF.png")

setwd("/Users/cmdb/qb25-answers/week3")
library (tidyverse)
AF_file <-read_tsv("/Users/cmdb/qb25-answers/week3/DP.txt", col_names = FALSE)
ggplot(data = AF_file, aes(x = X1)) + 
  geom_histogram (bins = 21) + xlab("DP") + ylab ("counts")+ 
  xlim(0,20)
ggsave ("DP.png")







