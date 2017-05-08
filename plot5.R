library(plyr)
library(ggplot2)
## This first line will likely take a few seconds. Be patient!
## read file
setwd("/Users/khadija/Desktop/ Exploratory Data Analysis/assignment course project2")
NEI <- readRDS("exdata-data-NEI_data/summarySCC_PM25.rds")             #PM2.5 Emissions Data
#head(NEI)
SCC <- readRDS("exdata-data-NEI_data/Source_Classification_Code.rds")  #Source Classification Code
#head(SCC)
#merge NEI and SCC
NEISCC <- merge(NEI, SCC, by="SCC")

#How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?
# Searching for ON-ROAD type in NEI and  in SCC 

subsetNEISCC <- NEISCC[NEISCC$fips=="24510" & NEISCC$type=="ON-ROAD",  ]

TotalEmissionByYear <- aggregate(Emissions ~ year, subsetNEISCC, sum)

png("plot5.png", width=840, height=480, units="px",bg="transparent")

gp <- ggplot(TotalEmissionByYear, aes(factor(year), Emissions))

gp <- gp + geom_bar(stat="identity") +
        xlab("year") +
        ylab(expression('Total PM'[2.5]*" Emissions")) +
        ggtitle('Total Emissions from motor vehicle (type = ON-ROAD) from 1999 to 2008 in Baltimore City (Maryland (fips = "24510") ')

print(gp)

dev.off()

