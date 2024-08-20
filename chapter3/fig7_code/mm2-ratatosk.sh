#!/bin/bash -l
#SBATCH -p  skylake
#SBATCH -N 1
#SBATCH -n 4
#SBATCH --time=0-03:15:00
#SBATCH --mem=32GB
#SBATCH --gres=tmpfs:80G
# Notification configuration
#SBATCH --mail-type=ALL
#SBATCH --mail-user=joseph.mcconnell@adelaide.edu.au

#module load GLib/2.69.1-GCCcore-11.2.0

# just use qrt illumina => ?x coverage of whole chm13 genome.

# ont chr21-ONT.fasta.gz subsampled to 15.6X


#/hpcfs/users/a1779913/tools/newRata/RatatoskNEW/bin/Ratatosk correct -v -G -c 64 \
#-s illchr21CHM13_33x.fastq  \
# -l chr21-ONT-15.6X.fastq  -o ratatosk-chr21-ONT-15.6X.fa


conda activate mm2

minimap2 -ax map-ont /hpcfs/groups/phoenix-hpc-rc003/joe/ref/chm13/v1.1/chr21-chm13v1.1.fa  ratatosk-chr21-ONT-15.6X.fa.fastq.gz > rtchr21ontCor.sam

conda deactivate
conda activate samtools
	samtools view -b rtchr21ontCor.sam | samtools sort - -o rt-chr21_ont_cor.bam -O BAM
	samtools index  rt-chr21_ont_cor.bam
