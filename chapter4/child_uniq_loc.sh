#!/bin/bash

#ls *child*.loc
#cutesv-child.fa.loc  pbsv-child.fa.loc  snif-child.fa.loc  svim-child.fa.loc


awk '{ n = split($0,a,":"); loc[a[2] ":" a[3]] += 1; } END { for (i in loc) { print i } }' cutesv-child.fa.loc  pbsv-child.fa.loc  snif-child.fa.loc  svim-child.fa.loc  | \
awk '{ n=split($0,a,":"); print substr(a[1],4), a[2] }' | sort -k1,1n -k2n | awk -v OFS='\t' '{ print "chr" $1, $2 }' \
> child_locations.loc


awk '{ n = split($0,a,":"); loc[a[2] ":" a[3]] += 1; } END { for (i in loc) { print i } }'  cutesv-mother.fa.loc pbsv-father.fa.loc snif-mother.fa.loc svim-father.fa.loc cutesv-father.fa.loc pbsv-mother.fa.loc snif-father.fa.loc svim-mother.fa.loc | \
awk '{ n=split($0,a,":"); print substr(a[1],4), a[2] }' | sort -k1,1n -k2n | awk -v OFS='\t' '{ print "chr" $1, $2 }' \
> parent_locations.loc

awk ' BEGIN {
x = 0;
# range for at same location
rng = 600;
}

{
if (FNR == NR) { child[$1 ":" $2] = NR}  # NR to sort by. Location of child insertions of TE under study.
else {
 parent[$1 ":" $2] = NR;
}
} END {
pc_match = 1;
for (i in child) {
        pc_match = 0;
	n = split(i,a,":"); ch_chr = a[1]; ch_loc = a[2];
	for (j in parent) {
		n = split(j,b,":"); pa_chr = b[1]; pa_loc = b[2];
		if (ch_chr == pa_chr) {
			if ( (pa_loc < (ch_loc + rng)) && (pa_loc > (ch_loc - rng)) ) {
				pc_match = 1;
			}
		}
	}
       if (pc_match == 0) { tg = tg i "\\|" }
}
print substr(tg,1,length(tg)-2)
}' child_locations.loc parent_locations.loc   > child_uniq.loc

exit

BUT:

 grep -f -  *child.fa.loc | \

then create bed and get bam regionss But test for dups ir "cutesv-child.fa.loc:hg2:chr17:18311707:9592" from output
ie bed["cutesv-child.fa.loc:hg2:chr17:18311707:9592"] 
if (next candidate in bed) continue..


