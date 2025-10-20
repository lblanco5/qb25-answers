#!/usr/bin/env python3

import sys

long_file = open ("gt_long.txt", "w")
sample_ids = ["A01_62", "A01_39", "A01_63", "A01_35", "A01_31",
              "A01_27", "A01_24", "A01_23", "A01_11", "A01_09"]
for line in open("/Users/cmdb/qb25-answers/week3/BYxRM_bam/biallelic.vcf"): 
    if line.startswith('#'): 
        continue
    fields= line.rstrip('\n').split('\t')
    chrom = fields[0]
    pos   = fields[1]
    samples = fields[9:]
    counter = 0 
    for x in samples: 
        split = x.rstrip('\n').split(':')
        genotype = split[0]
        sample_name = sample_ids[counter]
        counter = counter + 1 
        long_file.write(f"{sample_name}\t{chrom}\t{pos}\t{genotype} \n") #makes it one argument
