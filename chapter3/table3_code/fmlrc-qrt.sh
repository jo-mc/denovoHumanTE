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

conda activate fmlrc2

 awk 'NR % 4 == 2' GLDS-84-qtrreads.fastq | \
    sort | \
    tr NT TN | \
    /home/a1779913/tools/ropebwt2/ropebwt2 -LR | \
    tr NT TN | \
    fmlrc2-convert  comp_msbwt_fmlrcGLDS84_QTR.npy

fmlrc2 -t 14 -C 10 comp_msbwt_fmlrcGLDS84_QTR.npy \
 /hpcfs/users/a1779913/ecoli/SRR6334890.fastq  fmlrc-SRR6334890_QTR.fa


conda activate mm2

minimap2 -ax map-ont -t 16 /hpcfs/users/a1779913/ecoli/ecoliRef.sequence.fasta  fmlrc-SRR6334890_QTR.fa > fmlrc-SRR6334890_QTR.sam


conda deactivate

conda activate samtools

samtools view -b  fmlrc-SRR6334890_QTR.sam | samtools sort - -O BAM -o fmlrc-SRR6334890_QTR.bam
samtools index fmlrc-SRR6334890_QTR.bam


conda deactivate

