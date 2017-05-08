library(plyr)
library(ggplot2)
## This first line will likely take a few seconds. Be patient!
## read file
setwd("/Users/khadija/Desktop/ Exploratory Data Analysis/assignment course project2")
NEI <- readRDS("exdata-data-NEI_data/summarySCC_PM25.rds")             #PM2.5 Emissions Data
#head(NEI)
SCC <- readRDS("exdata-data-NEI_data/Source_Classification_Code.rds")  #Source Classification Code
#head(SCC)

# Compare emissions from motor vehicle sources in Baltimore City with emissions from motor 
# vehicle sources in Los Angeles County, California (fips == "06037"). 
# Which city has seen greater changes over time in motor vehicle emissions?

subsetNEIBaltimore  <- NEI[NEI$fips=="24510" & NEI$type=="ON-ROAD", ]
BaltimoreEmissionByYear <- aggregate(Emissions ~ year + fips, subsetNEIBaltimore, sum)
BaltimoreEmissionByYear$city <- "Baltimore City"

subsetNEILosAngelos  <- NEI[NEI$fips=="06037" & NEI$type=="ON-ROAD", ]
LosAngelosEmissionByYear <- aggregate(Emissions ~ year + fips, subsetNEILosAngelos, sum)
LosAngelosEmissionByYear$city <- "Los Angeles County"

bothBaltimoreLosAngelosEmission <- rbind(BaltimoreEmissionByYear,LosAngelosEmissionByYear)
#aggregatedTotalByYearAndFips <- aggregate(Emissions ~ year + fips, subsetNEI, sum)
#aggregatedTotalByYearAndFips$fips[aggregatedTotalByYearAndFips$fips=="24510"] <- "Baltimore, MD"
#aggregatedTotalByYearAndFips$fips[aggregatedTotalByYearAndFips$fips=="06037"] <- "Los Angeles, CA"

png("plot6.png", width=1040, height=480,units="px",bg="transparent")

gp <- ggplot(bothBaltimoreLosAngelosEmission, aes(factor(year), Emissions))
gp <- gp + facet_grid(. ~ fips)
gp <- gp + geom_bar(stat="identity")  +
        xlab("year") +
        ylab(expression("Total Emissions (PM[2.5])")) +
        ggtitle('Total Emissions from motor vehicle (type=ON-ROAD) in Baltimore City, MD (fips = "24510") vs Los Angeles, CA (fips = "06037")')print(gp)

dev.off()
