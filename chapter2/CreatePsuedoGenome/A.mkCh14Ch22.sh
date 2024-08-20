#!/bin/bash

awk '{if ($0 ~ /^>/) {  if ($0 ~ /^>chr14/) {print $0; a14 = 1;} else a14 =0; } else { if (a14 == 1) printf("%s",$0) } }' chm13v1.1.fa > gChr14.fa
awk '{if ($0 ~ /^>/) {  if ($0 ~ /^>chr22/) {print $0; a22 = 1;} else a22 =0; } else { if (a22 == 1) printf("%s",$0) } }' chm13v1.1.fa > gChr22.fa
