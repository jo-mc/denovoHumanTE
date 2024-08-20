#!/bin/bash
#SBATCH -p highmem
#SBATCH -N 1
#SBATCH -n 24
#SBATCH --time=01-00:00:00
#SBATCH --mem=468GB
#SBATCH --gres=tmpfs:256G
#SBATCH --mail-type=END
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=joseph.mcconnell@adelaide.edu.au


source /apps/software/Anaconda3/2019.03/etc/profile.d/conda.sh
conda activate ropebwt2

DATADIR="/hpcfs/groups/phoenix-hpc-rc003/genomeData/ncbi/chm13/SRX1009644"
# files:
# /SRR3189741_1_fp.fastq.gz
# /SRR3189741_2_fp.fastq.gz

# get 1 and 2 reads:
gunzip -c ${DATADIR}/SRR3189741_?_fp.fastq.gz | \
    awk 'NR % 4 == 2' | \
    tr NT TN | \
    ropebwt2 -LR | \
    tr NT TN | \
    fmlrc2-convert comp_msbwt.npy


