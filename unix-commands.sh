#!/bin/bash

wc -l ce11_genes.bed
#  53935 ce11_genes.bed

cut -f 1 ce11_genes.bed | uniq -c
#5460 chrI
#  12 chrM
#9057 chrV
#6840 chrX
#6299 chrII
#21418 chrIV
#4849 chrIII

cut -f 6 ce11_genes.bed |sort | uniq -c
#26626 -
#27309 +

