#!/bin/bash

gunzip -c  GRCh38_no_alt_analysis_set_GCA_000001405.15.fasta.gz | awk '{ if (substr($1,1,5) == ">chr6" ) { out = 1 } if (substr($1,1,5) == ">chr7") { exit} if (out == 1) { print } }' > chr6_naas.fa
