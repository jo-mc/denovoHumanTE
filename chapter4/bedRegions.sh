#!/bin/bash

# bed region for IGV below bed region for candidates.

cat child_uniq.loc | grep -f -  *child.fa.loc | \
awk '{
range = 20000;
# $3 and $4 have chr and position need unique ones

n = split($0,a,":")
# candPos[a[3] ":" a[4]] += 1;
if (a[4] > (range + 1)) { rb = a[4] - range } else { rb = 1 }
re = a[4] + range;
printf("%s\t%s\t%s\t%s\n",a[3],rb,re,$0)

}' | sort -k1,1V -k2,2n > candidate.bed


# Bed region for generating bam covering all candidates:

awk '{
# $3 and $4 have chr and position need unique ones


if ($1 != lastChr) { print $0 } else {
	if ($2 > (lastPos + 600)) { print $0 }
	}

lastPos = $2
lastChr = $1

}' candidate.bed  > bamregions.bed

