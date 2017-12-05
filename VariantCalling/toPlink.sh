#!/bin/bash
# This script is to convery our vcf file to the Plink file format
baseCommand='/usr/local/programs/vcftools_0.1.12b/bin/vcftools'
$baseCommand --vcf filteredSnps.vcf --plink
