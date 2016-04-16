# HART-Step-5

###Introduction
######Upon examination of the VCF file for the sequences we have been analyzing, it was found that there were five regions where peaks of change occured throughout the experiment. In the following analyses of the data we will attempt to determine where these SNPs occur, what genes are involved, and why, potentially, these genes underwent mutation during the course of the experiment. We will then determine how the polymorphisms arose by comparing the regions back to the ancestral sequences to see if the mutations were present in any of the ancestor strains.



###Step 1 Description of SNPs
######SNPs were characterized first by whether or not they were found within coding regions, then each SNP was examined to see of that change resulted in a synonymous (no effect on the protein sequence) or non-synonymous (caused a change in the protein sequence) mutation, and finally what gene or genes were involved in the SNPs of any given peak. This data is summarized in Table 1. 



###Step 2 Comparisons of allele frequencies over time
######R was used to compare how the allele frequency of each peak changed over the course of the experiment. Allele frequency was plotted as an average for each peak acrss the four generation time points (ancestor/founder, 6, 12 and 18 generation. 3 intervals, 4 time points). The script to create these graphics is explained below:

Select the working directory for R under Session panel, and invoke ggplot2 package

`library(ggplot2)`

Next, invoke the grid and reshape2 packages
```
library(grid)
library(reshape2)
```
Import csv file and assign it as allele_freq and create plot
```
allele_freq <- read.csv(file="Step5_Peak1.csv",head=TRUE,sep=",")
allele_freq
p<-qplot(Generation,Allele_Frequency_Change,data=allele_freq,geom="line",group=Rep,col=Rep,main="Peak1_ChrVII")
source("publication_ggplot2_theme.R")
p<-p+publication()
```
Detail for "publication_ggplot2_theme.R" 
```
publication <- function(base_size = 12) { 
	require(grid)        
	theme( 
                                        axis.line =         element_line(), 
                                        axis.text.x =       element_text(colour = "black", size = base_size * 1.2, vjust = 1, lineheight = 0.9, face="bold"), 
					axis.text.y =       element_text(colour = "black", size = base_size * 1.2, hjust = 1, lineheight = 0.9, face="bold"), 
                                        axis.ticks =        element_line(colour = "black"), 
                                        axis.title.x =      element_text(size = base_size*1.5, vjust = 0.5), 
                                        axis.title.y =      element_text(size = base_size*1.5, vjust = 0.5, angle = 90), 
                                        axis.ticks.length = unit(0.15, "cm"), 
                                        #depricated
                                        #axis.ticks.margin = unit(0.1, "cm"), 
                                        
                                        legend.background = element_rect(colour="white"), 
                                        legend.key =        element_blank(), 
                                        legend.key.size =   unit(1.2, "lines"), 
                                        legend.text =       element_text(size = base_size * 1.2), 
                                        legend.title =      element_text(face = "bold", size = base_size * 1.2, hjust = 0), 
                                        legend.position =   "right", 
                                        
                                        panel.background =  element_blank(), 
                                        panel.border =      element_rect(fill=NA), 
                                        panel.grid.major =  element_blank(), 
                                        panel.grid.minor =  element_blank(), 
                                        panel.margin =      unit(0.0, "lines"), 
                                        
                                        strip.background =  element_rect(fill = "grey80", colour="black"), 
                                        #strip.label =       function(variable, value) value, 
                                        strip.text.x =      element_text(size = base_size * 1.2, face="bold"), 
                                        strip.text.y =      element_text(size = base_size * 1.2, angle = -90, face="bold"), 
                                        
                                        plot.background =   element_rect(fill = "white", colour = NA), 
                                        plot.title =        element_text(size = base_size * 1.8, face="bold"), 
                                        plot.margin =       unit(c(1, 1, 0.5, 0.5), "lines") 
                        )
}
```
####Plots of Change in Allele Frequency Between Time Points


## piechart for absence/presence of SNP in ancaster

## step1
## source vcftools package
#!/bin/sh/
source /opt/asn/etc/asn-bash-profiles/modules.sh
module load vcftools/0.1.12a
## using option --indv to extract ancestor SNPs from the whole vcf files 
vcftools --vcf Combined.Q30.recode.vcf --indv YEE_0112_00_00_00 --recode --recode-INFO-all --out SNP_ancster
