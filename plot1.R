# Exploratory Data Analysis: Assignment 2
## This program will produce a table that will be used to analysis whether total emission from PM25 decrease in US from 1999 to 2008.

library(reshape2)
## STEP 1: Setup working directory and open the data in working folder
setwd("C:\\rproj\\Exploratory_Data_Analysis\\ASSIGN2")
NEI <- readRDS("summarySCC_PM25.rds")
NEI <- readRDS(data,"summarySCC_PM25.rds")

## STEP 3: Generating (aggregate) total emission from all sources for year 1999 tp 2008
totemission <- NEI[,c("Emissions","year")]
totemission = melt(totemission, id = c("year"))
totemission <- dcast(totemission, formula =year ~ variable, sum,na.rm=TRUE)
rm(NEI)

## STEP 4: Ploting total emission by year using base ploting system 
png(file = "plot1.png", width = 480, height = 480)
plot(totemission$year, log(totemission$Emissions), type= "l", main = "Total emission by year", xlab = "Year", ylab  = "Emissions (log)")
dev.off()


