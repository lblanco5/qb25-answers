#!/usr/bin/env python3

import sys

from numpy import append
AF_file = open ("AF.txt", "w")
for line in open ("/Users/cmdb/qb25-answers/week3/BYxRM_bam/biallelic.vcf"): 
    if line.startswith('#'): 
        continue
    fields= line.rstrip('\n').split('\t')
    allele_freq = fields[7].split(";")
    for line in allele_freq: 
      if line.startswith('AF='):  
        stripped_AF = line.strip("AF=")
        AF_file.write(stripped_AF + "\n")
        continue 
AF_file.close()
    #print(AF)

