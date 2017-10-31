# Just a file to make sure all these packages are installed for DESeq2
# Pretty sure already have them all
# I usually don't run installations in quiet for troubleshooting purposes

Sys.setenv(TZ="US/Eastern") # Prevents error for some reason

# Supports RMarkDown
install.packages("knitr")
# More color options for graph
install.packages("RColorBrewer")
# Allows installation of packages from github
install.packages("devtools")
# Heat maps
install.packages("pheatmap")

source("http://bioconductor.org/biocLite.R")
# Uodate bioconductor packages
# Actually had to run this in sudo -R
biocLite(ask=FALSE)

biocLite("DESeq2",ask=FALSE,suppressUpdates = T)

# for Venn diagrams
biocLite("limma",ask=F,suppressUpdates = T)