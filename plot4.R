library(plyr)
library(ggplot2)

## read file
setwd("/Users/khadija/Desktop/ Exploratory Data Analysis/assignment course project2")
NEI <- readRDS("exdata-data-NEI_data/summarySCC_PM25.rds")             #PM2.5 Emissions Data
#head(NEI)
SCC <- readRDS("exdata-data-NEI_data/Source_Classification_Code.rds")  #Source Classification Code
#head(SCC)
#merge NEI and SCC
NEISCC <- merge(NEI, SCC, by="SCC")

# Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?

png("plot1.png",width=480,height=480,units="px",bg="transparent")

coalMatches  <- grepl("coal", NEISCC$Short.Name, ignore.case=TRUE)
subsetNEISCC <- NEISCC[coalMatches, ]

TotalEmissionByYear <- aggregate(Emissions ~ year, subsetNEISCC, sum)

png("plot4.png", width=640, height=480)

gp <- ggplot(TotalEmissionByYear, aes(factor(year), Emissions))
gp <- gp + geom_bar(stat="identity") +
        xlab("year") +
        ylab(expression("Total Emissions (PM[2.5])")) +
        ggtitle('Total Emissions from coal sources from 1999 to 2008')

print(gp)

dev.off()

