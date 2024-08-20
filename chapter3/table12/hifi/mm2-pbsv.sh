#!/bin/bash -l
#SBATCH -p highmem
#SBATCH -N 1
#SBATCH -n 13
#SBATCH --time=02:45:00
#SBATCH --mem=64GB
#SBATCH --profile=task
# Notification configuration
#SBATCH --mail-type=ALL
#SBATCH --mail-user=joseph.mcconnell@adelaide.edu.au

conda activate mm2


	minimap2 -ax map-hifi -Y -R @RG\\tID:hg2chr6 -t 13 /hpcfs/groups/phoenix-hpc-rc003/joe/thesis/chap3/SVgiabchr6GRCh37/ref_chr6.fa chr6.fastq.gz > pbsvchr6hifi.sam
		# -Y use soft clip for supp alignments. needed for pbsv, not sure of impact on other SV callers.

        conda activate samtools
	  samtools view -b pbsvchr6hifi.sam | samtools sort -O BAM -o pbsvchr6hifi.bam
	  samtools index pbsvchr6hifi.bam
        conda deactivate
	rm pbsvchr6hifi.sam

        conda activate pbsv
         pbsv discover pbsvchr6hifi.bam pbsvchr6hifi.bam.svsig.gz
         pbsv call /hpcfs/groups/phoenix-hpc-rc003/joe/thesis/chap3/SVgiabchr6GRCh37/ref_chr6.fa pbsvchr6hifi.bam.svsig.gz pbsvchr6hifi.vcf
       conda deactivate

####

