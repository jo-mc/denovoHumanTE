#!/bin/bash
#SBATCH -p highmem
#SBATCH -N 1
#SBATCH -n 24
#SBATCH --time=2-20:45:00
#SBATCH --mem=256GB
# Notification configuration
#SBATCH --mail-type=ALL
#SBATCH --mail-user=joseph.mcconnell@adelaide.edu.au

module load CMake
module load zlib
module load GCC


/usr/bin/time -v  /hpcfs/users/a1779913/tools/ratatosk0.9/bin/Ratatosk correct -v -G -c 24 \
-s /hpcfs/groups/phoenix-hpc-rc003/genomeData/giabftp/data/AshkenazimTrio/HG002_NA24385_son/NIST_BGIseq_2x150bp/211109_M024_V350038332_L01_HUMuarfR092940-607_2.fq.gz \
-s /hpcfs/groups/phoenix-hpc-rc003/genomeData/giabftp/data/AshkenazimTrio/HG002_NA24385_son/NIST_BGIseq_2x150bp/211109_M024_V350038332_L01_HUMuarfR092940-607_1.fq.gz \
-s /hpcfs/groups/phoenix-hpc-rc003/genomeData/giabftp/data/AshkenazimTrio/HG002_NA24385_son/NIST_BGIseq_2x150bp/211109_M024_V350038332_L02_HUMuarfR092940-606_2.fq.gz \
-s /hpcfs/groups/phoenix-hpc-rc003/genomeData/giabftp/data/AshkenazimTrio/HG002_NA24385_son/NIST_BGIseq_2x150bp/211109_M024_V350038332_L02_HUMuarfR092940-606_1.fq.gz \
 -l ../../../NanoHG002/fq_chr6.fastq -o HG002BGI_RTSK.fasta

