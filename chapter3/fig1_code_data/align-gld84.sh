#!/bin/bash -l
#SBATCH -p skylake
#SBATCH -N 1
#SBATCH -n 4
#SBATCH --time=0-00:45:00
#SBATCH --mem=8GB
#SBATCH --gres=tmpfs:80G
# Notification configuration
#SBATCH --mail-type=ALL
#SBATCH --mail-user=joseph.mcconnell@adelaide.edu.au



conda activate bwamem2

#bwa-mem2 index /hpcfs/users/a1779913/ecoli/GLDS-84_Illumina_sequencing_Ecoli_illumina.fastq.gz
bwa-mem2 mem /hpcfs/users/a1779913/ecoli/ecoliRef.sequence.fasta \
 /hpcfs/users/a1779913/ecoli/GLDS-84_Illumina_sequencing_Ecoli_illumina.fastq.gz \
 -o GLDS-84_Illumina-ecoli.sam
