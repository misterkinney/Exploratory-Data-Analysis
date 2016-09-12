## QUESTION 1: GREEN plot - plot1.png
# Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
# Using the base plotting system, make a plot showing the total PM2.5 emission from 
# all sources for each of the years 1999, 2002, 2005, and 2008.

# Load from download -  local machine
setwd("/Users/Mike/Downloads/exdata%2Fdata%2FNEI_data")

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

aggYears <- aggregate(Emissions ~ year, NEI, sum)

#Make the plot -> save as png - green
png(filename = "plot1.png")

barplot(aggYears$Emissions/10^5, 
        names.arg = aggYears$year, 
        xlab = "Year", 
        ylab = "PM2.5 in Kilotons (Scale:10^5)", 
        main = "Total PM2.5 Emissions for (1999,2002,2005,2008)",
        col = "green"
)

dev.off()

## Question 2: RED plot - plot2.png
# Have total emissions from PM2.5 decreased in the Baltimore City, Maryland 
# (𝚏𝚒𝚙𝚜 == "𝟸𝟺𝟻𝟷𝟶") from 1999 to 2008? Use the base plotting system to make a plot answering this question.

# Load from download -  local machine
setwd("/Users/Mike/Downloads/exdata%2Fdata%2FNEI_data")

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

baltimore <- NEI[NEI$fips == "24510", ]
aggYearsBaltimore <- aggregate(Emissions ~ year, baltimore, sum)

# Save plot as png - red
png(filename = "plot2.png")
barplot(aggYearsBaltimore$Emissions, 
        names.arg = aggYearsBaltimore$year,
        xlab = "Year",
        ylab = "PM2.5 Emissions (tons)",
        main = "Total Emissions in Baltimore (1999,2002,2005,2008)",
        col = "red"
        )
dev.off()

## QUESTION 3: VARIABLE color plot3.png
# Of the four types of sources indicated by the 𝚝𝚢𝚙𝚎 (point, nonpoint, onroad, nonr
# oad) variable, which of these four sources have seen decreases in emissions from 
# 1999–2008 for Baltimore City? Which have seen increases in emissions from 
# 1999–2008? Use the ggplot2 plotting system to make a plot answer this question.

library(ggplot2)

setwd("/Users/Mike/Downloads/exdata%2Fdata%2FNEI_data")

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

BC <- subset(NEI, fips == 24510)
BC$year <- factor(BC$year, levels = c("1999","2002","2005","2008"))

# Save plot as png - VARIABLE color plot3.png 
png(filename = "plot3.png")

variplot <- ggplot(BC, aes(factor(year),Emissions,fill = type)) +
    geom_bar(stat = "identity") +
    guides(fill = FALSE)+
    facet_grid(. ~ type, scales = "free", space = "free") + 
    labs(x="year", y=expression("Total PM2.5 Emissions (tons)")) + 
    labs(title = expression("PM2.5 Emissions, Baltimore City by Source Type (1999,2002,2005,2008)"))
print(variplot)

dev.off()


## QUESTION 4: GREY - plot4.png
# Across the United States, how have emissions 
# from coal combustion-related sources changed from 1999–2008?

library(ggplot2)

setwd("/Users/Mike/Downloads/exdata%2Fdata%2FNEI_data")

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

SCC.coal = SCC[grepl("coal", SCC$Short.Name, ignore.case=TRUE),]

merge <- merge(NEI, SCC.coal, by='SCC')
merge.sum <- aggregate(merge[, 'Emissions'], by=list(merge$year), sum)
colnames(merge.sum) <- c('Year', 'Emissions')

# Save to png - plot4.png - GREY
png(filename = "plot4.png")

mplot <- ggplot(merge.sum, aes(x = Year, y = Emissions/10^5)) + 
    geom_bar(stat = "identity", fill = "grey", width = 0.75) +
    labs(x = "year", y = expression("Total PM2.5 Emission (10^5 Tons)")) + 
    labs(title = expression("PM2.5 Coal Emissions Across US (1999,2002,2005,2008)"))
  
print(mplot) 
dev.off()

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
    labs(title = expression("PM2.5 Motor Vehicle Emissions in Baltimore & LA, (1999,2002,2005,2008)"))

print(boom)

dev.off()
