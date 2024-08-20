#!/bin/bash -l
#SBATCH -p skylake
#SBATCH -N 1
#SBATCH -n 16
#SBATCH --time=0-01:15:00
#SBATCH --mem=32GB

# Notification configuration
#SBATCH --mail-type=ALL
#SBATCH --mail-user=joseph.mcconnell@adelaide.edu.au

# https://github.com/HudsonAlpha/rust-msbwt

conda activate fmlrc2

# gunzip -c ../IllumHg002/Illchr6.fastq | \
   awk 'NR % 4 == 2' ../IllumHg002/Illchr6.fastq  | \
    tr NT TN | \
    /home/a1779913/tools/ropebwt2/ropebwt2 -LR | \
    tr NT TN | \
    fmlrc2-convert comp_msbwt_IllHg002.npy
