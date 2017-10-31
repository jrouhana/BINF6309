#!/bin/bash
# Writes transcript alignment information in .csv format
# Get the xprs path as the first argument
xprsPath=$1
# Set a variable with the xprs output file extension
xprsExt='.err'
# Set a variable with the output filename
outFile='tranAlignStats.csv'
# Set a variable with the search text around the desired data
searchText='overall alignment rate'
# Write a header line in csv format
echo 'Sample,TranAlignPct' > $xprsPath$outFile
# grep the search text and pipe to a while loop to process line-by-line
grep "$searchText" $xprsPath*$xprsExt | while read -r line ;
do
	# Remove search text from the output
	line="${line/$searchText/}"
	# Remove file path from the output
	line="${line/$xprsPath/}"
	# Remove file extension from the output
	line="${line/$xprsExt/}"
	# Replace colon separator with comma
	line="${line/\%/}"
	# Remove %
	line="${line/\%/}"
	# Append output in csv format
	echo $line >> $xprsPath$outFile
done
