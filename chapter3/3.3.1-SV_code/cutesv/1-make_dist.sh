#!/bin/bash

proc=cusv_RAW6.vcf

awk -f ../vcf-sam-cutesv.awk ../${proc} | samtools view -b - -o ${proc}.bam -O BAM
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



proc=cusv_FMLRC6.vcf 

awk -f ../vcf-sam-cutesv.awk ../${proc} | samtools view -b - -o ${proc}.bam -O BAM
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



proc=cusv_RATA6-hifi.vcf

awk -f ../vcf-sam-cutesv.awk ../${proc} | samtools view -b - -o ${proc}.bam -O BAM
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

proc=cusv_RATA6.vcf

awk -f ../vcf-sam-cutesv.awk ../${proc} | samtools view -b - -o ${proc}.bam -O BAM
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


proc=cusv_RATA6_spt3.vcf

awk -f ../vcf-sam-cutesv.awk ../${proc} | samtools view -b - -o ${proc}.bam -O BAM
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


proc=cusv_RATA6_spt3-hifi.vcf

awk -f ../vcf-sam-cutesv.awk ../${proc} | samtools view -b - -o ${proc}.bam -O BAM
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


proc=cusv_RAW6_spt3.vcf

awk -f ../vcf-sam-cutesv.awk ../${proc} | samtools view -b - -o ${proc}.bam -O BAM
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


proc=cusv_FMLRC6_spt3.vcf

awk -f ../vcf-sam-cutesv.awk ../${proc} | samtools view -b - -o ${proc}.bam -O BAM
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


