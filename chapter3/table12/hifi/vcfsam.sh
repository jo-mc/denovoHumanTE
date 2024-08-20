

awk -f ~/awk/vcf-sam.awk hifiChr6-hg19.vcf |  awk '{ if ($0 ~ /^@/) next; print $4, substr($6,1,length($6)-1) }' >  hifiChr6-hg19.vcf.sam.dist

