#!/bin/bash -l
#SBATCH -p batch
#SBATCH -N 1
#SBATCH -n 4
#SBATCH --time=00-05:00:00
#SBATCH --mem=64GB
# SBATCH --gres=tmpfs:256G
#SBATCH --mail-type=END
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=joseph.mcconnell@adelaide.edu.au



conda activate samm2

# 50% : srcgenreads15x.bam
# from : 15XbrPsuedoGenome.bam & dashgenreads15x.bam

# 75%
#  srcgenreads15x.fastq
#  srcgenreads10x.fastq 
#  + 0.8 dashgenreads10x.fastq   NO >>>  + 0.8 dashgenreads10x.fastq

# 10X no error
minimap2 -ax map-ont -t 4 ../srcRef.fa srcgenreads10x.fastq | samtools view -b - | samtools sort - > srcgenreads10x.bam

# get 8/10 reads: for 8X
#  FAIL awk '{ fq = int((NR-1)/4) + 1; if (((fq % 10) == 4) || ((fq % 10) == 8) ) { } else { print $0;} }' dashgenreads10x.fastq | \
#  FAIL minimap2 -ax map-ont -t 4 ../srcRef.fa -  | samtools view -b - | samtools sort - >   dashgenreads8x.bam

# FAIL
# dashgenreads10x.fastq have low coverage spots (After seeing alignment)  so use the 15X ones sampled!!
awk '{ fq = int((NR-1)/4) + 1; if (((fq % 15) > 7) ) { } else { print $0;} }' dashgenreads15x.fastq | \
minimap2 -ax map-ont -t 4 ../srcRef.fa -  | samtools view -b - | samtools sort - >   dashgenreads8x.bam


# create 25X src to 8Xdash:  -f overwrite existing
samtools merge -@ 4 -r -f  33X_25_8d_PsuedoGenome.bam srcgenreads15x.bam srcgenreads10x.bam dashgenreads8x.bam



# 90%
#  srcgenreads15x.fastq
#  srcgenreads10x.fastq
#  +  get three out of 15
awk '{ fq = int((NR-1)/4) + 1; if (((fq % 15) == 4) || ((fq % 15) == 7) || ((fq % 15) == 12) ) { print $0;} }' dashgenreads15x.fastq | \
minimap2 -ax map-ont -t 4 ../srcRef.fa -  | samtools view -b - | samtools sort - >   dashgenreads2x.bam

# create 3X dash to 25Xsrc:
samtools merge -@ 4 -r  28X_25_3d_PsuedoGenome.bam srcgenreads15x.bam srcgenreads10x.bam dashgenreads2x.bam

