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
