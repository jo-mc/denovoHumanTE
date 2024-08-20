#!/bin/bash -l
#SBATCH -p batch
#SBATCH -N 1
#SBATCH -n 14
#SBATCH --time=18:45:00
#SBATCH --mem=64GB
# Notification configuration
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=joseph.mcconnell@adelaide.edu.au


# fmlrc_longread.fastq  ratatosk_longread.fastq.fastq.gz

conda activate lra 


gunzip -c ratatosk_longread.fastq.fastq.gz | lra align  -ONT -t 14 /hpcfs/groups/phoenix-hpc-rc003/joe/thesis/chap2/srcRef.fa - -p s > al-ratatosk_longread.sam


conda deactivate
conda activate samtools


samtools view -b al-ratatosk_longread.sam | samtools sort - >  al-ratatosk_longread.bam
samtools index al-ratatosk_longread.bam
