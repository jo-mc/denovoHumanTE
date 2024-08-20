#!/bin/bash -l
#SBATCH -p batch
#SBATCH -N 1
#SBATCH -n 4
#SBATCH --time=01-00:00:00
#SBATCH --mem=64GB
# SBATCH --gres=tmpfs:256G
#SBATCH --mail-type=END
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=joseph.mcconnell@adelaide.edu.au

conda activate badread
ref="../srcRef.fa"

badread simulate --seed 21 --reference $ref --quantity 15x --error_model ../../badread/1-errorModel/new_error_model_CLR  --qscore_model ../../badread/1-errorModel/new_qscore_model_CLR > srcgenreads15x.fastq

ref="../srcRefdash.fa"
badread simulate --seed 21 --reference $ref --quantity 15x --error_model ../../badread/1-errorModel/new_error_model_CLR  --qscore_model ../../badread/1-errorModel/new_qscore_model_CLR > dashgenreads15x.fastq

conda deactivate
conda activate mm2
# regenerate reads with original error model to see if still get same insert variation?

minimap2 -ax map-ont -t 4 ../srcRef.fa dashgenreads15x.fastq > dashgenreads15x.sam

conda activate samtools
samtools view -b dashgenreads15x.sam | samtools sort - > dashgenreads15x.bam
samtools index dashgenreads15x.bam

conda deactivate
conda activate mm2
minimap2 -ax map-ont -t 4 ../srcRef.fa srcgenreads15x.fastq > srcgenreads15x.sam

conda activate samtools
samtools view -b srcgenreads15x.sam | samtools sort - > srcgenreads15x.bam
samtools index srcgenreads15x.bam
