#!/bin/bash -l
#SBATCH -p batch
#SBATCH -N 1
#SBATCH -n 1
#SBATCH --time=00-04:00:00
#SBATCH --mem=16GB
# SBATCH --gres=tmpfs:256G
#SBATCH --mail-type=END
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=joseph.mcconnell@adelaide.edu.au

# get another 10x reads with no error. thenhave 10X & 15 X with errror, and will have 10X and 15X without -> sample and combine to get ratios.

conda activate badread
ref="../srcRef.fa"

badread simulate --seed 42 --reference $ref --quantity 10x --error_model ../../badread/1-errorModel/new_error_model_CLR  --qscore_model ../../badread/1-errorModel/new_qscore_model_CLR > srcgenreads10x.fastq

