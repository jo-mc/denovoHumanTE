#!/bin/bash -l
#SBATCH -p batch
#SBATCH -N 1
#SBATCH -n 8
#SBATCH --time=01:45:00
#SBATCH --mem=32GB
# Notification configuration
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=joseph.mcconnell@adelaide.edu.au

conda activate pbsv

# /hpcfs/groups/phoenix-hpc-rc003/joe/thesis/chap3/pseudogenome/br2

bam="al-ratatosk_longread.bam"
out="rata_pbsv"
	pbsv discover  "$bam"   "$out".svsig.gz
	pbsv call ../../../chap2/srcRef.fa "$out".svsig.gz "$out".vcf
