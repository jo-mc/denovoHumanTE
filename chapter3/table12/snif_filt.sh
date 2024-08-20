#!/bin/bash

vcf="ratatosk_3x25.vcf"

awk -f /hpcfs/groups/phoenix-hpc-rc003/joe/thesis/chap2/br2/awk/snif_readVCF.awk "$vcf" | \
awk '{ n=split($0,a,","); if (a[4] > 90) { print } else { lt90 +=1; } } END { print "variants < 90 "lt90 }'  > "$vcf".filt
