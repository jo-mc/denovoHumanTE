#!/bin/bash



# use awk to ensure newlines inserted properly. 

awk '{if (NR ==1) { print ">chr14dash"} else {if (length($0) != 0) print $0}}' gChr14dash.fa > srcRefdash.fa

awk '{if (NR ==1) { print ">chr22dash"} else {if (length($0) != 0) print $0}}' gChr22dash.fa >> srcRefdash.fa
