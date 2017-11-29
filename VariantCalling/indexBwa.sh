#!/bin/bash
# index option Indexes sequences in the fasta format

nice -n19 bwa index -p vShiloni -a is vShiloni.fasta \
1>bwaIndex.log 2>bwaIndex.err &
