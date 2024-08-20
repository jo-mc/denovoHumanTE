#!/bin/bash 


awk '{ fq = int((NR-1)/4) + 1; if (((fq % 15) > 7) ) { } else { print $0;} }' /hpcfs/groups/phoenix-hpc-rc003/joe/thesis/chap2/br2/dashgenreads15x.fastq > 8x25xpsuedoreads.fastq
