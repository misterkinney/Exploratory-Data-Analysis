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
    labs(title = expression("PM2.5 Emissions, Baltimore City 1999-2008 by Source Type"))
print(variplot)

dev.off()
