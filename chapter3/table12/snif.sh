#!/bin/bash -l
#SBATCH -p batch
#SBATCH -N 1
#SBATCH -n 4
#SBATCH --time=0-02:01:00
#SBATCH --mem=32GB
#SBATCH --gres=tmpfs:64G
# Notification configuration
#SBATCH --mail-type=NONE


conda activate sniffles

cd /hpcfs/groups/phoenix-hpc-rc003/joe/thesis/chap3/psuedogenome/br2


#sniffles --i fmlrc_longread.bam  --vcf fmlrc-sniffles.vcf --threads 4

sniffles --i al-ratatosk_longread.bam  --vcf ratatosk-sniffles.vcf --threads 4



