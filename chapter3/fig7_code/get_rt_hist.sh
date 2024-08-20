samtools view -F 4079 rt-chr21_ont_cor.bam | awk -f ~/awk/sim.awk | awk -f ~/awk/simstat.awk | sort -k1n | tail -n+2  > rt-chr21_ont_cor.simHist.txt

