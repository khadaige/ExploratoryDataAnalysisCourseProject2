library(plyr)
library(ggplot2)

## read file
setwd("/Users/khadija/Desktop/ Exploratory Data Analysis/assignment course project2")
NEI <- readRDS("exdata-data-NEI_data/summarySCC_PM25.rds")             #PM2.5 Emissions Data
SCC <- readRDS("exdata-data-NEI_data/Source_Classification_Code.rds")  #Source Classification Code

# Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
# which of these four sources have seen decreases in emissions from 1999 2008 for Baltimore City? 
# Which have seen increases in emissions from 1999 2008? 
# Use the ggplot2 plotting system to make a plot answer this question.

# Aggregate using sum the Baltimore emissions data by year

subsetNEI  <- NEI[NEI$fips=="24510", ]
BaltimoreEmission <- aggregate(Emissions ~ year, subsetNEI,sum)

png("plot3.png",width=480,height=480,units="px",bg="transparent")


gp <- ggplot(subsetNEI,aes(factor(year),Emissions,fill=type))+
        geom_bar(stat="identity")+
        theme_bw() + guides(fill=FALSE)+
        facet_grid(.~type,scales = "free",space="free")+ 
        labs(x="year", y=expression("Total Emissions (PM 2.5)"))+ 
        labs(title=expression("PM"[2.5]*" Emissions, Baltimore City 1999-2008 by year and Type"))

print(gp)

dev.off()
