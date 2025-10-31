library(dplyr)
library(tidyverse)
library (broom)
library (matrixStats)
#load data and set gene names solumn to 1 for PCA analysis
Gene_tsv <- read.table("/Users/cmdb/qb25-answers/week6/read_matrix.tsv",
                       row.names=1)

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

#get the top 500 most variable genes 
top_500_matrix <- ordered_sds[1:500,]
glimpse (top_500_matrix)

#invert matrix to run PCA using transpose (t) function 
transposed_500 <- t(top_500_matrix)
head(transposed_500)

#run PCA using prcomp 
pca_500 <- prcomp(transposed_500)
pca_500
head (pca_500)

#plot the first two PCs 