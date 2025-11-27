import traceback
import numpy as np
import sys
import pandas as pd
from fasta import readFASTA

#1: write a script to perform global alignment between two sequences using a given scoring matrix and a gap penalty. 
# four inputs: 
fasta_file = sys.argv[1]
sigma_file = sys.argv[2]
gap: int = float(sys.argv[3]) # -300
#out_file = sys.argv[4]

input_sequences = readFASTA(open(fasta_file))
sequence1, sequence2 = input_sequences[0][1], input_sequences[1][1]

# Read the scoring matrix into a dictionary
sigma = pd.read_csv(sigma_file, sep=r'\s+', index_col=0)
F_matrix = np.zeros((len(sequence1) + 1 , len(sequence2) + 1))

for i in range(len(sequence1) + 1):
    F_matrix[i, 0] = i * gap
for j in range(len(sequence2) + 1):
    F_matrix[0,j] = j * gap 

# options are v (vertical), d (diagonal), h (horizontal): setting the 
traceback_matrix = np.empty((len(sequence1) + 1 , len(sequence2) + 1), dtype='str')
for i in range(1, len(sequence1) + 1):
    traceback_matrix[i, 0] = 'v'
for j in range(1, len(sequence2) + 1):
    traceback_matrix[0,j] = j = 'h'

for i in range(1, len(sequence1) +1):
    for j in range(1, len(sequence2) +1):
        sequence1_index = i - 1
        sequence2_index = j - 1
        
        d = F_matrix[i-1, j-1] + sigma.loc[sequence1[sequence1_index], sequence2[sequence2_index]]
        v = F_matrix[i-1, j] + gap
        h = F_matrix[i,j-1] + gap

        F_matrix[i, j] = max(d, v, h)

        if d >= h and d>= v:
            traceback_matrix[i,j] = 'd' 
        elif h>=v: 
            traceback_matrix[i,j] = 'h' 
        else: 
            traceback_matrix[i,j] = 'v' 

s1_alignment, s2_alignment = '', ''
i, j = len(sequence1), len(sequence2)

while i!= 0 or j!=0: 
    sequence1_index = i - 1
    sequence2_index = j - 1   
if traceback_matrix[i,j] == "d", 
   s1_alignment = sequence1[sequence1_index] + s1_alignment
   
elif traceback_matrix[i,j] == "h", 
    [sequence1[sequence1_index]
else traceback_matrix[i,j] == "v"
    [sequence1[sequence1_index]