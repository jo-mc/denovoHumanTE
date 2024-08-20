#!/bin/bash

proc=chr6-HG002-SV-T1-v0.6.vcf

awk -f ../HG002c0.6SV_giab/gvcf_sam.awk ../HG002c0.6SV_giab/${proc} | samtools view -b - -o ${proc}.bam -O BAM
samtools index ${proc}.bam

samtools view ${proc}.bam |  \
awk '{ if ($0 ~ /^@/) next;
svlen = 1 * substr($6,1,length($6)-1)
if (svlen > 10000) { next }
if ($2 == 0)
{ print $4, svlen }
else
{ print $4, (-1) * svlen }

}' $1 > ${proc}.bam.dist


