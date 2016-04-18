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


library(ggplot2)
library(grid)
library(reshape2)
allele_freq <- read.csv(file="Step5_Peak1.csv",head=TRUE,sep=",")
allele_freq
p<-qplot(Generation,Allele_Frequency_Change,data=allele_freq,geom="line",group=Rep,col=Rep,main="Peak1_ChrVII")
source("publication_ggplot2_theme.R")
p<-p+publication()
p

library(ggplot2)
library(grid)
library(reshape2)
allele_freq <- read.csv(file="Step5_Peak2.csv",head=TRUE,sep=",")
allele_freq
p<-qplot(Generation,Allele_Frequency_Change,data=allele_freq,geom="line",group=Rep,col=Rep,main="Peak2_ChrIX")
source("publication_ggplot2_theme.R")
p<-p+publication()
p

library(ggplot2)
library(grid)
library(reshape2)
allele_freq <- read.csv(file="Step5_Peak3.csv",head=TRUE,sep=",")
allele_freq
p<-qplot(Generation,Allele_Frequency_Change,data=allele_freq,geom="line",group=Rep,col=Rep,main="Peak3_ChrXI")
source("publication_ggplot2_theme.R")
p<-p+publication()
p

library(ggplot2)
library(grid)
library(reshape2)
allele_freq <- read.csv(file="Step5_Peak4.csv",head=TRUE,sep=",")
allele_freq
p<-qplot(Generation,Allele_Frequency_Change,data=allele_freq,geom="line",group=Rep,col=Rep,main="Peak4_ChrXIII")
source("publication_ggplot2_theme.R")
p<-p+publication()
p

library(ggplot2)
library(grid)
library(reshape2)
allele_freq <- read.csv(file="Step5_Peak5.csv",head=TRUE,sep=",")
allele_freq
p<-qplot(Generation,Allele_Frequency_Change,data=allele_freq,geom="line",group=Rep,col=Rep,main="Peak5_ChrXVI")
source("publication_ggplot2_theme.R")
p<-p+publication()
p


#piechart process
# Define absence/presence vectors with 2 values
absence <- c(3289, 97990)
# Define some colors ideal for black & white print
colors <- c("white","grey")
# Calculate the percentage for each part, rounded to one 
# decimal place
absence_labels <- round(absence/sum(absence) * 100, 1)
# Concatenate a '%' char after each value
absence_labels <- paste(absence_labels, "%", sep="")
# Create a pie chart with defined heading and custom colors and labels
pie(absence, main="Absence/presence of SNPs in Ancestor", col=colors, labels=absence_labels, cex=0.8)
# Create a legend at the right   
legend(1.5, 0.5, c("Absence","Presence"), cex=0.8, fill=colors)
