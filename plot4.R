# Exploratory Data Analysis: Assignment 2
## This program will produce a table that will be used to analysis  
# emissions from coal combustion-related sources changed from 1999–2008 in United State

library(reshape2)
library(ggplot2)
## STEP 1: Setup working directory and open the data in working folder
setwd("C:\\rproj\\Exploratory_Data_Analysis\\ASSIGN2")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## STEP 2: Generate subset data using SCC where emission was from coal combustion-realted
SCC_coal <- subset(SCC, EI.Sector ==c("Fuel Comb - Electric Generation - Coal",
                                      "Fuel Comb - Industrial Boilers, ICEs - Coal",
                                      "Fuel Comb - Comm/Institutional - Coal"))

# merge coal combustion-realted information into NEI data to create subset
NEI_coal <- merge(NEI,SCC_coal, all=F)

## STEP 3: Generating (aggregate) total emission from coal combustion-realted for year 1999 to 2008
NEI_coal <- NEI_coal[,c("Emissions","year")]
coal = melt(NEI_coal, id = c("year"))
coal <- dcast(coal, formula = year ~ variable, sum,na.rm=TRUE)
rm(NEI)

## STEP 4: Ploting total emission by year and "ON-ROAD" type using ggplot ploting system 
png(file = "plot4.png")
    g <- ggplot(coal, aes(year, Emissions))
    g + geom_point()
dev.off()
