Load tidyverse
tidyverse
install.packages("tidyverse")

library(tidyverse)
header <- c( "chr", "start", "end", "count" )
df_kc <- read_tsv("/Users/cmdb/qb25-answers/week1/hg19-kc-count.bed", col_names=header)
df_kc %>%
ggplot(aes(x = start, y = count))+
  geom_line()+
  facet_wrap("chr", scales = "free")
ggsave( "/Users/cmdb/qb25-answers/week1/exercise1.png" )
  
  