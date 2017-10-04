#!/bin/bash

outputPath="indexAll/"
inputPath="sortAll/"
# Use same naming convention as trimAll
fastqPath="/scratch/AiptasiaMiSeq/fastq/"
for f1 in $fastqPath*.R1.fastq
do
        # Get file name sans suffix
        f2=$(echo $f1 |cut -d'.' -f1)
        # Count number of / to get file name without path
        num0cc=$(tr -dc '/' <<<"$f2" | awk '{ print length; }')
        ((num0cc ++))
        # f3 = file name without path
        f3=$(echo $f2 |cut -d'/' -f$num0cc)
	samtools index $inputPath$f3.sorted.bam \
	1>index.log 2>index.err
done
