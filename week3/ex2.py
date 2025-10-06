#!/usr/bin/env python3

import sys
AF_file = open ("AF.txt", "w")
for line in open ("BYxRM_bam/biallelic.vcf"): 
    if line.startswith('#'): 
        continue
    fields= line.rstrip('\n').split('\t')
    allele_freq = fields[7].split(";")
    AF = allele_freq [3]
    stripped_AF = AF.strip("AF=")
    AF_file.write(stripped_AF + "\n")
AF_file.close()
    #print(AF)

