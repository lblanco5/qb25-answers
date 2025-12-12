import traceback
import numpy as np
import sys
import pandas as pd
from fasta import readFASTA

#1: write a script to perform global alignment between two sequences using a given scoring matrix and a gap penalty. 
# four inputs: 
fasta_file = sys.argv[1]
sigma_file = sys.argv[2]
gap = float(sys.argv[3])  # -300
out_file = sys.argv[4]

input_sequences = readFASTA(open(fasta_file))
seq1_id, sequence1 = input_sequences[0]
seq2_id, sequence2 = input_sequences[1]

# Read the scoring matrix into a dictionary
sigma = pd.read_csv(sigma_file, sep=r'\s+', index_col=0)

m = len(sequence1)
n = len(sequence2)

F_matrix = np.zeros((m+1, n+1))
traceback_matrix = np.empty((m+1, n+1), dtype="str")

for i in range(1, m+1):
    F_matrix[i, 0] = i * gap
    traceback_matrix[i, 0] = "v" 
for j in range(1, n+1):
    F_matrix[0, j] = j * gap
    traceback_matrix[0, j] = "h"
traceback_matrix[0,0] = "done"

# options are v (vertical), d (diagonal), h (horizontal): setting the 
#traceback_matrix = np.empty((len(sequence1) + 1 , len(sequence2) + 1), dtype='str')
#for i in range(1, len(sequence1) + 1):
    #traceback_matrix[i, 0] = 'v'
#for j in range(1, len(sequence2) + 1):
    #traceback_matrix[0,j] = j = 'h'

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

while not (i == 0 and j == 0):     
    sequence1_index = i - 1
    sequence2_index = j - 1   

    if traceback_matrix[i, j] == "d":
        s1_alignment = sequence1[sequence1_index] + s1_alignment
        s2_alignment = sequence2[sequence2_index] + s2_alignment
        i -= 1
        j -= 1

    elif traceback_matrix[i, j] == "h":
        s1_alignment = "-" + s1_alignment
        s2_alignment = sequence2[sequence2_index] + s2_alignment
        j -=  1

    else:  # "v"
        s1_alignment = sequence1[sequence1_index] + s1_alignment
        s2_alignment = "-" + s2_alignment
        i -=  1
     
#used AI for some of these portions: 

num_gaps_1 = s1_alignment.count('-')
num_gaps_2 = s2_alignment.count('-')

matches = sum(a == b for a, b in zip(s1_alignment, s2_alignment))
identity1 = matches / len(s1_alignment) * 100
identity2 = matches / len(s2_alignment) * 100

final_score = F_matrix[m, n]

# write alignment
with open(out_file, "w") as f:
    f.write("Sequence 1 alignment:\n" + s1_alignment + "\n")
    f.write("Sequence 2 alignment:\n" + s2_alignment + "\n")

# print stats
print("Gaps in sequence 1:", num_gaps_1)
print("Gaps in sequence 2:", num_gaps_2)
print("Percent identity seq1:", identity1)
print("Percent identity seq2:", identity2)
print("Alignment score:", final_score)