gives:
cutesv-child.fa.loc:hg2:chr9:82329263:6076:./.:.:6:.,.,.:.:M6040:S6-17:H0-0:16:L1HS:1:60:6S73M1D602-56M5I24M17S:NM:i:43:AAAACAGGGG-TGACAAAAAAC
cutesv-child.fa.loc:hg2:chr10:123570742:6108:./.:.:4:.,.,.:.:M6031:S9-68:H0-0:0:L1HS:5:60:9S69M1D596-M1D5962M68S:NM:i:30:ACTTAAAGGG-AAAAAAAAAAA
cutesv-child.fa.loc:hg2:chr2:102754252:7377:./.:.:5:.,.,.:.:M6049:S10-1309:H0-0:0:L1HS:5:60:10S480M1I1-M2I24M1309S:NM:i:53:AACAGTTATT-AAAAAAAAGAA
cutesv-child.fa.loc:hg2:chr2:143701398:6067:./.:.:5:.,.,.:.:M6046:S12-2:H0-0:0:L1HS:5:60:12S69M1D36-19M1D286M2S:NM:i:46:ATGATGGAGA-AAAAAAAAAGT
cutesv-child.fa.loc:hg2:chr8:126716413:6024:./.:.:4:.,.,.:.:M6010:S7-0:H0-0:0:L1HS:53:60:7S21M1D292-1I70M1I187M:NM:i:29:CTCACAGAGC-AAAAAAAAAAA
cutesv-child.fa.loc:hg2:chr17:18311707:9592:./.:.:6:.,.,.:.:M282:S6288-3017:H0-0:0:ALU:1:60:6288S118M1-4I156M3017S:NM:i:30:TGTTCACGTC-ACCTCCTCCTC
cutesv-child.fa.loc:hg2:chr17:18311707:9592:./.:.:6:.,.,.:.:M279:S0-0:H4120-5190:2048:ALU:1:60:4120H118M1-M1I77M5190H:NM:i:28:GGCCGGGCAC-ACTCCGTCTCA
cutesv-child.fa.loc:hg2:chr17:18311707:9592:./.:.:6:.,.,.:.:M282:S0-0:H1838-7469:2048:ALU:1:60:1838H10M1I-1I156M7469H:NM:i:33:GGCCGGGCGC-ACTCCGTCTCA
cutesv-child.fa.loc:hg2:chr17:18311707:9592:./.:.:6:.,.,.:.:M276:S0-0:H919-8393:2048:ALU:1:12:919H64M2I2-M1I19M8393H:NM:i:41:GGCCGGGCGC-ACTCCGTCTCA
cutesv-child.fa.loc:hg2:chr17:18311707:9592:./.:.:6:.,.,.:.:M256:S0-0:H1581-7753:2048:ALU:1:5:1581H29M1D-2D131M7753H:NM:i:38:GGCCGGGCAT-TCCAGCCTGGG
cutesv-child.fa.loc:hg2:chr17:18311707:9592:./.:.:6:.,.,.:.:M276:S0-0:H4862-4450:2048:ALU:1:28:4862H53M1D-1D152M4450H:NM:i:50:GGCTGGGTGT-GAGACTCTGTC
cutesv-child.fa.loc:hg2:chr19:44182654:292:./.:.:5:.,.,.:.:M279:S11-0:H0-0:0:ALU:1:27:11S64M2I62-1D126M1D27M:NM:i:44:AAAAAAAAAA-GACTCTGTCTC
cutesv-child.fa.loc:hg2:chr17:17273295:876:./.:.:17:.,.,.:.:M279:S122-475:H0-0:16:ALU:1:13:122S36M1D3-M1D155M475S:NM:i:44:TCACACCTGT-GTGTGGTGGCG
cutesv-child.fa.loc:hg2:chr17:18311707:9592:./.:.:6:.,.,.:.:M281:S0-0:H1098-8204:2064:ALU:1:20:1098H126M6-1D107M8204H:NM:i:47:GGCCGGACGA-ATTCTCTCTCA
cutesv-child.fa.loc:hg2:chr17:18311707:9592:./.:.:6:.,.,.:.:M202:S0-0:H9388-1:2064:ALU:1:29:9388H117M1-I39M1D40M1H:NM:i:18:GGCCGGGCGC-ATGACGTGAAC
cutesv-child.fa.loc:hg2:chr17:18311707:9592:./.:.:6:.,.,.:.:M268:S0-0:H2477-6840:2048:ALU:4:12:2477H61M2I-M1I19M6840H:NM:i:50:CGGGCGCAGT-ACTCCATCTCA
cutesv-child.fa.loc:hg2:chr4:3887251:311:./.:.:4:.,.,.:.:M272:S6-33:H0-0:0:ALU:11:60:6S272M33S-6S272M33S:NM:i:8:ACATGAGGTG-AAGAAGTGAGG
cutesv-child.fa.loc:hg2:chr7:99175547:311:./.:.:3:.,.,.:.:M272:S6-33:H0-0:0:ALU:11:60:6S272M33S-6S272M33S:NM:i:8:ACATGAGGTG-AAGAAGTGAGG
cutesv-child.fa.loc:hg2:chr17:18311707:9592:./.:.:6:.,.,.:.:M270:S0-0:H6174-3145:2064:ALU:11:46:6174H16M1D-1D164M3145H:NM:i:46:GGTAGCTCAT-ACTCCATCTCA
cutesv-child.fa.loc:hg2:chr17:18311707:9592:./.:.:6:.,.,.:.:M227:S0-0:H3391-5971:2064:ALU:32:31:3391H33M2I-M1I74M5971H:NM:i:33:CAGCACTTTG-CTAGCCTGGGC
cutesv-child.fa.loc:hg2:chr17:18311707:9592:./.:.:6:.,.,.:.:M228:S0-0:H516-8843:2064:ALU:55:33:516H10M2I6-M1I23M8843H:NM:i:27:GGCGGATCAC-ACTCTGTCTCA
cutesv-child.fa.loc:hg2:chr11:64162208:582:./.:.:4:.,.,.:.:M402:S40-106:H0-0:16:SVA_F:422:60:40S13M1I44-7M1I17M106S:NM:i:109:GGCCAGCCGC-CCCCTCTGCCC
cutesv-child.fa.loc:hg2:chr11:64162208:582:./.:.:4:.,.,.:.:M212:S0-0:H362-0:2064:SVA_F:613:31:362H17M4I3-M1I17M1I82M:NM:i:29:AGCCCCCCTG-CCCCTCTGCCC
pbsv-child.fa.loc:hg2:chr21:9354150:337:0/1:13,9:22:6,7,4,5:M279:S8-48:H0-0:0:ALU:1:60:8S206M2I3M-53M2D17M48S:NM:i:17:CAACTTTAGG-AAAAAAAAGAA
snif-child.fa.loc:hg2:chr16:1036055:4375:1/1:55:0:20:M279:S3043-1046:H0-0:0:ALU:1:60:3043S13M1I-1D153M1046S:NM:i:34:GCAGGGGTGC-GTGGAGGGTGC
snif-child.fa.loc:hg2:chr19:44182654:293:0/1:48:9:15:M279:S12-0:H0-0:0:ALU:1:3:12S64M2I62-2D125M1D28M:NM:i:45:AAAAAAAAAA-ACTCTGTCTCA
snif-child.fa.loc:hg2:chr12:125182577:3467:./.:35:20:2:M280:S2094-1093:H0-0:0:ALU:1:60:2094S132M2-2D148M1093S:NM:i:28:TCTCGGCTCA-CCTTTCAACAC
snif-child.fa.loc:hg2:chr4:175419876:4311:1/1:60:0:33:M282:S518-3510:H0-0:16:ALU:1:60:518S125M1I-1I157M3510S:NM:i:19:TTTCTTGGGC-TGCCTTTAGTT
snif-child.fa.loc:hg2:chr17:17273296:876:0/1:42:9:17:M281:S121-474:H0-0:16:ALU:1:15:121S126M1D-M1D155M474S:NM:i:45:TCACACCTGT-GGTGTGGTGGC
snif-child.fa.loc:hg2:chr12:125182577:3467:./.:35:20:2:M279:S0-0:H1811-1377:2064:ALU:1:60:1811H126M1-M1D25M1377H:NM:i:31:GGCCGGGCAC-ACTCCATCTCA
snif-child.fa.loc:hg2:chr4:3887252:311:0/0:40:29:4:M270:S5-32:H0-0:0:ALU:11:60:5S30M1D59M-137M1I8M32S:NM:i:14:CATGAGGTGG-AAGAAGTGAGG
snif-child.fa.loc:hg2:chr7:99175548:312:0/0:48:28:3:M271:S5-35:H0-0:0:ALU:11:60:5S108M1D44-4M1I119M35S:NM:i:10:CATGAGGTGG-AAGAAGTGAGG
svim-child.fa.loc:svi:chr17:17273295:<INS>:19:SVLEN=875::M279:S122-474:H0-0:16:ALU:1:13:122S36M1D3-M1D155M474S:NM:i:44:TCACACCTGT-GGTGTGGTGGC
svim-child.fa.loc:svi:chr11:64162208:<INS>:4:SVLEN=582::M402:S40-106:H0-0:16:SVA_F:422:60:40S13M1I44-M1I104M106S:NM:i:109:GGCCAGCCGC-GCCCCTCTGCC
svim-child.fa.loc:svi:chr18:15017476:<INS>:1:SVLEN=1636::M388:S41-1204:H0-0:16:SVA_F:439:11:41S40M1D73-M2D10M1204S:NM:i:95:CCCGCCCCAT-GCCTCTGCCAG
svim-child.fa.loc:svi:chr11:64162208:<INS>:4:SVLEN=582::M210:S0-0:H361-0:2064:SVA_F:613:20:361H17M4I3-M2I17M1I81M:NM:i:31:AGCCCCCCTG-GCCCCTCTGCC


 

