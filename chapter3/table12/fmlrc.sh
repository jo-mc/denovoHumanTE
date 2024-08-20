#!/bin/bash -l
#SBATCH -p batch
#SBATCH -N 1
#SBATCH -n 18
#SBATCH --time=0-23:45:00
#SBATCH --mem=128GB
#SBATCH --gres=tmpfs:196G
# Notification configuration
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=joseph.mcconnell@adelaide.edu.au



/home/a1779913/.cargo/bin/fmlrc2 -t 18  ../comp_msbwt_14-22.npy br_longread.fastq  fmlrc_longread.fastq

