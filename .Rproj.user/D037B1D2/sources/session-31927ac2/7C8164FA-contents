library(QDNAseq)
library(ACE)
library(Biobase)
library(dplyr)
library(ggplot2)

load("/Users/mahedi/Desktop/test/latest_500kb_run_30Nov21/by_patient/CA43__500000.RData")


objectsampletotemplate(oQM$SegmentsCalls, 
                       index = which(sampleNames(oQM$SegmentsCalls) == "CA43_434")) %>% 
  filter(chr=="X") %>% 
  ggplot(.) + 
  geom_point(aes((start+end)/2, copynumbers)) + 
  geom_point(aes((start+end)/2, segments), colour = "darkorange") + 
  annotate("rect", xmin = 66763874, xmax = 66950461, ymin = -Inf, ymax = Inf) +
  ggtitle("CA43_434") + 
  xlab("Chromosome X") +
  ylab("Copies") +
  theme_classic()




objectsampletotemplate(oQM$SegmentsCalls, 
                       index = which(sampleNames(oQM$SegmentsCalls) == "CA43_433")) %>% 
  filter(chr=="X") %>% 
  ggplot(.) + 
  geom_point(aes((start+end)/2, copynumbers)) + 
  geom_point(aes((start+end)/2, segments), colour = "darkorange") + 
  annotate("rect", xmin = 66763874, xmax = 66950461, ymin = -Inf, ymax = Inf) +
  ggtitle("CA43_433") + 
  xlab("Chromosome X") +
  ylab("Copies") +
  theme_classic()
