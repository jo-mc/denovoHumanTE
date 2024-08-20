#!/bin/bash


for f in *.fa;
 do
 echo "$f";

minimap2 -ax map-ont -t 4  /hpcfs/groups/phoenix-hpc-rc003/joe/L1HS_ALUYa5_SVA-F.fa  "$f" \
| awk 'BEGIN {OFS ="\t"} { if ($2 =="4") { next }
else   # dont show unmapped reads? potentially could want to look but dont want satellite repeates etc..
{
if ($0 ~ /^@/)
	{ print }
	else
	{
	    cigA = $6;
	    regex =  "[[:upper:]=]+"; n=split(cigA, arr, regex); regex =  "[[:digit:]]+"; m=split(cigA, brr, regex);
	    mc = 0; sc = 0; hc = 0; # get M and S count (and H for supps)
	    sc1 = 0; sc2 = 0; hc1 = 0; hc2 = 0;
	    for ( i=1; i<n; i++ )
		{
			len = arr[i]; if (brr[i+1] == "M") {mc += len}; 
			# if (brr[i+1] == "S") {sc += len}; if (brr[i+1] == "H") {hc += len};  # Replaced with start-end  below
#print n,mc,sc
 		}
	    if (brr[2] == "S") { sc1 = arr[1] } if (brr[n] == "S") { sc2 = arr[n-1] }
            if (brr[2] == "H") { hc1 = arr[1] } if (brr[n] == "H") { hc2 = arr[n-1] }
	    $1 = $1 ":M" mc ":S" sc1 "-" sc2 ":H" hc1 "-" hc2;
	    print
	}
}

}' | samtools view -b - | samtools sort - > "$f".bam
samtools index "$f".bam
samtools view "$f".bam | awk '{ print $1 ":" $2 ":" $3 ":" $4 ":" $5 ":" substr($6,1,10) "-" substr($6,length($6)-10) ":" $12 ":" substr($10,1,10) "-" substr($10,length($10)-10) }' >  "$f".loc;

done
