library(plyr)
library(ggplot2)

## read file
setwd("/Users/khadija/Desktop/ Exploratory Data Analysis/assignment course project2")
NEI <- readRDS("exdata-data-NEI_data/summarySCC_PM25.rds")             #PM2.5 Emissions Data
#head(NEI)
SCC <- readRDS("exdata-data-NEI_data/Source_Classification_Code.rds")  #Source Classification Code
#head(SCC)

# Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
# Using the base plotting system, make a plot showing the total PM2.5 emission from all sources 
# for each of the years 1999, 2002, 2005, and 2008.

TotEmission <- aggregate(Emissions ~ year,NEI, sum)

png("plot1.png",width=480,height=480,units="px",bg="transparent")

barplot(
        (TotEmission$Emissions)/10^6,
        names.arg=aggTotals$year,
        xlab="Year",
        ylab="PM2.5 Emissions",
        main="Total PM2.5 Emissions from all Sources by year"
)

dev.off()
