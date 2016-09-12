## QUESTION 6: VARIABLE - plot6.png
# Compare emissions from motor vehicle sources in Baltimore City with emissions 
# from motor vehicle sources in Los Angeles County, California (𝚏𝚒𝚙𝚜 == "𝟶𝟼𝟶𝟹𝟽"). Wh
# ich city has seen greater changes over time in motor vehicle emissions?

library(ggplot2)

setwd("/Users/Mike/Downloads/exdata%2Fdata%2FNEI_data")

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

vehicles <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case=TRUE)
vehiclesSCC <- SCC[vehicles,]$SCC
vehiclesNEI <- NEI[NEI$SCC %in% vehiclesSCC,]
BCvehiclesNEI <- vehiclesNEI[vehiclesNEI$fips==24510,]

BCV <- vehiclesNEI[vehiclesNEI$fips == 24510,]
BCV$city <- "Baltimore City"
LAV <- vehiclesNEI[vehiclesNEI$fips=="06037",]
LAV$city <- "Los Angeles County"
BCVtoLAV <- rbind(BCV,LAV)

# Save plot as png - plot6.png
png(filename = "plot6.png")
boom <- ggplot(BCVtoLAV, aes(x = factor(year), y = Emissions, fill = city)) +
    geom_bar(aes(fill = year), stat = "identity") +
    facet_grid(scales = "free", space = "free", . ~ city) +
    labs(x = "year", y = expression("Total PM2.5 Emission (Kilo-Tons)")) + 
    labs(title = expression("PM2.5 Motor Vehicle Source Emissions in Baltimore & LA, 1999-2008"))

print(boom)

dev.off()
