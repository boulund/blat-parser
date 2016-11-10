#!/usr/bin/env python3.5
# Fredrik Boulund 2015
# Toying with groupby to parse blat output

from collections import defaultdict

f = open("blat.blast8")

min_identity = 90.0
min_matches = 10

hitlists = defaultdict(list)

for hit in map(str.split, f):
    if float(hit[2]) >= min_identity and int(hit[3]) >= min_matches:
        hitlists[hit[0]].append(tuple(hit[1:]))

for peptide, hitlist in hitlists.items():
    max_pid = max(map(float, (h[1] for h in hitlist)))
    max_pid_diff = 5.00
    filtered = [h for h in hitlist if float(h[1]) >= max_pid-max_pid_diff]
    if len(filtered)>0:
        pass
        print(peptide+":", len(filtered))
