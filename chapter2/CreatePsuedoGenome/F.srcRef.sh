#!/bin/bash


#cat gChr14.fa gChr22.fa > srcRef.fa

# use awk to ensure newlines inserted properly. 

awk '{if (length($0) != 0) print $0}' gChr14.fa > srcRef.fa

awk '{if (length($0) != 0) print $0}' gChr22.fa >> srcRef.fa
