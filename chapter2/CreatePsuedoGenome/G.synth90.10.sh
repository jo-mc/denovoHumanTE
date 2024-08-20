#!/bin/bash

# 30X 90:10  ccsReads/gccsS90.fa

/home/a1779913/go/src/ccsSynthesis/ccsSynthesis gChr14.fa 27 12000 
awk '{ if ($0 ~ /^>/) print ">14R" $0; else print }' out.fa > ccsReads/gccsS90.fa
rm out.fa

/home/a1779913/go/src/ccsSynthesis/ccsSynthesis gChr14dash.fa 3 12000 
awk '{ if ($0 ~ /^>/) print ">14D" $0; else print }' out.fa >>   ccsReads/gccsS90.fa
rm out.fa

/home/a1779913/go/src/ccsSynthesis/ccsSynthesis gChr22.fa 27 12000
awk '{ if ($0 ~ /^>/) print ">22R" $0; else print }' out.fa >>   ccsReads/gccsS90.fa
rm out.fa

/home/a1779913/go/src/ccsSynthesis/ccsSynthesis gChr22dash.fa 3 12000
awk '{ if ($0 ~ /^>/) print ">22D" $0; else print }' out.fa >>   ccsReads/gccsS90.fa
rm out.fa

