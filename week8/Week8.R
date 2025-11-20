library(DESeq2)
library(dplyr)
library (broom)
library(ggplot2)
library(tidyverse)
library (matrixStats)

setwd("/Users/cmdb/qb25-answers/week8")

#make data into tibbles/dataframes

gene_locations_df <- read_delim("gene_locations.txt") #gene expression matrix
gene_counts_df <- read_delim("gtex_whole_blood_counts_downsample.txt") #metadata sample info
gtex_metadata_df <- read_delim("gtex_metadata_downsample.txt")

#individuls are in columns and genes are in rows. Store gene names as rownames since DEseq2 expects the data to be numeric
gene_counts_corrected <- column_to_rownames(gene_counts_df, var = "GENE_NAME")
head(gene_counts_corrected)

#step 1.2: Create a DESeq2 Object

#check that columns of the row matrix and rows of the column data are in the same order. 
table(colnames(gene_counts_corrected) == rownames(gtex_metadata_df))
head(colnames(gene_counts_corrected))
head(rownames(gtex_metadata_df))
# came back false 
gtex_metadata_corrected <- column_to_rownames(gtex_metadata_df, var = "SUBJECT_ID")
table(colnames(gene_counts_corrected) == rownames(gtex_metadata_corrected))
#now its true

gtex_metadata_corrected$SEX <- as.factor(gtex_metadata_corrected$SEX)
gtex_metadata_corrected$DTHHRDY <- as.factor(gtex_metadata_corrected$DTHHRDY)


#load the data into a DESeq2 object 
dds <- DESeqDataSetFromMatrix(countData = gene_counts_corrected,
                              colData = gtex_metadata_corrected,
                              design = ~ SEX + DTHHRDY + AGE) #specifies for predictors
dds


#step 1.3 normalization and PCA
# Apply variance stabilizing transformation (VST) before PCA 
vsd <- vst(dds)
vsd #normalizes data
pca_sex <- plotPCA(vsd, intgroup = "SEX")
ggsave("PCA_sex.png",plot = pca_sex,width = 10, height = 10)
# I cant really see a trend here, probably because of high variance in groups?
pca_DTHHRDY <- plotPCA(vsd, intgroup = "DTHHRDY")
ggsave("PCA_DTHHRDY.png",plot = pca_DTHHRDY,width = 10, height = 10)
# this looks more homogenous, the groups seem to be aggregated into their respective components. 
pca_age <- plotPCA(vsd, intgroup = "AGE")
ggsave("PCA_age.png",plot = pca_age, width = 10, height = 10)


# Exercise 2 --> perform differential expression analysis (homemade analysis)
#copy and paste code: 
vsd_df <- assay(vsd) %>%
  t() %>%
  as_tibble()
vsd_df <- bind_cols(gtex_metadata_corrected, vsd_df)
head(vsd_df[,1:10])

#test for differential expression of WASH7P by running: 
m1 <- lm(formula = WASH7P ~ DTHHRDY + AGE + SEX, data = vsd_df) %>%
  summary() %>%
  tidy()
m1
#does WASH7P show significant evidence of sex differential expression> 
#yes, given the p value is so small, the expression is differential netween sexes for thos gene 
#positive estimate valye means higher expression in males I think 
#repeat for SLC25A47
m2 <- lm(formula = SLC25A47 ~ DTHHRDY + AGE + SEX, data = vsd_df) %>%
  summary() %>%
  tidy()
m2
#p value of 2.57e-2 is signigivant, estimate value fro sexmale is above 1, higher expression in males

#perform differential expression analysis "the right way" with DEseq2
dds <- DESeq(dds) #on un normalized count data not on the VST data

#extract and interpret the results for sex differential expression 
#use results() function 
resultsNames(dds)
res <- results(dds, name = "SEX_male_vs_female")%>%
  as_tibble(rownames = "GENE_NAME")
res #padj will tell u the adjusted p value, <0.1 are genes that are differentially expressed 
#how many genes exhibit significant differential expression between males and females at a 10% FDR aka padj <0.1
sig_genes_sexes <- res %>%
  filter(!is.na(padj) &padj <0.1)
nrow(sig_genes_sexes) #262 

#load the mapping of genes to chromsomes using left_join() function.
#do it by gene_ID and order by padj, from smallest to largest 

head(gene_locations_df)
merged_results <- left_join(res, gene_locations_df, by = "GENE_NAME")%>%
  arrange(padj)
head(merged_results)
#top hits are on Y chromsome, positive fold change male/female = higher expression in males

#tes with WASH7P and SLC25A47 again, are the results consistent? 

res %>%
  filter(GENE_NAME %in%c("WASH7P", "SLC25A47"))
#WASH7P is not significant, SLC is significant. THis differes from my original analysis, which was less stringent. Since thi one is p adjusted due to the FDR, I probaly lse a lot of signifiant values. 
#high sample size calls for a more stringent FDR, but this cana lso increase number of false negatives, hiding yur truly differentially expressed genes that are significant/
# a lenient FDR thershold does the oppostive, you might get more false positives 

#2.4 death classification results interpretation 
#use results() function 

resultsNames(dds)
death_results <- results(dds, name ="DTHHRDY_ventilator_case_vs_fast_death_of_natural_causes")%>%
  as_tibble(rowames = "GENE_NAME")
head(death_results)

#how many genes are differentially expressed according to death classsification at a 10% FDR?
sig_genes_dea <- death_results %>%
  filter(!is.na(padj) &padj <0.1)
nrow(sig_genes_dea) #16069

#2.5 estimating a false positive rate under the null hypothesis 
#will add later
set.seed(123)
gtex_metadata_corrected$SEX_perm <- sample(gtex_metadata_corrected$SEX)
table(gtex_metadata_corrected$SEX, gtex_metadata_corrected$SEX_perm)

#re run deseq analaysis using the permuted variable
dds_permuted <- DESeqDataSetFromMatrix(countData = gene_counts_corrected,
                              colData = gtex_metadata_corrected,
                              design = ~ SEX_perm + DTHHRDY + AGE)

dds_permuted

dds_permuted_deseq <- DESeq(dds_permuted)

resultsNames(dds_permuted_deseq)

res_new <- results(dds_permuted_deseq, name = "SEX_perm_male_vs_female")%>%
  as_tibble(rownames = "GENE_NAME")

res_new


sig_genes_sexes_new <- res_new %>%
  filter(!is.na(padj) &padj <0.1)
nrow(sig_genes_sexes_new) #now its 211 instead of 262 as was before, large scale data will make it hard to control for false discovery rate. 


#volcano plot: 
res <- res %>%
  mutate(
    neg_log10_padj = -log10(padj), #negative log10 of the adjusted p value 
    sig = ifelse(!is.na(padj) & padj < 0.1 & abs(log2FoldChange) > 1, "Significant", "Not Significant")
  ) 

volcano <- ggplot(res, aes(x = log2FoldChange, y= neg_log10_padj, color = sig))+ 
  geom_point(alpha = 0.6)+ 
  scale_color_manual(values = c("gray","red"))+
  labs(title = "sex differential expression",
       x = "Log2 Fold Change (m vs f)",
       y = "log10 adjusted p value") 
ggsave("volcano_plot.png", plot = volcano, width = 10, height = 10)
