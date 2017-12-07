rm(list=ls())
epi <- read.table("epilepsy.txt.assoc.adjusted", header = T)
epi2 <- epi[which(epi[,"BONF"]<0.05),]
write.csv(epi2,"bonf_adjusted.csv")

#test<-read.csv("bonf_adjusted.csv")
