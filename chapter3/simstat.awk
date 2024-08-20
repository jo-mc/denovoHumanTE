

{
sim = int($9*100)/100
stats[sim] += 1;
}

END {
for (i in stats) { print i, stats[i] }
}
