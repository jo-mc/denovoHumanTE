#!/bin/bash -l
#SBATCH -p highmem
#SBATCH -N 1
#SBATCH -n 4
#SBATCH --time=0-09:15:00
#SBATCH --mem=128GB
#SBATCH --gres=tmpfs:120G
# Notification configuration
#SBATCH --mail-type=ALL
#SBATCH --mail-user=joseph.mcconnell@adelaide.edu.au

# https://github.com/HudsonAlpha/rust-msbwt

conda activate fmlrc2

gunzip -c ../IllumHg002/Illchr6.fastq.gz \
 /hpcfs/groups/phoenix-hpc-rc003/genomeData/giabftp/data/AshkenazimTrio/HG002_NA24385_son/NIST_BGIseq_2x150bp/211109_M024_V350038332_L01_HUMuarfR092940-607_2.fq.gz \
 /hpcfs/groups/phoenix-hpc-rc003/genomeData/giabftp/data/AshkenazimTrio/HG002_NA24385_son/NIST_BGIseq_2x150bp/211109_M024_V350038332_L01_HUMuarfR092940-607_1.fq.gz \
 /hpcfs/groups/phoenix-hpc-rc003/genomeData/giabftp/data/AshkenazimTrio/HG002_NA24385_son/NIST_BGIseq_2x150bp/211109_M024_V350038332_L02_HUMuarfR092940-606_2.fq.gz \
 /hpcfs/groups/phoenix-hpc-rc003/genomeData/giabftp/data/AshkenazimTrio/HG002_NA24385_son/NIST_BGIseq_2x150bp/211109_M024_V350038332_L02_HUMuarfR092940-606_1.fq.gz | \
   awk 'NR % 4 == 2'  | \
    tr NT TN | \
    /home/a1779913/tools/ropebwt2/ropebwt2 -LR | \
    tr NT TN | \
    fmlrc2-convert comp_msbwt_hg2chr6illx3.npy
