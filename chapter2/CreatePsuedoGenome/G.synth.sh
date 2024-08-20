#!/bin/bash

# 30X 50:50  ccsReads/gccsS50.fa

/home/a1779913/go/src/ccsSynthesis/ccsSynthesis gChr14.fa 15 12000 
awk '{ if ($0 ~ /^>/) print ">14R" $0; else print }' out.fa > ccsReads/RgccsS50.fa
rm out.fa

# add d to id or else will be the same as above
/home/a1779913/go/src/ccsSynthesis/ccsSynthesis gChr14dash.fa 15 12000 
awk '{ if ($0 ~ /^>/) print ">14D" $0; else print }' out.fa >>   ccsReads/RgccsS50.fa
rm out.fa

/home/a1779913/go/src/ccsSynthesis/ccsSynthesis gChr22.fa 15 12000
awk '{ if ($0 ~ /^>/) print ">22R" $0; else print }' out.fa >>   ccsReads/RgccsS50.fa
rm out.fa

/home/a1779913/go/src/ccsSynthesis/ccsSynthesis gChr22dash.fa 15 12000
awk '{ if ($0 ~ /^>/) print ">22D" $0; else print }' out.fa >>   ccsReads/RgccsS50.fa


rm out.fa