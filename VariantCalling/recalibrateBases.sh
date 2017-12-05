#!/bin/bash
vcf='filteredSnps.vcf'
baseCommand='java -jar /usr/local/programs/GenomeAnalysisTK-3.8-0/GenomeAnalysisTK.jar'

firstRun='-T BaseRecalibrator -R vShiloni.fasta -I merged.bam -knownSites filteredSnps.vcf -o recal_data.table'

secondRun='-T BaseRecalibrator -R vShiloni.fasta -I merged.bam -knownSites filteredSnps.vcf -BQSR recal_data.table -o post_recal.table'

plotParameters='-T AnalyzeCovariates -R vShiloni.fasta -before recal_data.table -after post_recal_data.table -plots recalibration_plots.pdf'

runAll(){
	nice -n19 $baseCommand $firstRun
	nice -n19 $baseCommand $secondRun 
	nice -n19 $baseCommand $plotParameters
}
runAll \
1>recalibrate.log 2>recalibrate.err &
