#!/bin/bash

fnArray=("HG005/variants.vcf" "HG006/variants.vcf" "HG007/variants.vcf")
opArray=("svim-father.fa" "svim-mother.fa" "svim-child.fa")


#TEST Array implementation
#for i in ${!fnArray[@]}; do
#  echo "element $i is ${fnArray[$i]}"
#  echo "op elem $i is ${opArray[$i]}"
#
#done
#exit

for i in ${!fnArray[@]}; do

awk -v id="${opArray[$i]}" '{

if ( ($0 ~ /^#/) || (index($8,"INS") == 0) )
 { next };

n = split($8,a,";");
for (i=1;i<=n;i++)
{
  if (index(a[i],"SEQS") > 0) { aseq = substr(a[i],6) }
  if (index(a[i],"LEN") > 0) { atype =  a[i] }
}

n = split(aseq,b,",") # multiple seqs per variant - no consensus
print ">" substr(id,1,3) ":" $1 ":" $2 ":" $5 ":" $6 ":" atype ": " a[8];
print b[1];

}' "${fnArray[$i]}" > "${opArray[$i]}"

done
