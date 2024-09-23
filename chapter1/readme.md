Histograms comparing structural variation insertion and deletion lengths (50 - 10,000) in HG002 relative to the GRCh38 human reference genome obtained from Nanopore R10 and Illumina paired-end sequencing. SV Count are log binned, where
log(upperBin) - log(lowerBin) ~ 0.015

Variant insert and delete size histogram data	
	
### Nanopore	
	
VCF from 	
	- s3://ont-open-data/giab_lsk114_2022.12/analysis/hg002_truvari_svs/
	- SAMPLE.wf_sv.vcf.gz
	- aws s3 cp --no-sign-request s3://ont-open-data/giab_lsk114_2022.12/analysis/hg002_truvari_svs/SAMPLE.wf_sv.vcf.gz SAMPLE.wf_sv.vcf.gz

data extraction: 
>(the length is extracted from vcf field 8, and the index of length can vary bewtween VCF tools, here it is array [3])
```awk
gunzip -c SAMPLE.wf_sv.vcf.gz  |
awk '{n=split($8,a,";"); l = 1*substr(a[3],7); if (l != 0) print l}' |
sort -n |
uniq -c > variationsize.dat
```
	
Ref:	https://labs.epi2me.io/askenazi-kit14-2022-12/
- Genome in a Bottle Ashkenazi Trio with Ligation Sequencing Kit V14
- By Chris Wright
- Published in Data Releases, 	January 27, 2023, Nanopore
	
	
### Illumina	
	
VCF from	
- https://ftp-trace.ncbi.nih.gov/giab/ftp/data/AshkenazimTrio/analysis/NCBI_IlluminaHiSeq300X_cortex_09042015/
- AJtrio_HiSeq300X_cortex_variants_GRCh37_09042015.vcf 
	
	Filter for variants >50 and <-50.

data extraction:
```awk
grep "SVTYPE=DEL\|SVTYPE=INS" AJtrio_HiSeq300X_cortex_variants_GRCh37_09042015.vcf  |
awk '{n=split($8,a,";"); l = 1*substr(a[2],7); if (l > 49 ) print l; if (l < -49) print l;}' |
sort -n |
uniq -c  > sv_hist.dat
```
