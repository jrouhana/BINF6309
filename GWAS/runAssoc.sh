#!/usr/bin/bash
plink --bfile famEpilepsy --assoc --chr-set 38 --adjust --out epilepsy.txt
