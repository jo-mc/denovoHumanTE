#!/bin/bash -l
#SBATCH -p highmem
#SBATCH -N 1
#SBATCH -n 16
#SBATCH --time=0-00:45:00
#SBATCH --mem=64GB
# Notification configuration
#SBATCH --mail-type=ALL
#SBATCH --mail-user=joseph.mcconnell@adelaide.edu.au



conda activate shasta

shasta --input chr6.fastq --assemblyDirectory  shasta --command assemble --threads 16 --config HiFi-Oct2021

