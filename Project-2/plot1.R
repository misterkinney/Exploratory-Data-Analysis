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
