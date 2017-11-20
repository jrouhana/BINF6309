#!/bin/bash
# In the background, run SPAdes on the paired data 
# Exclude unpaired data because we have reliable coverage
# 8 threads, 50GB memory, --meta because sequencing is a SOUP
nice -n19 spades.py --pe1-1 Aip02.R1.paired.fastq --pe1-2 Aip02.R2.paired.fastq \
-t 8 -m 50 \
-o vibrioAssembly \
1> vibrioAssembly.log 2>vibrioAssembly.err &
