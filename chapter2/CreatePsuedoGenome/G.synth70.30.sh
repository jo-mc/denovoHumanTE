#!/bin/bash

# 30X 70:30 22X:8X ccsReads/gccsS70.fa
/home/a1779913/go/src/ccsSynthesis/ccsSynthesis gChr14.fa 22 12000 
awk '{ if ($0 ~ /^>/) print ">14R" $0; else print }' out.fa > ccsReads/gccsS70.fa
rm out.fa 

# add d to id or else will be the same as above
/home/a1779913/go/src/ccsSynthesis/ccsSynthesis gChr14dash.fa 8 12000 
awk '{ if ($0 ~ /^>/) print ">14D" $0; else print }' out.fa >>   ccsReads/gccsS70.fa
rm out.fa 

/home/a1779913/go/src/ccsSynthesis/ccsSynthesis gChr22.fa 22 12000
awk '{ if ($0 ~ /^>/) print ">22R" $0; else print }' out.fa >>   ccsReads/gccsS70.fa
rm out.fa 

/home/a1779913/go/src/ccsSynthesis/ccsSynthesis gChr22dash.fa 8 12000
awk '{ if ($0 ~ /^>/) print ">22D" $0; else print }' out.fa >>   ccsReads/gccsS70.fa
rm out.fa
