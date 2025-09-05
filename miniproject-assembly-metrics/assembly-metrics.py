#!/usr/bin/env python3

import sys 
import fasta 

sequence_length = 0 
fasta_info = 0
total_lentgh = 0 
for ident, sequence in fasta.FASTAReader(open(sys.argv[1])): 
  fasta_info +=1
#sequence_lentgh = len(sequence)
  total_lentgh += len(sequence)
print(fasta_info)
print (sequence_length)
print (total_lentgh)


