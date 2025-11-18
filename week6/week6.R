library(dplyr)
library(tidyverse)
library (broom)
library(ggplot2)
library (matrixStats)
#load data and set gene names solumn to 1 for PCA analysis
Gene_tsv <- read.table("/Users/cmdb/qb25-answers/week6/read_matrix.tsv",
                       row.names=1) #tells R how to read it 
Gene_tsv

#convert to matrix: 
matrix_data <- as.matrix(Gene_tsv)
head(matrix_data)

#find standard deviation for each gene 
sds_genes <- rowSds(matrix_data)
head(sds_genes)

#order in decreasing 
ordered_sds <- matrix_data[order (sds_genes, decreasing = TRUE),]
glimpse (ordered_sds)
head(ordered_sds)

#keep a copy of the full data set 
full_dataset <- matrix_data

full_dataset[,12:13]<- full_dataset[,13:12]
full_dataset

#get the top 500 most variable genes 
top_500_matrix <- ordered_sds[1:500,]
glimpse (top_500_matrix)

#invert matrix to run PCA using transpose (t) function 
transposed_500 <- t(top_500_matrix)
head(transposed_500)
colnames(transposed_500)

#run PCA using prcomp 
pca_500 <- prcomp(transposed_500)
pca_500
head (pca_500)


#plot the first two PCs (pca_500$x are my results). Make a tibble
pc_scores <- as_tibble(pca_500$x[, 1:2], rownames = "Sample")
pc_scores
head(pc_scores)
colnames(pc_scores)

#include legend, use color to denote tissue and point shapes to denote replicate number
#Define tissue and replicate as separate columns to plot 
pc_scores <- pc_scores %>%
  tidyr::separate_wider_delim(Sample,  delim = "_", names= c("Tissue", "Replicate")) # new column names using sample column
head(pc_scores)
pc_scores


ggplot(pc_scores, mapping=aes(x= PC1, y = PC2)) +
  geom_point(size = 3)+
  labs(
    title = "PCA of 500 variable genes",
    x = "PC1",
    y = "PC2"
  )+
  theme_minimal()

#plot it 
ggplot(pc_scores, mapping=aes(x=PC1, y=PC2, color = Tissue, shape = Replicate)) +
geom_point(size = 3)+
  labs(
    title = "PCA of 500 variable genes",
    x = "PC1",
    y = "PC2"
    
  )+
  theme_minimal()
ggsave("/Users/cmdb/qb25-answers/week6/PCA_plot.png")

pc_summary <- summary(pca_500)
pc_summary_table <- t(data.frame(summary(pca_500)$importance))
colnames(pc_summary_table)[colnames(pc_summary_table) == "Proportion of Variance"] <- "prop_var"
pc_summary_table <- cbind(PC = rownames(pc_summary_table), pc_summary_table)
rownames(pc_summary_table) <- 1:nrow(pc_summary_table)

ggplot(data=pc_summary_table, mapping=aes(x=PC, y=prop_var)) +
  geom_bar(stat="identity")
ggsave("/Users/cmdb/qb25-answers/week6/scree_plot.png")

### Exercise 2

combined = full_dataset[,seq(1, 21, 3)]
combined = combined + full_dataset[,seq(2, 21, 3)]
combined = combined + full_dataset[,seq(3, 21, 3)]
combined = combined / 3
combined
stdev <- rowSds(combined)
stdev
filtered_combined <- combined[stdev >1,]
filtered_combined

set.seed(42)
genes <- kmeans(filtered_combined,centers =12, nstart = 100)$cluster
genes

ordered_genes <- order(genes)
ordered_clusters <- genes[ordered_genes]
ordered_clusters

ordered_filtered <- filtered_combined[ordered_genes,]
ordered_filtered

png("/Users/cmdb/qb25-answers/week6/heatmap.png", width=1200, height=1200)
heatmap(ordered_filtered, Rowv=NA, Colv=NA, RowSideColors=RColorBrewer::brewer.pal(12,"Paired")[ordered_clusters], ylab="Gene")
dev.off()

rownames(ordered_filtered)

culster1 <- rownames(ordered_filtered)[ordered_clusters == 1]
culster1
