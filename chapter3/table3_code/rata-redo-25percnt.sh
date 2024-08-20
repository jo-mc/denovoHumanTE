#!/bin/bash -l
#SBATCH -p skylake
#SBATCH -N 1
#SBATCH -n 16
#SBATCH --time=0-01:15:00
#SBATCH --mem=64GB
#SBATCH --gres=tmpfs:80G
# Notification configuration
#SBATCH --mail-type=ALL
#SBATCH --mail-user=joseph.mcconnell@adelaide.edu.au

module load GLib/2.69.1-GCCcore-11.2.0

/hpcfs/users/a1779913/tools/newRata/RatatoskNEW/bin/Ratatosk correct -v -G -c 16 \
-s GLDS-84-qtrreads.fastq  \
 -l /hpcfs/users/a1779913/ecoli/SRR6334890.fastq -o ratatosk-25-SRR6334890.fa

conda activate mm2

minimap2 -ax map-ont -t 16 /hpcfs/users/a1779913/ecoli/ecoliRef.sequence.fasta  ratatosk-50-SRR6334890.fa.fastq.gz > ratatosk-50-SRR6334890.sam


conda deactivate

conda activate samtools

samtools view -b  ratatosk-25-SRR6334890.sam | samtools sort - -O BAM -o ratatosk-25-SRR6334890.bam
samtools index ratatosk-25-SRR6334890.bam


conda deactivate

