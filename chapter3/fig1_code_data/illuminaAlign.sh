#!/bin/bash -l
#SBATCH -p skylake
#SBATCH -N 1
#SBATCH -n 16
#SBATCH --time=0-01:15:00
#SBATCH --mem=64GB
#SBATCH --gres=tmpfs:80G
# Notification configuration
#SBATCH --mail-type=ALL
#SBATCH --mail-user=joseph.mcconnell@adelaide.edu.au

conda activate bwamem2

bwa-mem2 index /hpcfs/users/a1779913/ecoli/ecoliRef.sequence.fasta

bwa-mem2 mem  /hpcfs/users/a1779913/ecoli/ecoliRef.sequence.fasta \
         /hpcfs/users/a1779913/ecoli/GLDS-84_Illumina_sequencing_Ecoli_illumina.fastq.gz > illumina-GLD84.sam

conda deactivate

