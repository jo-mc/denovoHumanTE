#!/bin/bash 


#  awk -f score.VCFsim.awk combvcf.dist | less
#(base) [a1779913@p2-log-2 evalVCF]$  pwd
#/hpcfs/groups/phoenix-hpc-rc003/joe/thesis/chap3/SVgiabchr6GRCh37/evalVCF
#(base) [a1779913@p2-log-2 evalVCF]$


awk '{

PROCINFO["sorted_in"] = "@ind_num_asc"
if ($1 == "GIAB") { giab[$2] = $3; maxG = $2; giabcount += 1}

leasta = maxG
rd =0; rl = 0;
if ($1 == "hifi") {
    #print "HIFI ", $0
    hificount += 1;
    for (i in giab) {
        a = $2 - i
        #printf("%s\t",a)
        if (a < 0) { a = a * -1}
        #printf("%s\t\n",a)
        if (a < leasta) { rd = $2; rl = $3; gd = i; gl = giab[i]; leasta = a}
    }
        if ((rd + rl) > 0) {
            d =  (rd - gd); if (d < 0) { d = d * - 1}
            if (d > gl) { hifimiss += 1}
            else {hifimatch += 1; hifiAcc += 100*(rl/gl); print rd,rl,gd,gl }
        } else {
            hifimiss += 1;
        }
}
}
END {
#for (i in giab) { print i,giab[i]; c += 1}
#    print c
printf("GIAB SVs: %s. HiFi SVs %s\n",giabcount,hificount)
printf(" HIFI match to GIAB %s,  HIFI not in GAIB %s, Average accuracy in SV length %s\n",hifimatch,hifimiss,int(hifiAcc/hifimatch))
}'  cuteSV-combvcf.dist | less -S


