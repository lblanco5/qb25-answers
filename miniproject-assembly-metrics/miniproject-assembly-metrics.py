#!/usr/bin/env python3
import sys
import fasta

my_file = open( sys.argv[1] )
contigs = fasta.FASTAReader( my_file )

for ident, sequence in contigs:
    print (ident)

#for line in my_file: 
#print(line)

#for ident, sequence in assemblies:
    #print( f"Name: {ident}" )
    #print( ”First 20 nucleotides: {sequence[:20]}")