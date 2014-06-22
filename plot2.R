# Exploratory Data Analysis: Assignment 2
## This program will produce a table that will be used to analysis whether total emission from PM25 decrease 
# in Baltimore City from 1999 to 2008.

library(reshape2)
## STEP 1: Setup working directory and open the data in working folder
setwd("C:\\rproj\\Exploratory_Data_Analysis\\ASSIGN2")
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(fileUrl, destfile="data.zip")
NEI <- readRDS("summarySCC_PM25.rds")

## STEP 2: Generate subset data for only Balimore City
Baltimore <- subset(NEI, fips == "24510")
Baltimore <- Baltimore[,c("Emissions","year")]

## STEP 3: Generating (aggregate) total emission from all sources for year 1999 to 2008 for Baltimore City
Baltimore = melt(Baltimore, id = c("year"))
Baltimore <- dcast(Baltimore, formula =year ~ variable, sum,na.rm=TRUE)
rm(NEI)

## STEP 4: Ploting total emission by year using base ploting system 
png(file = "plot2.png", width = 480, height = 480)
plot(Baltimore$year, log(Baltimore$Emissions), type= "l", main = "Baltimore City: Total Emission by Year", 
     xlab = "Year", ylab  = "Emissions (log)")
dev.off()
