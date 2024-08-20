#!/bin/bash
#SBATCH -p highmem
#SBATCH -N 1
#SBATCH -n 12
#SBATCH --time=02-00:00:00
#SBATCH --mem=480GB
#SBATCH --gres=tmpfs:256G
#SBATCH --mail-type=END
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=joseph.mcconnell@adelaide.edu.au



#short_reads="/hpcfs/groups/phoenix-hpc-rc003/joe/correction/chm13/illumina.fastq.gz"
#long_reads="/hpcfs/groups/phoenix-hpc-rc003/genomeData/ncbi/chm13/SRX2010003/pacbio_clr.fastq.gz"

long_reads="chr21-ONT.fasta.gz"

# B step:

fmlrc2 -t 12 comp_msbwt.npy ${long_reads} chr21-ONT-Corrected.fa

