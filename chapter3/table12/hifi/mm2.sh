#!/bin/bash -l
#SBATCH -p icelake
#SBATCH -N 1
#SBATCH -n 6
#SBATCH --time=02:45:00
#SBATCH --mem=16GB
#SBATCH --profile=task
# Notification configuration
#SBATCH --mail-type=ALL
#SBATCH --mail-user=joseph.mcconnell@adelaide.edu.au

conda activate mm2

minimap2 -ax map-hifi -t 6 /hpcfs/groups/phoenix-hpc-rc003/joe/thesis/chap3/SVgiabchr6GRCh37/ref_chr6.fa chr6.fastq.gz > hifiChr6.sam

conda deactivate

conda activate samtools

samtools view -b hifiChr6.sam | samtools sort - -O BAM -o hifiChr6.bam

samtools index hifiChr6.bam

conda deactivate

conda activate sniffles


sniffles --reference /hpcfs/groups/phoenix-hpc-rc003/joe/thesis/chap3/SVgiabchr6GRCh37/ref_chr6.fa  --i hifiChr6.bam --vcf hifiChr6.vcf --threads 4

conda deactivate

