BEGIN {
# generate header
print "@SQ	SN:chr6	LN:171115067"
print "@PG	ID:gvcf-sam.awk	PN:gvcf-sam.awk	VN:0.1	CL:awk -f gvcf-sam.awk ", ARGV[1]

}


{ if ($0 ~ /^#/) next;
sizecat = ""
        n = split($8,a,";");
        for (i=1;i<=n;i++) {
                if (index(a[i],"SVTYPE") > 0) { svtype = substr(a[i],8) }
                if (index(a[i],"SVLEN") > 0) { svlen = substr(a[i],7) }
		if (index(a[i],"HG2count") > 0) { spt = a[i] "/support"; }
        }
svlen = svlen * 1;

if (svtype == "DEL") { flag = 16; seq = $4 }
if (svtype == "INS") { flag = 0; seq = $5}

cvlen = svlen;

cvlen = cvlen * 1;
if (flag == 16) { cvlen =  cvlen * -1 }
if  (cvlen  < 50 ) { next}  # NEED TO VARY ? ~300 and ~ 1000 - 6000 and SVA? 
if (cvlen > 20000) { next}

cigar = length(seq) "M";
n = split($10,b,"/");
gentyp = b[4];

chromo = "chr" $1;    # check chr id match with ref and SQ tag at top
printf("%s-%s\t%s\t%s\t%s\t%s\t%s\t*\t0\t0\t%s\t*\tNM:i:0\tXA:Z:%s\tXB:Z:%s\tXD:Z:%s\n",$3,cvlen,flag,chromo,$2,$6,cigar,seq,$7,spt,gentyp)
}




