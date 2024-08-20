#!/bin/bash -l
#SBATCH -p highmem
#SBATCH -N 1
#SBATCH -n 16
#SBATCH --time=0-09:15:00
#SBATCH --mem=256GB
#SBATCH --gres=tmpfs:120G
# Notification configuration
#SBATCH --mail-type=ALL
#SBATCH --mail-user=joseph.mcconnell@adelaide.edu.au




conda activate fmlrc2

# set 1 and 2 lowcoverage
#fmlrc2 -t 16 comp_msbwt_20036045.npy /hpcfs/groups/phoenix-hpc-rc003/joe/ecoli/nanoporeSRR8154670/SRR8154670-fix.fasta.gz  SRR8154670.fmlrc.fasta

# set GLDS high coverage illumina
fmlrc2 -t 16 comp_msbwt_hg2chr6illx3.npy  \
	../../NanoHG002/fq_chr6.fastq  Chr6HG002_illx3.fmlrc.fasta
