#!/usr/bin/env python3

import sys


sam_file = open(sys.argv[1])
alignment_counts = {}
sorted_dict = {}
for line in sam_file: 
    if line.startswith ("@"): 
        continue 
    fields = line.strip().split("\t")
    RNAME = fields[2]
    if RNAME not in alignment_counts: 
        alignment_counts[RNAME]= 1
    else:
        alignment_counts[RNAME]+=1
    for x in fields: 
        if x.startswith ("NM:i"): 
            data_split = x.strip().split(":")
            number = int(data_split[2])
            if number not in sorted_dict: 
                sorted_dict[number] = 1
            else:
                sorted_dict[number] +=1

for line in sorted(sorted_dict.keys()): 
    print(line, sorted_dict[line])


for line in alignment_counts.keys(): 
    print(line, alignment_counts[line])

