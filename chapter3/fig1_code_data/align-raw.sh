#!/bin/bash -l
#SBATCH -p skylake
#SBATCH -N 1
#SBATCH -n 8
#SBATCH --time=0-00:15:00
#SBATCH --mem=32GB
#SBATCH --gres=tmpfs:80G
# Notification configuration
#SBATCH --mail-type=ALL
#SBATCH --mail-user=joseph.mcconnell@adelaide.edu.au


conda activate mm2

minimap2 -ax map-ont -t 8 /hpcfs/users/a1779913/ecoli/ecoliRef.sequence.fasta  /hpcfs/users/a1779913/ecoli/SRR6334890.fastq > SRR6334890.sam


conda deactivate

conda activate samtools

samtools view -b  SRR6334890.sam | samtools sort - -O BAM -o SRR6334890.bam
samtools index SRR6334890.bam


conda deactivate

