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

# RAW ont
cuteSV --threads 14 --max_cluster_bias_INS 100 --diff_ratio_merging_INS 0.3 --max_cluster_bias_DEL 100 --diff_ratio_merging_DEL 0.3 rawChr6.bam  ref_chr6.fa cusv_RAW6.vcf ./work
 grep "SVTYPE=INS" cusv_RAW6.vcf | awk '{ if ((length($5) > 50) && (length($5) < 15000)) { print $2, length($5) } }' > RAW_CUSV_SV_INS_GT_50.txt

cuteSV --threads 14 --max_cluster_bias_INS 100 --diff_ratio_merging_INS 0.3 --max_cluster_bias_DEL 100 --diff_ratio_merging_DEL 0.3 --min_support 3 rawChr6.bam  ref_chr6.fa cusv_RAW6_spt3.vcf ./work
 grep "SVTYPE=INS" cusv_RAW6_spt3.vcf | awk '{ if ((length($5) > 50) && (length($5) < 15000)) { print $2, length($5) } }' > RAW_CUSV_RAW6_SPT3_SV_INS_GT_50.txt

#FMLRC

cuteSV --threads 14 --max_cluster_bias_INS 100 --diff_ratio_merging_INS 0.3 --max_cluster_bias_DEL 100 --diff_ratio_merging_DEL 0.3 fmlrcChr6.bam  ref_chr6.fa cusv_FMLRC6.vcf ./work
 grep "SVTYPE=INS" cusv_FMLRC6.vcf | awk '{ if ((length($5) > 50) && (length($5) < 15000)) { print $2, length($5) } }' > cusv_FMLRC6_SV_INS_GT_50.txt
cuteSV --threads 14 --max_cluster_bias_INS 100 --diff_ratio_merging_INS 0.3 --max_cluster_bias_DEL 100 --diff_ratio_merging_DEL 0.3 --min_support 3 fmlrcChr6.bam  ref_chr6.fa cusv_FMLRC6_spt3.vcf ./work
 grep "SVTYPE=INS" cusv_FMLRC6_spt3.vcf | awk '{ if ((length($5) > 50) && (length($5) < 15000)) { print $2, length($5) } }' > cusv_FMLRC6_spt3_SV_INS_GT_50.txt

#RATA


cuteSV --threads 14 --max_cluster_bias_INS 100 --diff_ratio_merging_INS 0.3 --max_cluster_bias_DEL 100 --diff_ratio_merging_DEL 0.3 rataChr6.bam  ref_chr6.fa cusv_RATA6.vcf ./work
 grep "SVTYPE=INS" cusv_RATA6.vcf | awk '{ if ((length($5) > 50) && (length($5) < 15000)) { print $2, length($5) } }' > cusv_RATA6_SV_INS_GT_50.txt
cuteSV --threads 14 --max_cluster_bias_INS 100 --diff_ratio_merging_INS 0.3 --max_cluster_bias_DEL 100 --diff_ratio_merging_DEL 0.3 --min_support 3 rataChr6.bam  ref_chr6.fa cusv_RATA6_spt3.vcf ./work
 grep "SVTYPE=INS" cusv_RATA6_spt3.vcf | awk '{ if ((length($5) > 50) && (length($5) < 15000)) { print $2, length($5) } }' > cusv_RATA6_spt3_SV_INS_GT_50.txt

#        Suggestions:
#
#        For PacBio CLR data:
#                --max_cluster_bias_INS          100
#                --diff_ratio_merging_INS        0.3
#                --max_cluster_bias_DEL  200
#                --diff_ratio_merging_DEL        0.5
#
#        For PacBio CCS(HIFI) data:
#                --max_cluster_bias_INS          1000
#                --diff_ratio_merging_INS        0.9
#                --max_cluster_bias_DEL  1000
#                --diff_ratio_merging_DEL        0.5
#
#        For ONT data:
#                --max_cluster_bias_INS          100
#                --diff_ratio_merging_INS        0.3
#                --max_cluster_bias_DEL  100
#                --diff_ratio_merging_DEL        0.3
#
