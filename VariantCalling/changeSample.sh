#!/bin/bash
# Correct vcf files so that there is unique identifier
inPath='vcf/'
ext='.vcf'
for vcf in vcf/*.vcf
do
	sample="${vcf/$inPath/}"
	sample="${sample/$ext/}"
	sed -i -e "s/sample1/$sample/g" $vcf
done
