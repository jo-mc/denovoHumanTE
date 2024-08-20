#!/bin/bash -l

conda activate samtools 

samtools view -F 4079 Chr6Hg002_illx3.fmlrc.bam | awk -f ~/awk/sim.awk > Chr6Hg002_illx3.fmlrc.bam.sim

awk -f ~/awk/simstat.awk Chr6Hg002_illx3.fmlrc.bam.sim > Chr6Hg002_illx3.fmlrc.bam.simStat
