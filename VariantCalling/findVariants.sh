#!/bin/bash
mkdir -p vcf
findVariants() {
for bam in noDup/*.bam
do
vcfOut="${bam/noDup/vcf}"
vcfOut="${vcfOut/bam/vcf}"
# HaplotypeCaller generates an intermediate GVCF file per sample
# This can be used for joint genotyping of multiple samples efficiently
# -R for reference -I for sample1 
# genotyping_mode specifies how to determine alternate alleles for genotyping (DISCOVERY is default)
# stand_call_conf is the minimum phred threshold at which variants should be called
nice -n19 java -jar /usr/local/programs/GenomeAnalysisTK-3.8-0/GenomeAnalysisTK.jar \
-T HaplotypeCaller --emitRefConfidence GVCF -R vShiloni.fasta -I $bam --genotyping_mode DISCOVERY \
-variant_index_type LINEAR -variant_index_parameter 128000 \
-stand_call_conf 30 -nct 16 -o $vcfOut
done
}
findVariants 1>findVariants.log 2>findVariants.err &
