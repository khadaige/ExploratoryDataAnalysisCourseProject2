library(plyr)
library(ggplot2)

## read file
setwd("/Users/khadija/Desktop/ Exploratory Data Analysis/assignment course project2")
NEI <- readRDS("exdata-data-NEI_data/summarySCC_PM25.rds")             #PM2.5 Emissions Data
SCC <- readRDS("exdata-data-NEI_data/Source_Classification_Code.rds")  #Source Classification Code


# Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008? 
# Use the base plotting system to make a plot answering this question.

subsetNEI  <- NEI[NEI$fips=="24510", ]

BaltimoreEmissionByYear <- aggregate(Emissions ~ year, subsetNEI, sum)

png("plot2.png",,width=480,height=480,units="px",bg="transparent")

barplot(
        height=BaltimoreEmissionByYear$Emissions,
        names.arg=BaltimoreEmissionByYear$year,
        xlab="years", ylab=expression(" PM'[2.5]*' emission"),
        main=expression("Total PM'[2.5]*' in the Baltimore City, MD emissions by years")
        )

dev.off()