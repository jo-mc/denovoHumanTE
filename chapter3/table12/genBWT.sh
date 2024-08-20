#!/bin/bash -l
#SBATCH -p skylakehm
#SBATCH -N 1
#SBATCH -n 2
#SBATCH --time=0-02:45:00
#SBATCH --mem=64GB
#SBATCH --gres=tmpfs:64G
# Notification configuration
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=joseph.mcconnell@adelaide.edu.au

conda activate fmlrc

gunzip -c NSr1ch14_22.fq.gz NSr2ch14_22.fq.gz | \
    awk 'NR % 4 == 2' | \
    sort | \
    tr NT TN | \
    /home/a1779913/tools/ropebwt2/ropebwt2 -LR | \
    tr NT TN | \
    fmlrc-convert -f comp_msbwt_14-22.npy
