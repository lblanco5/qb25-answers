bedtools makewindows -g hg19-main.chrom.sizes -w 1000000 > hg19-1mb.bed
(qb25) cmdb@QuantBio-34 week1 % bedtools intersect -c -a hg19-1mb.bed -b hg19-kc.bed >hg19-kc-count.bed
