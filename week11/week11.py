import numpy as np
from scipy import stats

genome_size = 1_000_000
target_coverage = 30
read_length = 100 

genome_coverage = np.zeros(genome_size) #1 million set of zeroes 
number_of_reads = int((target_coverage * genome_size) / read_length)

# fill in the coverage 
for x in range(number_of_reads): 
    start = int(np.random.uniform(0, genome_size - read_length + 1))
    end = int(start + read_length)
    genome_coverage[start:end] += 1

#used AI for some of this 
zero_coverage_fraction = np.sum(genome_coverage == 0) / genome_size
print("Fraction of genome with 0x coverage:", zero_coverage_fraction)

max_coverage = int(max(genome_coverage))
xs = list(range(0, max_coverage + 1))

poisson_estimate = stats.poisson.pmf(xs, mu=target_coverage)
normal_estimate  = stats.norm.pdf(xs, loc=target_coverage, scale=np.sqrt(target_coverage))

poisson_estimate_scaled = poisson_estimate * genome_size
normal_estimate_scaled = normal_estimate * genome_size

with open('genome_coverage.txt', 'w') as f:
    for x in genome_coverage:
        f.write(f'{int(x)}\n')

with open('poisson.txt', 'w') as f:
    for x in poisson_estimate:
        f.write(f'{x}\n')

with open('normal.txt', 'w') as f:
    for x in normal_estimate:
        f.write(f'{x}\n')

