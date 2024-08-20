#!/bin/bash -l
#SBATCH -p skylake
#SBATCH -N 1
#SBATCH -n 2
#SBATCH --time=0-01:45
#SBATCH --mem=32GB
# Notification configuration
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=joseph.mcconnell@adelaide.edu.au


conda activate samtools

# need to sort by name to get r1 and r2 correctly ?? http://www.htslib.org/doc/samtools-fasta.html
# If the input contains read-pairs which are to be interleaved or written to separate files in 
#  the same order, then the input should be first collated by name. Use samtools collate or samtools sort -n to ensure this

# hmm does this matter ?

samtools sort -n chm13v1.1.chr14.chr22.NoSEC.noNonPrim.bam >  namesorted14-22.bam

samtools fastq -1 NSr1ch14_22.fq.gz -2 NSr2ch14_22.fq.gz -0 /dev/null -s /dev/null -n  namesorted14-22.bam

