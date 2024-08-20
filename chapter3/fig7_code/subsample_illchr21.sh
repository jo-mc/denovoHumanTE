#!/bin/bash



cat illchr21CHM13.fastq |  awk '{if (((NR %16) < 5) && ((NR % 16) > 0)) {print }}' > illchr21CHM13_33x.fastq
