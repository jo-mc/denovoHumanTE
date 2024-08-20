#!/bin/bash -l
#SBATCH -p icelake
#SBATCH -N 1
#SBATCH -n 6
#SBATCH --time=02:45:00
#SBATCH --mem=8GB
#SBATCH --profile=task
# Notification configuration
#SBATCH --mail-type=ALL
#SBATCH --mail-user=joseph.mcconnell@adelaide.edu.au

conda activate mm2

#/usr/bin/time -v minimap2 -ax map-ont ../../chr6HG002/chr6GRCh38ref.fna  Chr6HG002_illx3.fmlrc.fasta > Chr6Hg002_illx3.fmlrc.sam # wrogn ref need hg29 for comparison

 minimap2 -ax map-ont /hpcfs/groups/phoenix-hpc-rc003/joe/thesis/chap3/SVgiabchr6GRCh37/ref_chr6.fa HG002BGI_RTSK.fasta.fastq.gz  > HG002BGI_RTSK.sam
 minimap2 -ax map-hifi /hpcfs/groups/phoenix-hpc-rc003/joe/thesis/chap3/SVgiabchr6GRCh37/ref_chr6.fa HG002BGI_RTSK.fasta.fastq.gz  > HG002BGI_RTSK-hifimode.sam

conda deactivate
conda activate samtools
 samtools sort -O BAM HG002BGI_RTSK.sam > HG002BGI_RTSK.bam
samtools sort -O BAM HG002BGI_RTSK.sam > HG002BGI_RTSK-hifimode.bam

 samtools index HG002BGI_RTSK.bam
 samtools index HG002BGI_RTSK-hifimode.bam
conda deactivate

