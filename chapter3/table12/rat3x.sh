#!/bin/bash -l
#SBATCH -p batch
#SBATCH -N 1
#SBATCH -n 14
#SBATCH --time=0-13:45:00
#SBATCH --mem=128GB
# SBATCH --gres=tmpfs:196G
# Notification configuration
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=joseph.mcconnell@adelaide.edu.au


#RATATOSK
module load zlib
module load GCC

/hpcfs/users/a1779913/tools/ratatosk0.9/bin/Ratatosk correct -v -G -c 14 -s ../NSr1ch14_22.fq.gz -s ../NSr2ch14_22.fq.gz \
 -l 3xComp/3x_25reads.fa  -o ratatosk_3x25.fastq

