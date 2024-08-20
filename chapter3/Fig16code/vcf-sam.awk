
BEGIN {
print "@SQ	SN:chr6	LN:171115067"
print "@PG	ID:vcf-sam.awk	PN:vcf-sam.awk	VN:0.1	CL:awk -f vcf-sam.awk ", ARGV[1]

}
{
if ($0 ~ /^#/) { next }

debug = 0;  # 1 to print debug info

n=split($8,info,";")
if (debug ==1) print " info size: ",n;

if (info[2] == "MOSAIC") {svtype = substr(info[3],8); } else { svtype = substr(info[2],8); }  # sniffles alters order of info

if (debug ==1) print " svtype: ",svtype;
flag = -1;
if (svtype == "DEL") { flag = 16; seq = $4 }
if (svtype == "INS") { flag = 0; seq = $5}
if (debug ==1) print "flag: ",flag, " seq: ",seq;
if (flag == -1) { next }

if (info[2] == "MOSAIC") {cvlen = substr(info[4],7);} else {cvlen = substr(info[3],7);}
cvlen = cvlen * 1;
if (flag == 16) { cvlen =  cvlen * -1 }
if (debug ==1) print " >>>>> length: ", cvlen;
if  (cvlen  < 50 ) { next}  # NEED TO VARY ? ~300 and ~ 1000 - 6000 and SVA? 
if (cvlen > 20000) { next}

cigar = cvlen "M";
# cvlen ie reported SVLEN can be different from actual sequence length so update:
cigar = length(seq) "M";

if (debug ==1) print "cigar ",cigar;
if (info[2] == "MOSAIC")  {spt = info[6] "/support"; } else { spt = info[5] "/support";}
if (debug ==1) print "support", spt;
if (info[2] == "MOSAIC")  {n = split(substr(info[11],11),cv,",");} else { n = split(substr(info[10],10),cv,","); }
for (i=1;i<=n;i++) { avcv =+ cv[i] }
avcv = int(avcv/n);
avcv = avcv "/AvgCov";
n = split($10,a,":");
gentyp = "";
for (i=1;i<=n;i++) { gentyp = gentyp a[i] "/" }    #  XA:Z:PRECISE    XB:Z:SUPPORT=45/support XC:Z:0/AvgCov   XD:Z:0/1/60/32/45/
if (info[2] == "MOSAIC") { gentyp = gentyp " XE:Z:MOSAIC" } 
if (debug ==1) print "avcv : ", avcv, "  gentype : ",gentyp;
printf("%s-%s\t%s\t%s\t%s\t%s\t%s\t*\t0\t0\t%s\t*\tNM:i:0\tXA:Z:%s\tXB:Z:%s\tXC:Z:%s\tXD:Z:%s\n",$3,cvlen,flag,$1,$2,$6,cigar,seq,info[1],spt,avcv,gentyp)
}

