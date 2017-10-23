#!/bin/bash
# TransDecoder
nice -n19 /usr/local/programs/TransDecoder-5.0.1/\
TransDecoder.LongOrfs -t Trinity-GG.fasta
nice -n19 /usr/local/programs/TransDecoder-5.0.1/\
TransDecoder.Predict -t Trinity-GG.fasta
sed -i 's/\*//g' Trinity-GG.fasta.transdecoder.pep
