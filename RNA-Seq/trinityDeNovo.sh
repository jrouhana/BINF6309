#!/bin/bash
# Get list of left reads
leftReads="$(ls -q Paired/*.R1.fastq)"
# Put them in proper list without whitespaces
leftReads=$(echo $leftReads)
# Replace spaces in output with comma for Trinity input
leftReads="${leftReads// /,}"
# Repeat for right side#
rightReads="$(ls -q Paired/*.R2.fastq)"
# Put them in proper list without whitespaces
rightReads=$(echo $rightReads)
# Replace spaces in output with comma for Trinity input
rightReads="${rightReads// /,}"
nice -n19 /usr/local/programs/\
trinityrnaseq-2.2.0/\
Trinity --seqType fq --max_memory 50G --output trinity_de-novo \
--left $leftReads --right $rightReads --CPU 4 \
1>trinity.log 2>trinity.err &
