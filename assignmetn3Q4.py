#!/usr/bin/env python3

import sys 

my_file = open(sys.argv[1])
_=my_file.readline()
_=my_file.readline()
header=my_file.readline()
Data=my_file.readline()
for line in my_file:
    line = line.strip()
    line = line.split("\t")
    print(line)
 