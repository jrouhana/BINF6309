#!/bin/bash
# faidx option to index/extract FASTA
# Piccard creates a sequence dictionary for reference
# R is the input file, 0 is the output
samtools faidx vShiloni.fasta
java -jar /usr/local/bin/picard.jar CreateSequenceDictionary \
R=vShiloni.fasta O=vShiloni.dict \
1>prepRef.log 2>prepRef.err &
