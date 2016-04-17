# HART-Step-5

###__Introduction__
######Upon examination of the VCF file for the sequences we have been analyzing, it was found that there were five regions where peaks of change occured throughout the experiment. In the following analyses of the data we will attempt to determine where these SNPs occur, what genes are involved, and why, potentially, these genes underwent mutation during the course of the experiment. We will then determine how the polymorphisms arose by comparing the regions back to the ancestral sequences to see if the mutations were present in any of the ancestor strains.



###__Step 1 Description of SNPs__
######SNPs were characterized first by whether or not they were found within coding regions, then each SNP was examined to see of that change resulted in a synonymous (no effect on the protein sequence) or non-synonymous (caused a change in the protein sequence) mutation, and finally what gene or genes were involved in the SNPs of any given peak. This data is summarized in Table 1. 



###__Step 2 Comparisons of allele frequencies over time__
######R was used to compare how the allele frequency of each peak changed over the course of the experiment. Allele frequency was plotted as an average for each peak acrss the four generation time points (ancestor/founder, 6, 12 and 18 generation. 3 intervals, 4 time points). We then determined what proportion of SNPs found in the resequenced populations was present in the ancestor. The script to create these graphics is explained below:

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

![alt text](https://cloud.githubusercontent.com/assets/17581319/14583577/dbcd689e-03eb-11e6-93f8-d30933b490bd.png)
![alt text](https://cloud.githubusercontent.com/assets/17581319/14583596/7510feda-03ec-11e6-8da7-278555dcc0d4.png)
![alt text](https://cloud.githubusercontent.com/assets/17581319/14583597/87835afe-03ec-11e6-80e0-c226847b3535.png)
![alt text](https://cloud.githubusercontent.com/assets/17581319/14583600/99dec7d8-03ec-11e6-85b4-59ae61a5ca9e.png)
![alt text](https://cloud.githubusercontent.com/assets/17581319/14583602/aa17735c-03ec-11e6-9da0-7ce8073dd945.png)

####Brief Conclusion
From the five images presenting 5 SNP peaks, we can see there are a great differnces in variation of allele frequency between three time points/generations. 


###Piechart for absence/presence of SNP in ancester
Source vcftools package and extract ancestor SNPs from vcf files
```
\#!/bin/sh/
source /opt/asn/etc/asn-bash-profiles/modules.sh
module load vcftools/0.1.12a
vcftools --vcf Combined.Q30.recode.vcf --indv YEE_0112_00_00_00 --recode --recode-INFO-all --out SNP_ancster
```
Use awk command to assign all the genotype of ancestor to file “genotype_ancestor” without listing header in it and count SNPs that are homozygous to the reference (absence value)
```
awk '$0!~/^#/ {print $10}' SNP_ancster.recode.vcf | awk -F: '{print $1}'>genotype_ancestor
grep -o "0/0" genotype_ancester | wc -l
```
Create piechart by first defining absence/presence vectors with 2 values, define colors and calculate rounded percentages for each portions. 
```
absence <- c(3289, 97990)
colors <- c("white","grey")
absence_labels <- round(absence/sum(absence) * 100, 1)
```
Concatenate a '%' char after each value, add headings and labels, and create legend
```
absence_labels <- paste(absence_labels, "%", sep="")
pie(absence, main="Absence/presence of SNPs in Ancestor", col=colors, labels=absence_labels, cex=0.8)
legend(1.5, 0.5, c("Absence","Presence"), cex=0.8, fill=colors)
```
![alt text](https://cloud.githubusercontent.com/assets/17581319/14583604/c6073188-03ec-11e6-86ca-775623ba898f.png)

#### Brief Conclusion
From piechart above, we see most SNPs in ancestor are differnt from reference genome, and only 3.2% of these SNPs are homozygous to reference. This indicates that most of the polymorphisms in ancestor arose de novo throughout the experiment.

### Comparing SNPs in ancestor vs. founder
Peak1 (3 SNPs: chrVII965303, chrVII967405, and chrVII967437)  
Peak1_chrVII_965303  
![peak1_snpchrvii_965303](https://cloud.githubusercontent.com/assets/17581280/14590614/f98fcf00-04c4-11e6-8840-a88b4048f988.png)  
Peak1_chrVII_967405&967437  
![peak1_snpchrvii_967405 967437](https://cloud.githubusercontent.com/assets/17581280/14590707/c72db124-04c6-11e6-8d13-ee14ca749e01.png)  
##### Peak1 Conclusion
The genotype of samples from 5 replicates (at 3 timepoint) are mostly consistent with genotypes in ancestor, potentially indicating that three SNPs in peak1 are very likely to evolve de novo during the experiment.  	
