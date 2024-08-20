#!/bin/bash -l
#SBATCH -p skylake
#SBATCH -N 1
#SBATCH -n 14
#SBATCH --time=01:45:00
#SBATCH --mem=32GB
# Notification configuration
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=joseph.mcconnell@adelaide.edu.au

# Generate VCF for raw ont, FMLRC and RATA corrected for normal and spt=3 using cuteSV

#rawChr6.bam
#fmlrcChr6.bam
#rataChr6.bam

conda activate cutesv


#RATA


cuteSV --threads 14 --max_cluster_bias_INS 100 --diff_ratio_merging_INS 0.3 --max_cluster_bias_DEL 100 --diff_ratio_merging_DEL 0.3 rataChr6.bam  ref_chr6.fa cusv_RATA6.vcf ./work
 grep "SVTYPE=INS" cusv_RATA6.vcf | awk '{ if ((length($5) > 50) && (length($5) < 15000)) { print $2, length($5) } }' > cusv_RATA6_SV_INS_GT_50.txt
cuteSV --threads 14 --max_cluster_bias_INS 100 --diff_ratio_merging_INS 0.3 --max_cluster_bias_DEL 100 --diff_ratio_merging_DEL 0.3 --min_support 3 rataChr6.bam  ref_chr6.fa cusv_RATA6_spt3.vcf ./work
 grep "SVTYPE=INS" cusv_RATA6_spt3.vcf | awk '{ if ((length($5) > 50) && (length($5) < 15000)) { print $2, length($5) } }' > cusv_RATA6_spt3_SV_INS_GT_50.txt

#        For PacBio CCS(HIFI) data:
#                --max_cluster_bias_INS          1000
#                --diff_ratio_merging_INS        0.9
#                --max_cluster_bias_DEL  1000
#                --diff_ratio_merging_DEL        0.5

cuteSV --threads 14 --max_cluster_bias_INS 1000 --diff_ratio_merging_INS 0.9 --max_cluster_bias_DEL 1000 --diff_ratio_merging_DEL 0.5 rataChr6.bam  ref_chr6.fa cusv_RATA6-hifi.vcf ./work
 grep "SVTYPE=INS" cusv_RATA6-hifi.vcf | awk '{ if ((length($5) > 50) && (length($5) < 15000)) { print $2, length($5) } }' > cusv_RATA6_SV_INS_GT_50hifi.txt
cuteSV --threads 14 --max_cluster_bias_INS 1000 --diff_ratio_merging_INS 0.9 --max_cluster_bias_DEL 1000 --diff_ratio_merging_DEL 0.5 --min_support 3 rataChr6.bam  ref_chr6.fa cusv_RATA6_spt3-hifi
.vcf ./work
 grep "SVTYPE=INS" cusv_RATA6_spt3-hifi.vcf | awk '{ if ((length($5) > 50) && (length($5) < 15000)) { print $2, length($5) } }' > cusv_RATA6_spt3_SV_INS_GT_50hifi.txt
