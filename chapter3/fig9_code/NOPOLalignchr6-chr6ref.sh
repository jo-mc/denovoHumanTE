#!/bin/bash -l
#SBATCH -p skylake
#SBATCH -N 1
#SBATCH -n 4
#SBATCH --time=02:55:00
#SBATCH --mem=16GB
#SBATCH --profile=task
# SBATCH --test-only    # tell me when job would start if I ran it, does not queue job!
# Notification configuration
#SBATCH --mail-type=ALL
#SBATCH --mail-user=joseph.mcconnell@adelaide.edu.au

conda activate mm2

minimap2 -ax map-ont chr6GRCh38ref.fna  ../NanoHG002/fq_chr6.fastq > REDOnoPOLchr6alignchr6.sam

conda deactivate

#conda activate samtools

#samtools sort -O BAM noPOLchr6alignchr6.sam >  noPOLchr6alignchr6.bam
#samtools index noPOLchr6alignchr6.bam

#conda deactivate






