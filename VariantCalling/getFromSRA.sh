#!/bin/bash
# Set a variable with the file containing SRA accessions
filename="SRR_Acc_List.txt"
# Create a function to read the file line-by-line
getAll() {
	while read -r line
	do 
		# Get the FASTQ
		fastq-dump $line --split-3 --gzip
	done < "$filename"
}
# Call the function in the background
getAll 1>get.log 2>get.err &
