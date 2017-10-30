#!/bin/bash
# Create variables to store the sam directory and suffix
samDir="sam/"
samSuffix=".sam"
# Write the column headers to the .csv file
echo -e "Sample,Total,Aligned,Concordant" > alignmentStats.csv
# Loop through sam files
for samFile in $samDir*$samSuffix
do
	# Count total number of reads in the alignment
	total="$(samtools view -c $samFile)"
	# Count the aligned reads in the alignment
	mapped="$(samtools view -F4 -c $samFile)"
	# Count the reads that aligned in concordant pairs
	paired="$(samtools view -f2 -c $samFile)"
	# Remove the directory from the sample name
	sample="${samFile/$samDir/}"
	# Remove the suffix from the sample name
	sample="${sample/$samSuffix/}"
	# Write the variables in csv format
	echo -e "$sample,$total,$mapped,$paired" >> alignmentStats.csv
done
