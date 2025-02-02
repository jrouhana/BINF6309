#!/bin/bash
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
	nice -n 19 java -jar /usr/local/programs/Trimmomatic-0.36/trimmomatic-0.36.jar PE \
	-threads 1 -phred33 \
	$fastqPath$f3.R1.fastq \
	$fastqPath$f3.R2.fastq \
	trimAll/$f3.R1.paired.fastq \
	trimAll/$f3.R1.unpaired.fastq \
	trimAll/$f3.R2.paired.fastq \
	trimAll/$f3.R2.unpaired.fastq \
	HEADCROP:0 \
	ILLUMINACLIP:/usr/local/programs/Trimmomatic-0.36/adapters/TruSeq3-PE.fa:2:30:10 \
	LEADING:20 TRAILING:20 SLIDINGWINDOW:4:30 MINLEN:36 
done

