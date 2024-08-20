#!/bin/bash
#SBATCH -p batch
#SBATCH -N 1
#SBATCH -n 16
#SBATCH --time=03:45:00
#SBATCH --mem=64GB
# Notification configuration
#SBATCH --mail-type=ALL
#SBATCH --mail-user=joseph.mcconnell@adelaide.edu.au

source /apps/software/Anaconda3/2019.03/etc/profile.d/conda.sh
conda activate mm2
module load SAMtools

minimap2 -ax map-ont /hpcfs/groups/phoenix-hpc-rc003/joe/ref/chm13/v1.1/chr21-chm13v1.1.fa  chr21-ONT-Corrected.fa | samtools view -b | samtools sort - -o chr21_ont_cor.bam -O BAM
samtools index  chr21_ont_cor.bam
