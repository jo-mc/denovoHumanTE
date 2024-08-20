
#  awk -f score.VCFsim.awk combvcf.dist | less
#(base) [a1779913@p2-log-2 evalVCF]$  pwd
#/hpcfs/groups/phoenix-hpc-rc003/joe/thesis/chap3/SVgiabchr6GRCh37/evalVCF
#(base) [a1779913@p2-log-2 evalVCF]$


{

PROCINFO["sorted_in"] = "@ind_num_asc"
if ($1 == "GIAB") { if ($3 < 10000) { giab[$2] = $3; maxG = $2; giabcount += 1} }  # ignore sv greater then 10000 i think one 25K variant match but otherwise does not perform well.

# have GIAB variants (ins and DEL) in array  giab[position] = length; length is -ve for deletion. 

leasta = maxG
rd =0; rl = 0;
if ($1 == "raw") {
    #print "raw ", $0
    rawcount += 1;
    for (i in giab) {
        a = $2 - i
        #printf("%s\t",a)
        if (a < 0) { a = a * -1}
        #printf("%s\t\n",a)
        if (a < leasta) { rd = $2; rl = $3; gd = i; gl = giab[i]; leasta = a}
    }
        if ((rd + rl) > 0) {
            d =  (rd - gd); if (d < 0) { d = d * - 1}
            if (d > gl) { rawmiss += 1}  
            else {rawmatch += 1; rawAcc += 100*(rl/gl); print "raw",rd,rl,gd,gl }
        } else {
            rawmiss += 1;
        }
}

leasta = maxG
rd =0; rl = 0;
if ($1 == "rata") {
    #print "raw ", $0
    ratacount += 1;
    for (i in giab) {
        a = $2 - i
        #printf("%s\t",a)
        if (a < 0) { a = a * -1}
        #printf("%s\t\n",a)
        if (a < leasta) { rd = $2; rl = $3; gd = i; gl = giab[i]; leasta = a}
    }
        if ((rd + rl) > 0) {
            d =  (rd - gd); if (d < 0) { d = d * - 1}
            if (d > gl) { ratamiss += 1}  
            else {ratamatch += 1; rataAcc += 100*(rl/gl); print "rat",rd,rl,gd,gl }
        } else {
            ratamiss += 1;
        }    

}

leasta = maxG
rd =0; rl = 0;
if ($1 == "fmlrc") {
    #print "raw ", $0
    fmlrccount += 1;
    for (i in giab) {
        a = $2 - i
        #printf("%s\t",a)
        if (a < 0) { a = a * -1}
        #printf("%s\t\n",a)
        if (a < leasta) { rd = $2; rl = $3; gd = i; gl = giab[i]; leasta = a}
    }
    if ((rd + rl) > 0) {
        d =  (rd - gd);
        if (d < 0) { d = d * - 1}
        if (d > gl) {
		fmlrcmiss += 1
        } else {
		fmlrcmatch += 1; fmlrcAcc += 100*(rl/gl);  print "fml",rd,rl,gd,gl
	}
     } else {
        fmlrcmiss += 1;
     }
}



}

END {
#for (i in giab) { print i,giab[i]; c += 1}
#    print c
printf("GIAB SV's: %s. Raw SV's : %s. Ratatosk SV's : %s FMLRC SV's %s\n",giabcount,rawcount,ratacount,fmlrccount)
printf(" RAW match to GIAB %s,  Raw not in GAIB %s, Average accuracy in SV length %s\n",rawmatch,rawmiss,int(rawAcc/rawmatch))
printf(" RATATOSK match to GIAB %s,  Ratatosk not in GAIB %s, Average accuracy in SV length %s\n",ratamatch,ratamiss,int(rataAcc/ratamatch))
printf(" FMLRC match to GIAB %s,  FMLRC not in GAIB %s, Average accuracy in SV length %s\n",fmlrcmatch,fmlrcmiss,int(fmlrcAcc/fmlrcmatch))
}
