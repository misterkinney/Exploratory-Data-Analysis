## QUESTION 5: ORANGE - plot5.png
# How have emissions from motor vehicle sources changed from 
# 1999–2008 in Baltimore City?

library(ggplot2)

setwd("/Users/Mike/Downloads/exdata%2Fdata%2FNEI_data")

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

vehicles <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case=TRUE)
vehiclesSCC <- SCC[vehicles,]$SCC
vehiclesNEI <- NEI[NEI$SCC %in% vehiclesSCC,]

BCvehiclesNEI <- vehiclesNEI[vehiclesNEI$fips==24510,]

#Save as png - ORANGE
png(filename = "plot5.png")
emBC <- ggplot(BCvehiclesNEI, aes(factor(year),Emissions)) +
    geom_bar(stat = "identity", fill = "orange",width=0.75) +
    labs(x = "year", y = expression("Total PM2.5 Emission (10^5 Tons)")) + 
    labs(title = expression("PM2.5 Motor Vehicle Source Emissions in Baltimore (1999,2002,2005,2008"))

print(emBC)
dev.off()
