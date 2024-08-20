#!/bin/bash -l
#SBATCH -p batch
#SBATCH -N 1
#SBATCH -n 18
#SBATCH --time=0-23:45:00
#SBATCH --mem=128GB
#SBATCH --gres=tmpfs:196G
# Notification configuration
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=joseph.mcconnell@adelaide.edu.au


awk '{ fq = int((NR-1)/4) + 1; if (((fq % 15) > 9) ) { } else { print $0;} }' /hpcfs/groups/phoenix-hpc-rc003/joe/thesis/chap2/br2/dashgenreads15x.fastq > 3x25xpsuedoreads.fastq

cat 3x25xpsuedoreads.fastq  \
/hpcfs/groups/phoenix-hpc-rc003/joe/thesis/chap2/br2/srcgenreads15x.fastq  \
/hpcfs/groups/phoenix-hpc-rc003/joe/thesis/chap2/br2/srcgenreads10x.fastq  \
> 3x25_longread.fastq


# FMLRC
/home/a1779913/.cargo/bin/fmlrc2 -t 18  ../comp_msbwt_14-22.npy 3x25_longread.fastq  fmlrc_3x25longread.fastq

#RATATOSK
module load zlib
module load GCC

/hpcfs/users/a1779913/tools/ratatosk0.9/bin/Ratatosk correct -v -G -c 14 -s ../NSr1ch14_22.fq.gz -s ../NSr2ch14_22.fq.gz \
 -l 3x25_longread.fastq  -o ratatosk_3x25longread.fastq

conda activate lra 

lra align  -ONT -t 14 /hpcfs/groups/phoenix-hpc-rc003/joe/thesis/chap2/srcRef.fa fmlrc_3x25longread.fastq -p s > fmlrc_3x25longread.sam

lra align  -ONT -t 14 /hpcfs/groups/phoenix-hpc-rc003/joe/thesis/chap2/srcRef.fa ratatosk_3x25longread.fastq.fastq.gz -p s > ratatosk_3x25longread.sam


conda deactivate
conda activate samtools

samtools view -b fmlrc_3x25longread.sam | samtools sort - > fmlrc_3x25longread.bam
samtools index fmlrc_3x25longread.bam


samtools view -b ratatosk_3x25longread.sam | samtools sort - >  ratatosk_3x25longread.bam
samtools index ratatosk_3x25longread.bam
