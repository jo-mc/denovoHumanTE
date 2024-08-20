#!/bin/bash

# awk -f score.VCFsim.awk combvcf-remdup.dist > results-remdup


awk -f score.VCFsim.awk combvcf.dist > results

