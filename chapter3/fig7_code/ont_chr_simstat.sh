#!/bin/bash

samtools view -F 4079 /uofaresstor/bxstor/Users/Joe/chm13_Alignments_T2T/chm13.draft_v1.1.ont_guppy_3.6.0.wm_2.01.pri.bam chr21 | \
awk -f ~/awk/sim.awk | awk -f ~/awk/simstat.awk | \
sort -k1n chr21-ONT.simHst.txt | tail -n+2  > chr21-ONT.simHist.txt
