#!/bin/bash

#pbsvchr6fmlrc.vcf  pbsvchr6rata.vcf  pbsvchr6raw.vcf


proc=pbsvchr6hifi.vcf

awk -f ../vcf-sam-pbsv.awk ${proc} | samtools view -b - -o ${proc}.bam -O BAM
samtools index ${proc}.bam

samtools view ${proc}.bam | \
awk '{ if ($0 ~ /^@/) next;
svlen = 1 * substr($6,1,length($6)-1)
if (svlen > 10000) { next }
if ($2 == 0)
{ print $4, svlen }
else
{ print $4, (-1) * svlen }

}' $1 > ${proc}.bam.dist



