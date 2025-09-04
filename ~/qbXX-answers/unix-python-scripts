#!/usr/bin/env python3

import sys 

my_file = open(sys.argv[1])

for line in my_file:
    line = line.strip()
    line = line.split("\t")
    end = (int(line[2]))
    start = (int(line[1]))
    total = (end - start)
    orginal_score = (int(line[4]))
    new_score =  orginal_score * total 
    # print(new_score)
    strand = ((line[5]))
    if strand == "+":
        new_score = new_score
    else: 
        new_score = new_score * -1
    #print(f"{line[0]}\t{new_score}")
print(line[0]),"\t", (line[1]), "\t", (line[2]), "\t",(line[3]), "\t", (line[5])
   
