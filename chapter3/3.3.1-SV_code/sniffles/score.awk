

# score a dist file to GIAB dist

BEGIN {
debug =0;
nomatch = 0;
}

{

PROCINFO["sorted_in"] = "@ind_num_asc"

if (NR == FNR)
{
	if ($3 < 10000) { giab[$1] = $2; giabcount += 1}
}

else 
{
    sv_count += 1;
    printf("%s sv:%s:%s\t",sv_count,$1,$2);
    sv_pos = 1*$1;
    sv_len = 1*$2;
if (debug ==1) print "Looking for match to dist candidate ",sv_count, "  pos:len ",sv_pos,sv_len;
    if (sv_len < 0) { sv_offset = - sv_len} else { sv_offset = sv_len }
    tier1[0] = sv_pos - (0.1 * sv_offset);
    tier1[1] = sv_pos + (0.1 * sv_offset);
    tier2[0] = sv_pos  - (1.1 * sv_offset);
    tier2[1] = sv_pos  + (1.1 * sv_offset);
    tier3[0] = sv_pos - (2.2 * sv_offset);
    tier3[1] = sv_pos  + (2.2 * sv_offset);

    tier = 0; # result will be 1 2 or 3 if 0 no match found.
    l_tier = 0;
    p_tier = 0;
    mismatch = 0;
    gmld = 10000; gmt = 4; # te test multi match
    giab_index = 0;
if ( debug ==1 ) print "TIER 3 data cutoffs (" sv_count "): ", sv_pos, sv_len,  " t3min:max " tier3[0] ":" tier3[1] 
    for (i in giab) {
	giab_index += 1;
	gb_pos = 1*i;
	gb_len = 1*giab[i];
	if (debug ==1) print "GIAG: pos len " gb_pos,gb_len, "tier:" tier;
	if (gb_len < 0) { gb_offset = - gb_len} else { gb_offset = gb_len }
	if (  gb_pos > (sv_pos + 2.2 * sv_offset) ) 
		{
		if (tier == 0)
		{
			if (nomatch == 1) {print " NO match\t giab:" gb_pos,gb_len;} else {printf("\n")}
		}
		else
		{
			print gm
		}
		next
		} # next raw candidate
	if ( (gb_pos >= tier3[0]) && (gb_pos <= tier3[1]) ) { p_tier = 3 } else { continue }  # next GIAB SV
        if ( (gb_pos >= tier2[0]) && (gb_pos <= tier2[1]) ) { p_tier = 2 }
        if ( (gb_pos >= tier1[0]) && (gb_pos <= tier1[1]) ) { p_tier = 1 }
        if ( (sv_offset/gb_offset >= 0.5) && (sv_offset/gb_offset <= 1.5) ) { l_tier = 3 }  else { continue } # next GIAB SV
        if ( (sv_offset/gb_offset >= 0.75) && (sv_offset/gb_offset <= 1.25) ) { l_tier = 2 }
        if ( (sv_offset/gb_offset >= 0.9) && (sv_offset/gb_offset <= 1.1) ) { l_tier = 1 }
	if (p_tier >= l_tier) { tier = p_tier } else { tier = l_tier } # select highest tier based position or length
       if ( (sv_len * gb_len) > 0 ) #  are the SV both del's or ins's
	{
		len_diff = gb_len - sv_len; if (len_diff < 0) { len_diff = len_diff * -1; }
		if (debug ==1) 
		{
		 printf("\n Intermediate: MATCH\t tier: %s giab: %s %s:%s %s\n",tier,giab_index,gb_pos,gb_len,len_diff);
		}
		if (tier < gmt) # multi match 
		{ gmt = tier; gm = sprintf("MATCH\t tier: %s giab: %s %s:%s %s",tier,giab_index,gb_pos,gb_len,len_diff); }
		else {
			if ( len_diff < gmld ) { gmld = len_diff; gm = sprintf("MATCH\t tier: %s giab: %s %s:%s %s",tier,giab_index,gb_pos,gb_len,len_diff); }
		}
	} else { tier = 0 } # dont process mix match ins - del, reset tier 
# else {  # ignore for now... the algorithm wilkl pick up other matches within tiers that ar correct ins - ins or del - del mismatch is for del - ins but prob alleleic?
#	print "xxx MIS-match\t tier: " tier,"giab:" gb_pos,gb_len;   # dont report possible allelic SV ? some yes some no or not detected? print but ignore in processing
#	}
   }
if (nomatch == 1) {if (tier == 0 ) { print " NO match\t giab:" gb_pos,gb_len } else {  print gm;  }} else {printf("\n")}

}
}