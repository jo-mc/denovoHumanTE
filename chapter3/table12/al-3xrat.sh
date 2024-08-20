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


gunzip -c ratatosk_3x25.fastq.fastq.gz | lra align  -ONT -t 14 /hpcfs/groups/phoenix-hpc-rc003/joe/thesis/chap2/srcRef.fa - -p s > ratatosk_3x25.sam


conda deactivate
conda activate samtools

samtools view -b ratatosk_3x25.sam | samtools sort - >  ratatosk_3x25.bam
samtools index ratatosk_3x25.bam

samtools view -b ratatosk_3x25.bam -L regions.bed > REGIONSratatosk_3x25.bam
samtools  index REGIONSratatosk_3x25.bam


