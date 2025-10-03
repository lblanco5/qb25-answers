wc -l snps-chr1  
 1091148 snps-chr1
mv snps-chr1 snps-chr1.bed
less snps-chr1.bed 
head -n 10 hg19-kc-count.bed
bedtools intersect -c -a hg19-kc.bed -b snps-chr1.bed|sort -n -k 5 |tail
#output chr1	240938813	241520505	ENST00000440928.6_9	3340
#chr1	245912648	246670581	systematic name: ENST00000490107.6_7	5445
# human readable name: SMYD3; pisition: chr1	245912648	246670581; size: 757933; exon count: 12: 
# why does this gene has the most SNPs? Given that it's a methyltransfrase, multiple SNPs might actually be beneficial given that it could increase their diversity. Many of those SNP's might not even be wihtin the gene, which might not be affecting their functiom
bedtools sample -n 20 -seed 42 -i snps-chr1.bed > subset-snps-chr1.bed
bedtools sort -i subset-snps-chr1.bed > sorted-snps-chr1.bed
bedtools sort -i hg19-kc.bed > sorted-hg19-kc.bed
bedtools closest -d -t first -a sorted-snps-chr1.bed -b sorted-hg19-kc.bed|wc
