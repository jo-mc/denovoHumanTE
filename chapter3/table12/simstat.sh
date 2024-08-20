#!/bin/bash


#samtools view -F 4079  ratatosk_3x25.bam | awk -f ~/awk/sim.awk | awk -f ~/awk/simstat.awk > ratatosk_3x25.bam.sim


samtools view -F 4079  fmlrc_3x25longread.bam | awk -f ~/awk/sim.awk | awk -f ~/awk/simstat.awk > fmlrc_3x25longread.bam.sim


samtools view -F 4079  /hpcfs/groups/phoenix-hpc-rc003/joe/thesis/chap2/br2/28X_25_3d_PsuedoGenome.bam | awk -f ~/awk/sim.awk | awk -f ~/awk/simstat.awk > 28X_25_3d_PsuedoGenome.bam.sim




