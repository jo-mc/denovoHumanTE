#!/bin/bash

samtools view -F 4079 HG002BGI_RTSK.bam | awk -f ~/awk/sim.awk | awk -f ~/awk/simstat.awk | sort -k1n | tail -n+2  > chr6-ONT-hg002.simHist.txt

