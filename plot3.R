# Exploratory Data Analysis: Assignment 2
## This program will produce a table that will be used to analysis whether total emission from PM25 decrease 
# in Baltimore City from 1999 to 2008 by emission sources.

library(reshape2)
library(ggplot2)
## STEP 1: Setup working directory and open the data in working folder
setwd("C:\\rproj\\Exploratory_Data_Analysis\\ASSIGN2")
NEI <- readRDS("summarySCC_PM25.rds")

## STEP 2: Generate subset data for only Balimore City by type of emission sources
Baltimore <- subset(NEI, fips == "24510")
Baltimore <- Baltimore[,c("Emissions","type","year")]

## STEP 3: Generating (aggregate) total emission from all sources for year 1999 to 2008 for Baltimore City
Baltimore = melt(Baltimore, id = c("year", "type"))
Baltimore <- dcast(Baltimore, formula = year + type ~ variable, sum,na.rm=TRUE)
rm(NEI)

## STEP 4: Ploting total emission by year and Type using ggplot ploting system 
png(file = "plot3.png")
    g <- ggplot(Baltimore, aes(year, Emissions))
    g + geom_point() + facet_grid(. ~ type)  
    + labs(title = "Baltimore City: Total emission (logPM2.5) by Year") 
    + labs(x = "Year", y = "Emission (logPM2.5)")
dev.off()