#!/bin/bash -l
#SBATCH -p batch
#SBATCH -N 1
#SBATCH -n 14
#SBATCH --time=3-0:0:0
#SBATCH --mem=192GB
#SBATCH --gres=tmpfs:120G
# Notification configuration
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=joseph.mcconnell@adelaide.edu.au

module load zlib
module load GCC

/hpcfs/users/a1779913/tools/ratatosk0.9/bin/Ratatosk correct -v -G -c 14 -s ../NSr1ch14_22.fq.gz -s ../NSr2ch14_22.fq.gz \
 -l br_longread.fastq  -o ratatosk_longread.fastq

