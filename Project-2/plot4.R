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
    labs(title = expression("PM2.5 Coal Combustion Emissions from 1999-2008 Across US"))
  
print(mplot) 
dev.off()
