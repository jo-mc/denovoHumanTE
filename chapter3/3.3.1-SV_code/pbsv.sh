#!/bin/bash -l
#SBATCH -p highmem
#SBATCH -N 1
#SBATCH -n 10
#SBATCH --time=03:45:00
#SBATCH --mem=64GB
#SBATCH --profile=task
# Notification configuration
#SBATCH --mail-type=ALL
#SBATCH --mail-user=joseph.mcconnell@adelaide.edu.au

conda activate mm2

#minimap2 -ax map-ont -t 6 ref_chr6.fa.gz raw_chr6.fastq > rawChr6.sam

if [ -e "pbsvchr6raw.bam" ]
then
        echo "pbsvchr6raw.bam exists"
else
	minimap2 -ax map-ont -Y -R @RG\\tID:hg2chr6 -t 13 ref_chr6.fa.gz raw_chr6.fastq > pbsvchr6raw.sam
		# -Y use soft clip for supp alignments. needed for pbsv, not sure of impact on other SV callers.

        conda activate samtools
	  samtools view -b pbsvchr6raw.sam | samtools sort -O BAM -o pbsvchr6raw.bam
	  samtools index pbsvchr6raw.bam
        conda deactivate
	rm pbsvchr6raw.sam

        conda activate pbsv
         pbsv discover pbsvchr6raw.bam pbsvchr6raw.bam.svsig.gz
         pbsv call ref_chr6.fa.gz pbsvchr6raw.bam.svsig.gz pbsvchr6raw.vcf
       conda deactivate

fi

#fmlrc_chr6.fasta  rata_chr6.fasta

if [ -e "pbsvchr6rata.bam" ]
then
        echo "pbsvchr6rata.bam exists"
else
        minimap2 -ax map-ont -Y -R @RG\\tID:hg2chr6 -t 13 ref_chr6.fa.gz rata_chr6.fasta > pbsvchr6rata.sam
                # -Y use soft clip for supp alignments. needed for pbsv, not sure of impact on other SV callers.

        conda activate samtools
          samtools view -b pbsvchr6rata.sam | samtools sort -O BAM -o pbsvchr6rata.bam
          samtools index pbsvchr6rata.bam
        conda deactivate
        rm pbsvchr6rata.sam

        conda activate pbsv
         pbsv discover pbsvchr6rata.bam  pbsvchr6rata.bam.svsig.gz
         pbsv call ref_chr6.fa  pbsvchr6rata.bam.svsig.gz pbsvchr6rata.vcf
       conda deactivate

fi

if [ -e "pbsvchr6fmlrc.bam" ]
then
        echo "pbsvchr6fmlrc.bam exists"
else
        minimap2 -ax map-ont -Y -R @RG\\tID:hg2chr6 -t 13 ref_chr6.fa.gz fmlrc_chr6.fasta > pbsvchr6fmlrc.sam
                # -Y use soft clip for supp alignments. needed for pbsv, not sure of impact on other SV callers.

        conda activate samtools
          samtools view -b pbsvchr6fmlrc.sam | samtools sort -O BAM -o pbsvchr6fmlrc.bam
          samtools index pbsvchr6fmlrc.bam
        conda deactivate
        rm pbsvchr6fmlrc.sam

        conda activate pbsv
         pbsv discover pbsvchr6fmlrc.bam  pbsvchr6fmlrc.bam.svsig.gz
         pbsv call ref_chr6.fa  pbsvchr6fmlrc.bam.svsig.gz pbsvchr6fmlrc.vcf
       conda deactivate

fi


