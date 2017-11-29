#!/bin/bash
pairedOutPath='Paired/'
unpairedOutPath='Unpaired/'
mkdir -p $pairedOutPath
mkdir -p $unpairedOutPath
trimAll(){
for leftInFile in *_1.fastq.gz
	do
		rightInFile="${leftInFile/_1/_2}"
		# Get file name sans suffix
		leftSans=$(echo $leftInFile |cut -d'.' -f1)
		rightSans=$(echo $rightInFile |cut -d'.' -f1)
		nice -n19 java -jar /usr/local/programs/Trimmomatic-0.36/trimmomatic-0.36.jar PE \
		-threads 4 -phred33 \
		$leftInFile \
		$rightInFile \
		Paired/$leftSans.paired.fastq \
		Unpaired/$leftSans.unpaired.fastq \
		Paired/$rightSans.paired.fastq \
		Unpaired/$rightSans.unpaired.fastq \
		HEADCROP:0 \
		ILLUMINACLIP:/usr/local/programs/Trimmomatic-0.36/adapters/NexteraPE-PE.fa:2:30:10 \
		LEADING:20 TRAILING:20 SLIDINGWINDOW:4:30 MINLEN:36
	done
}
trimAll 1>trimAll.log 2>trimAll.err &
