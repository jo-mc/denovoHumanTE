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

lra align  -ONT -t 14 /hpcfs/groups/phoenix-hpc-rc003/joe/thesis/chap2/srcRef.fa fmlrc_longread.fastq -p s > fmlrc_longread.sam

lra align  -ONT -t 14 /hpcfs/groups/phoenix-hpc-rc003/joe/thesis/chap2/srcRef.fa ratatosk_longread.fastq.fastq.gz -p s > ratatosk_longread.sam


conda deactivate
conda activate samtools

samtools view -b fmlrc_longread.sam | samtools sort - > fmlrc_longread.bam
samtools index fmlrc_longread.bam

samtools view -b ratatosk_longread.sam | samtools sort - >  ratatosk_longread.bam
samtools index ratatosk_longread.bam
