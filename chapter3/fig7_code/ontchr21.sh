#!/bin/bash
#SBATCH -p skylake
#SBATCH -N 1
#SBATCH -n 3
#SBATCH --time=0-02:00:00
#SBATCH --mem=16GB
#SBATCH --gres=tmpfs:64G
# Notification configuration
#SBATCH --mail-type=NONE
#  SBATCH --array=1-25


module load SAMtools 

samtools view -b /uofaresstor/bxstor/Users/Joe/chm13v1.1/chm13.draft_v1.1.ont_guppy_3.6.0.wm_2.01.pri.bam chr21 -o /hpcfs/groups/phoenix-hpc-rc003/joe/vm-error-alt/chr21-ONT-skylake.bam

