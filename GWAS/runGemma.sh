#!/bin/bash
runAll(){
#standardized relatedness matrix. -gk 2 for standardized
nice -n19 gemma -bfile famEpilepsy -gk 2 -o epilepsy.matrix

# Eigen Decomposition of the relatedness matrix
nice -n19 gemma -bfile famEpilepsy -k output/epilepsy.matrix.sXX.txt -eigen -o epilepsy.decomp

# association tests Univariate linear mixed models and wald test
gemma -bfile famEpilepsy -d output/epilepsy.decomp.eigenD.txt -u output/epilepsy.decomp.eigenU.txt -lmm 1 -o epilepsy.assoc
}

runAll \
1>gemma.log 2>gemma.err &
