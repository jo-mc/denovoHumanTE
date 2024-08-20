#!/bin/bash


#rawChr6.vcf
#rawChr6mosaic.vcf
#rataChr6.vcf
#rataChr6mosaic.vcf
#fmlrcChr6.vcf
#fmlrcChr6mosaic.vcf


proc=rawChr6.vcf

awk -f ../vcf-sam.awk ../${proc} | samtools view -b - -o ${proc}.bam -O BAM
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



proc=rawChr6mosaic.vcf

awk -f ../vcf-sam.awk ../${proc} | samtools view -b - -o ${proc}.bam -O BAM
samtools index ${proc}.bam

samtools view ${proc}.bam | \
awk '{ if ($0 ~ /^@/) next;
svlen = 1 * substr($6,1,length($6)-1)
if (svlen > 10000) { next }
if ($2 == 0)
{ print $4, svlen }
else
{ print $4, (-1) * svlen  }

}' $1 > ${proc}.bam.dist



proc=rataChr6.vcf

awk -f ../vcf-sam.awk ../${proc} | samtools view -b - -o ${proc}.bam -O BAM
samtools index ${proc}.bam

samtools view ${proc}.bam |  \
awk '{ if ($0 ~ /^@/) next;
svlen = 1 * substr($6,1,length($6)-1)
if (svlen > 10000) { next }
if ($2 == 0)
{ print $4, svlen }
else
{ print $4, (-1) * svlen  }

}' $1 > ${proc}.bam.dist

proc=rataChr6mosaic.vcf

awk -f ../vcf-sam.awk ../${proc} | samtools view -b - -o ${proc}.bam -O BAM
samtools index ${proc}.bam

samtools view ${proc}.bam |  \
awk '{ if ($0 ~ /^@/) next;
svlen = 1 * substr($6,1,length($6)-1)
if (svlen > 10000) { next }
if ($2 == 0)
{ print $4, svlen }
else
{ print $4, (-1) * svlen  }

}' $1 > ${proc}.bam.dist


proc=fmlrcChr6.vcf

awk -f ../vcf-sam.awk ../${proc} | samtools view -b - -o ${proc}.bam -O BAM
samtools index ${proc}.bam

samtools view ${proc}.bam |  \
awk '{ if ($0 ~ /^@/) next;
svlen = 1 * substr($6,1,length($6)-1)
if (svlen > 10000) { next }
if ($2 == 0)
{ print $4, svlen }
else
{ print $4, (-1) * svlen  }

}' $1 > ${proc}.bam.dist


proc=fmlrcChr6mosaic.vcf

awk -f ../vcf-sam.awk ../${proc} | samtools view -b - -o ${proc}.bam -O BAM
samtools index ${proc}.bam

samtools view ${proc}.bam |  \
awk '{ if ($0 ~ /^@/) next;
svlen = 1 * substr($6,1,length($6)-1)
if (svlen > 10000) { next }
if ($2 == 0)
{ print $4, svlen }
else
{ print $4, (-1) * svlen  }

}' $1 > ${proc}.bam.dist

