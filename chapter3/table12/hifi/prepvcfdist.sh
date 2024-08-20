

cat /hpcfs/groups/phoenix-hpc-rc003/joe/thesis/chap3/SVgiabchr6GRCh37/HG002c0.6SV_giab/giab6sv.dist | while read line; do echo "GIAB $line"; done > combvcf.dist

cat hifiChr6-hg19.vcf.sam.dist | while read line; do echo "hifi $line"; done >> combvcf.dist

