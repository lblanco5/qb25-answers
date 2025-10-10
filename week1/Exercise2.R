library(dplyr)
library(tidyverse)
setwd ('/Users/cmdb/qb25-answers/week1')
header <- c( "chr", "start", "end", "count" )
df_19 <-read_tsv("hg19-kc-count.bed", col_names=header)
df_16 <-read_tsv("hg16-kc-count.bed", col_names=header)
df_1619 <-bind_rows( hg19=df_19, hg16=df_16, .id="assembly" )
df_plot <- ggplot(df_1619, aes(x = start, y = count, color = assembly))+
  geom_line()+
  facet_wrap(~chr, scales ="free")
ggsave("excersise2.png", plot = df_plot)



