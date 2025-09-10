#!/usr/bin/env python3

import sys 
import fasta 

sequence_length = 0 
fasta_info = 0
total_lentgh = 0 
contig_lentgh = []
cumulative_length = 0
for ident, sequence in fasta.FASTAReader(open(sys.argv[1])): 
  fasta_info +=1
#sequence_lentgh = len(sequence)
  total_lentgh += len(sequence)
  contig_lentgh.append(len(sequence))
contig_lentgh.sort(reverse=True)
print(fasta_info)
print (sequence_length)
print (total_lentgh)
print(contig_lentgh)
for x in contig_lentgh:
    cumulative_length += x
    if cumulative_length >= total_lentgh/2:
        break  
print(str(x) + "= N50")




