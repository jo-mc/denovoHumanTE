#!/bin/bash -l
#SBATCH -p skylake
#SBATCH -N 1
#SBATCH -n 6
#SBATCH --time=02:45:00
#SBATCH --mem=8GB
#SBATCH --profile=task
# Notification configuration
#SBATCH --mail-type=ALL
#SBATCH --mail-user=joseph.mcconnell@adelaide.edu.au

conda activate mm2

/usr/bin/time -v minimap2 -ax map-ont ../chr6HG002/chr6GRCh38ref.fna Chr6Hg002_ill.fmlrc.fasta > Chr6Hg002_ill.fmlrc.sam

conda deactivate
conda activate samtools
 samtools sort -O BAM Chr6Hg002_ill.fmlrc.sam > Chr6Hg002_ill.fmlrc.bam

 samtools index Chr6Hg002_ill.fmlrc.bam

conda deacitvate
