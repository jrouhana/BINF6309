#!/bin/bash
# Write header lines for the csv files
echo "PairsOut,Sample" > pairsOut.csv
echo "PairsIn,Sample" > pairsIn.csv
# Set variables for the inPath, outPath, and left read suffix
outPath="Paired/"
inPath="/scratch/AiptasiaMiSeq/fastq/"
leftSuffix=".R1.fastq"

# Grep all lines starting in M0, 
# Pick out first column, sort the output,
# Collapse repeating sample names, use -c option
# to provide a count of the lines collapsed,
# and use sed to replace spaces with commas and remove path and suffix 
grep "\@M0" $outPath*$leftSuffix|\
cut -d':' -f1|\
sort|\
uniq -c|\
sed -e "s|^ *||;s| |,|;s|$outPath||;s|$leftSuffix||" >> pairsOut.csv
grep "\@M0" $inPath*$leftSuffix|\
cut -d':' -f1|\
sort|\
uniq -c|\
sed -e "s|^ *||;s| |,|;s|$inPath||;s|$leftSuffix||" >> pairsIn.csv

