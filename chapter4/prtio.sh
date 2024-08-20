#!/bin/bash -l
#SBATCH -p batch
#SBATCH -N 1
#SBATCH -n 4
#SBATCH --time=08:45:00
#SBATCH --mem=64GB
# Notification configuration
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=joseph.mcconnell@adelaide.edu.au



prchild_chm13="/hpcfs/groups/phoenix-hpc-rc003/genomeData/ncbi/PuertoRican/child/HG00733_chm13.bam"
prmother_chm13="/hpcfs/groups/phoenix-hpc-rc003/genomeData/ncbi/PuertoRican/mother/HG00732_chm13.bam"
prfather_chm13="/hpcfs/groups/phoenix-hpc-rc003/genomeData/ncbi/PuertoRican/father/HG00731_chm13.bam"

ls "$prchild_chm13"
ls "$prmother_chm13"
ls "$prfather_chm13"

# VVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVV
# SVIM
conda activate svim_env

ref="/hpcfs/groups/phoenix-hpc-rc003/joe/ref/chm13/chm13.draft_v1.0.fasta"

svim alignment --min_sv_size 500 --max_sv_size 10000  --types INS,DUP:TANDEM,DUP:INT --insertion_sequences --read_names \
    ./HG00733  "$prchild_chm13" "$ref"

svim alignment --min_sv_size 500 --max_sv_size 10000  --types INS,DUP:TANDEM,DUP:INT --insertion_sequences --read_names \
    ./HG00731  "$prfather_chm13" "$ref"

svim alignment --min_sv_size 500 --max_sv_size 10000  --types INS,DUP:TANDEM,DUP:INT --insertion_sequences --read_names \
    ./HG00732  "$prmother_chm13" "$ref"

conda deactivate

# generate fasta's
/bin/bash  vcf-fa.sh   # https://stackoverflow.com/questions/8352851/shell-how-to-call-one-shell-script-from-another-shell-script

# VVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVV
# SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS
# SNIFFLES
conda activate sniffles

sniffles --i "$prchild_chm13"  --vcf sniffles/snif-child.vcf --threads 4

sniffles --i "$prfather_chm13"  --vcf sniffles/snif-father.vcf --threads 4

sniffles --i "$prmother_chm13"  --vcf sniffles/snif-mother.vcf --threads 4


# mosaic

sniffles --i "$prchild_chm13"  --vcf sniffles/ms-snif-child.vcf --threads 4 --mosaic

sniffles --i "$prfather_chm13"  --vcf sniffles/ms-snif-father.vcf --threads 4 --mosaic

sniffles --i "$prmother_chm13"  --vcf sniffles/ms-snif-mother.vcf --threads 4 --mosaic

conda deactivate

cd sniffles
grep "SVTYPE=INS" -h snif-child.vcf ms-snif-child.vcf  | \
awk '{
svlen = length($5);
if ((svlen > 250) && (svlen < 10000))
{
 print ">hg2:" $1 ":" $2 ":" svlen ":" $10
 print $5
}
}'  > snif-child.fa

grep "SVTYPE=INS" -h snif-father.vcf ms-snif-father.vcf  | \
awk '{
svlen = length($5);
if ((svlen > 250) && (svlen < 10000))
{
 print ">hg3:" $1 ":" $2 ":" svlen ":" $10
 print $5
}

}'  > snif-father.fa

grep "SVTYPE=INS" -h snif-mother.vcf ms-snif-mother.vcf  | \
awk '{
svlen = length($5);
if ((svlen > 250) && (svlen < 10000))
{
 print ">hg4:" $1 ":" $2 ":" svlen ":" $10
 print $5
}
}'  > snif-mother.fa

cd ..

# SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS

# CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
# CuteSV

conda activate cutesv

cuteSV --threads 8 --min_support 2 --diff_ratio_merging_INS 0.3  --max_cluster_bias_DEL 100 --max_cluster_bias_INS 100 --diff_ratio_merging_DEL 0.3 \
"$prchild_chm13" "$ref"  cutesv_child.vcf ./csvWork

cuteSV --threads 8 --min_support 2 --diff_ratio_merging_INS 0.3  --max_cluster_bias_DEL 100 --max_cluster_bias_INS 100 --diff_ratio_merging_DEL 0.3 \
"$prmother_chm13" "$ref"  cutesv_mother.vcf ./csvWork


cuteSV --threads 8 --min_support 2 --diff_ratio_merging_INS 0.3  --max_cluster_bias_DEL 100 --max_cluster_bias_INS 100 --diff_ratio_merging_DEL 0.3 \
"$prfather_chm13" "$ref"  cutesv_father.vcf ./csvWork

grep "SVTYPE=INS" cutesv_child.vcf   | \
awk '{
svlen = length($5);
if ((svlen > 250) && (svlen < 10000))
{
 print ">hg2:" $1 ":" $2 ":" svlen ":" $10
 print $5
}
}'  > cutesv-child.fa

grep "SVTYPE=INS" cutesv_father.vcf   | \
awk '{
svlen = length($5);
if ((svlen > 250) && (svlen < 10000))
{
 print ">hg3:" $1 ":" $2 ":" svlen ":" $10
 print $5
}
}'  > cutesv-father.fa

grep "SVTYPE=INS" cutesv_mother.vcf   | \
awk '{
svlen = length($5);
if ((svlen > 250) && (svlen < 10000))
{
 print ">hg4:" $1 ":" $2 ":" svlen ":" $10
 print $5
}
}'  > cutesv-mother.fa

# CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC

# PBSV

conda activate pbsv
# pbsv best for variant 200  > 500

pbsv discover "$prchild_chm13" prchild.svsig.gz
pbsv call "$ref" prchild.svsig.gz pbsv-child-chm13v1.vcf

pbsv discover "$prmother_chm13" prmother.svsig.gz
pbsv call "$ref" prmother.svsig.gz pbsv-mother-chm13v1.vcf

pbsv discover "$prfather_chm13" prfather.svsig.gz
pbsv call "$ref" prfather.svsig.gz pbsv-father-chm13v1.vcf


grep "SVTYPE=INS" pbsv-child-chm13v1.vcf | \
awk '{
svlen = length($5);
if ((svlen > 250) && (svlen < 400))
{
 print ">hg2:" $1 ":" $2 ":" svlen ":" $10
 print $5
}
}'  > pbsv-child.fa

grep "SVTYPE=INS" pbsv-mother-chm13v1.vcf | \
awk '{
svlen = length($5);
if ((svlen > 250) && (svlen < 400))
{
 print ">hg3:" $1 ":" $2 ":" svlen ":" $10
 print $5
}
}'  > pbsv-mother.fa

grep "SVTYPE=INS" pbsv-father-chm13v1.vcf | \
awk '{
svlen = length($5);
if ((svlen > 250) && (svlen < 400))
{
 print ">hg3:" $1 ":" $2 ":" svlen ":" $10
 print $5
}
}'  > pbsv-father.fa

