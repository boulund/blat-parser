#!/usr/bin/env python3.5
# Fredrik Boulund 2015
# Toying with groupby to parse blat output

from itertools import groupby

f = open("blat.blast8")


for peptide, match_iter in groupby(f, lambda l: l.split()[0]):
    matches = []
    for match in map(str.split, match_iter):
        if float(match[2]) >= 90.0 and int(match[3]) >= 10:
            matches.append(tuple(match))
    if not matches:
        continue

    max_pid = max(map(float, (h[2] for h in matches)))
    max_pid_diff = 5.00
    filtered = [h for h in matches if float(h[2]) >= (max_pid-max_pid_diff)]
    if len(filtered)>0:
        pass
        print(peptide+":", len(filtered))
