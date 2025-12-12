def get_edges(reads, k, outFile):
    edges = set()
    for read in reads:
        for i in range(len(read) - k):
            kmer1 = read[i: i+k]
            kmer2 = read[i+1: i+1+k]
            edge = f'"{kmer1}" -> "{kmer2}";'
            edges.add(edge)

    with open(outFile, 'w') as out_fs:
        out_fs.write('digraph {\n')
        for edge in edges:
            out_fs.write(f'    {edge}\n')
        out_fs.write('}\n')

reads = [
    'ATTCA', 'ATTGA', 'CATTG', 'CTTAT', 'GATTG', 'TATTT',
    'TCATT', 'TCTTA', 'TGATT', 'TTATT', 'TTCAT', 'TTCTT', 'TTGAT'
]

get_edges(reads, 3, 'edges.txt')
