#!/bin/bash

if [ -f "csv-27multi" ]
then
    rm "csv-27multi"
fi

declare -a arr=("cuteSVchr6HIFI.vcf.bam.dist"
)


# 200 -7000 bp

awk '{ if (($2 > 199) && ($2 <7001)) print }' chr6-HG002-SV-T1-v0.6.vcf.bam.dist > giab-200-7k.dist
GIAB_COUNT=$(wc -l < "giab-200-7k.dist")

for i in "${arr[@]}"
do

awk '{ if (($2 > 199) && ($2 <7001)) print }' "$i" | \
awk -f score.awk giab-200-7k.dist - | \
awk -v giab_count="$GIAB_COUNT" 'BEGIN {
  for (i=1;i<=giab_count;i++)
    { giab[i] = "0"}
}

{
  giab[$7] = $5; if (NF == 2) nomatch += 1;
}
END {
  print "nomatch: ",nomatch; for ( i in giab) {print i, giab[i];
}
}' > rdat

echo " completed $i"

if [ -f "csv-27multi" ]
then
    paste "csv-27multi" rdat >tmp && mv tmp csv-27multi 
else
    mv rdat "csv-27multi"
fi





done
