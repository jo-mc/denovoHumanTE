#!/bin/bash -l
#SBATCH -p  a100cpu
#SBATCH -N 1
#SBATCH -n 32
#SBATCH --time=2-20:15:00
#SBATCH --mem=8GB
#SBATCH --gres=tmpfs:80G
# Notification configuration
#SBATCH --mail-type=ALL
#SBATCH --mail-user=joseph.mcconnell@adelaide.edu.au

module load GLib/2.69.1-GCCcore-11.2.0

# just use qrt illumina => ?x coverage of whole chm13 genome.

# ont chr21-ONT.fasta.gz subsampled to 15.6X


/hpcfs/users/a1779913/tools/newRata/RatatoskNEW/bin/Ratatosk correct -v -G -c 32 \
-s illchr21CHM13_33x.fastq  \
 -l chr21-ONT-15.6X.fastq  -o ratatosk-chr21-ONT-15.6X.fa

#conda activate mm2
#minimap2 -ax map-ont -t  /hpcfs/users/a1779913/ecoli/ecoliRef.sequence.fasta  ratatosk-50-chr21-ONT-15.6X.fa > ratatosk-50-SRR6334890.sam#
#conda deactivate
#conda activate samtools
#samtools view -b  ratatosk-50-SRR6334890.sam | samtools sort - -O BAM -o ratatosk-50-SRR6334890.bam
#samtools index ratatosk-50-SRR6334890.bam
#conda deactivate

