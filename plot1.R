# Exploratory Data Analysis: Assignment 2
## This program will produce a table that will be used to analysis whether total emission from PM25 
# decrease in US from 1999 to 2008.

library(reshape2)
## STEP 1: Setup working directory and open the data in working folder
setwd("C:\\rproj\\Exploratory_Data_Analysis\\ASSIGN2")
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(fileUrl, destfile="data.zip")
data <- unzip("data.zip")

NEI <- readRDS("summarySCC_PM25.rds")

## STEP 2: Generating (aggregate) total emission from all sources for year 1999 to 2008
totemission <- NEI[,c("Emissions","year")]
totemission = melt(totemission, id = c("year"))
totemission <- dcast(totemission, formula =year ~ variable, sum,na.rm=TRUE)
rm(NEI)

## STEP 3: Ploting total emission by year using base ploting system 
png(file = "plot1.png")
plot(totemission$year, log(totemission$Emissions), type= "l", 
     main = "United States: Total emission (logPM2.5) by year", xlab = "Year", ylab  = "Emissions (log PM2.5)")
dev.off()