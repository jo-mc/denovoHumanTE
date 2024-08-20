

 samtools view -F 4079 Chr6Hg002_ill.fmlrc.bam | awk -f ~/awk/sim.awk | awk -f ~/awk/simstat.awk |  sort -k1n | tail -n+2  > Chr6Hg002_ill.fmlrc.bam.simSTAT.txt 


