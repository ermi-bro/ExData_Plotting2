# Exploratory Data Analysis: Assignment 2
## This program will produce a table that will be used to analysis  
# emissions from motor vehicle sources changed from 1999–2008 in Baltimore City

library(reshape2)
library(ggplot2)
## STEP 1: Setup working directory and open the data in working folder
setwd("C:\\rproj\\Exploratory_Data_Analysis\\ASSIGN2")
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(fileUrl, destfile="data.zip")
NEI <- readRDS("summarySCC_PM25.rds")

## STEP 2: Generate subset data for only Balimore City by "ON-RAOD" type of emission sources
Baltimore <- subset(NEI, fips == "24510" & type == "ON-ROAD")
Baltimore <- Baltimore[,c("Emissions","year")]

## STEP 3: Generating (aggregate) total emission from all sources for year 1999 to 2008 for Baltimore City
Baltimore = melt(Baltimore, id = c("year"))
Baltimore <- dcast(Baltimore, formula = year ~ variable, sum,na.rm=TRUE)
rm(NEI)

## STEP 4: Ploting total emission by year and "ON-ROAD" type using ggplot ploting system 
png(file = "plot5.png")
    g <- ggplot(Baltimore, aes(year, Emissions))
    g + geom_point() + 
    labs(x = "Year",
         y = "Emission",
         title = "Baltimore City: Total Emission from Motor Vehicle by Year")
dev.off()