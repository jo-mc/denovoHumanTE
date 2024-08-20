#!/bin/bash

if [ -f "allmulti" ]
then
    rm allmulti
fi

declare -a arr=("fmlrcChr6.vcf.bam.dist"
	"rataChr6.vcf.bam.dist"
	"rawChr6.vcf.bam.dist"
	"fmlrcChr6mosaic.vcf.bam.dist"
	"rataChr6mosaic.vcf.bam.dist"
	"rawChr6mosaic.vcf.bam.dist"
)


# 200 -7000 bp

#awk '{ if (($2 > 199) && ($2 <7001)) print }' chr6-HG002-SV-T1-v0.6.vcf.bam.dist > giab-200-7k.dist
#GIAB_COUNT=$(wc -l < "giab-200-7k.dist")

for i in "${arr[@]}"
do

# awk '{ if (($2 > 199) && ($2 <7001)) print }' "$i" | \
awk -f score.awk chr6-HG002-SV-T1-v0.6.vcf.bam.dist "$i" | \
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
}' > ardat

echo " completed $i"

if [ -f "allmulti" ]
then
    paste allmulti ardat  >tmp && mv tmp allmulti
else
    mv ardat allmulti
fi





done
