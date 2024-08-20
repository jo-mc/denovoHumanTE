#!/bin/bash -l
#SBATCH -p skylake
#SBATCH -N 1
#SBATCH -n 6
#SBATCH --time=02:45:00
#SBATCH --mem=16GB
#SBATCH --profile=task
# Notification configuration
#SBATCH --mail-type=ALL
#SBATCH --mail-user=joseph.mcconnell@adelaide.edu.au

#conda activate mm2

#minimap2 -ax map-ont -t 6 ref_chr6.fa.gz raw_chr6.fastq > rawChr6.sam

#minimap2 -ax map-ont -t 6 ref_chr6.fa.gz rata_chr6.fasta > rataChr6.sam

#minimap2 -ax map-ont -t 6 ref_chr6.fa.gz fmlrc_chr6.fasta > fmlrcChr6.sam

#conda deactivate
#conda activate samtools

#samtools view -b rawChr6.sam |  samtools sort - -o rawChr6.bam -O BAM
#samtools index rawChr6.bam

#samtools view -b rataChr6.sam | samtools sort - -o rataChr6.bam -O BAM
#samtools index rataChr6.bam

#samtools view -b fmlrcChr6.sam | samtools view -b - | samtools sort - -o fmlrcChr6.bam -O BAM
#samtools index fmlrcChr6.bam

#conda deactivate
#conda activate sniffles

# need ref_chr6.fa not zipped as need index, can we use gz with index ??

sniffles --reference ref_chr6.fa  --i rawChr6.bam --vcf rawChr6.vcf --threads 4
sniffles --reference ref_chr6.fa  --i rawChr6.bam  --vcf rawChr6mosaic.vcf --threads 4 --mosaic-include-germline

sniffles --reference ref_chr6.fa --i rataChr6.bam --vcf rataChr6.vcf --threads 4
sniffles --reference ref_chr6.fa --i rataChr6.bam  --vcf rataChr6mosaic.vcf --threads 4 --mosaic-include-germline

sniffles --reference ref_chr6.fa --i fmlrcChr6.bam --vcf fmlrcChr6.vcf --threads 4
sniffles --reference ref_chr6.fa --i fmlrcChr6.bam  --vcf fmlrcChr6mosaic.vcf --threads 4 --mosaic-include-germline
