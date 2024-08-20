#!/bin/bash -l
#SBATCH -p batch
#SBATCH -N 1
#SBATCH -n 2
#SBATCH --time=01:45:00
#SBATCH --mem=32GB
# Notification configuration
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=joseph.mcconnell@adelaide.edu.au


child_chm13="/hpcfs/groups/phoenix-hpc-rc003/genomeData/giabftp/data/ChineseTrio/HG005_NA24631_son/PacBio_CCS_15kb_20kb_chemistry2/HG005.chm13.deepvariant.haplotagged.bam"
mother_chm13="/hpcfs/groups/phoenix-hpc-rc003/genomeData/giabftp/data/ChineseTrio/HG007_NA24695-hu38168_mother/PacBio_CCS_15kb_20kb_chemistry2/HG007.chm13.deepvariant.haplotagged.bam"
father_chm13="/hpcfs/groups/phoenix-hpc-rc003/genomeData/giabftp/data/ChineseTrio/HG006_NA24694-huCA017E_father/PacBio_CCS_15kb_20kb_chemistry2/HG006.chm13.deepvariant.haplotagged.bam"


bed="bamregions.bed"

conda activate samtools


samtools view -b "$child_chm13"  -L "$bed" > childRegions.bam
samtools index childRegions.bam

samtools view -b "$father_chm13"  -L "$bed" > fatherRegions.bam
samtools index fatherRegions.bam

samtools view -b "$mother_chm13"  -L "$bed" > motherRegions.bam
samtools index motherRegions.bam

