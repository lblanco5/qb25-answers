conda activate qb25
wget https://hgdownload.soe.ucsc.edu/goldenPath/hg16/bigZips/hg16.chrom.sizes
less hg16.chrom.sizes
grep -v _ hg16.chrom.sizes > hg16-main.chrom.sizes
bedtools makewindows hg16-main.chrom.sizes  
bedtools makewindows -g hg16-main.chrom.sizes -w 1000000
bedtools makewindows -g hg16-main.chrom.sizes -w 1000000 >hg16-1mb.bed
cut -f1-3,5 h16-kc.tsv > hg16-kc.bed
bedtools intersect -c -a hg16-1mb.bed -b hg16-kc.bed >hg16-kc-count.bed
head hg16-kc-count.bed
wc hg16-kc-count.bed 