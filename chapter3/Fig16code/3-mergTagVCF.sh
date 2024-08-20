#!/bin/bash

#chr6-HG002-SV-T1-v0.6.vcf.bam.dist
#fmlrcChr6.vcf.bam.dist
#rataChr6.vcf.bam.dist
#rawChr6.vcf.bam.dist

#cat chr6-HG002-SV-T1-v0.6.vcf.bam.dist | while read line; do echo "GIAB $line"; done > combvcf.dist

# (EXCEL) removed overlapping SV from GIAB set, wher two overlap keep largest. If three or overlap, keep largest of last two overlapping. (??)
# keep in dups for now.
#cat rem-Dup-GIAB.dist | while read line; do echo "GIAB $line"; done > combvcf-remdup.dist

cat chr6-HG002-SV-T1-v0.6.vcf.bam.dist | while read line; do echo "GIAB $line"; done > combvcf.dist

cat fmlrcChr6.vcf.bam.dist | while read line; do echo "fmlrc $line"; done >> combvcf.dist
cat rataChr6.vcf.bam.dist | while read line; do echo "rata $line"; done >> combvcf.dist
cat rawChr6.vcf.bam.dist  | while read line; do echo "raw $line"; done >> combvcf.dist

