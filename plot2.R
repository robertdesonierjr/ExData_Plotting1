# Course Project 1/ plot2.R
# Set working directory and open libraries needed
setwd("~/Coursera/04_Exploratory Data Analysis/project_01")

# Record timestamp for down load
dateDownloaded <- date()

# Download zipped data to working directory and unzip
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile = "DatasetZip")
unzip("DatasetZip")

# Convert the raw data files into data table and extract data for plot
testData <- read.table("household_power_consumption.txt", header = TRUE, sep = ";")

library(dplyr)

testData_tbl <- tbl_df(testData)
plotData <- filter(testData_tbl, Date == "1/2/2007" | Date == "2/2/2007")

# Create new time / date column for time series plot
dateTime <- as.POSIXct(paste(plotData$Date,plotData$Time), 
                       format="%d/%m/%Y %H:%M:%S")

# Make time series plot
y_data <- as.numeric(as.character(plotData$Global_active_power))
with(plotData, plot(dateTime, y_data,  
     type = "l", xlab = "", ylab = "Global Active Power (kilowatts)"))
     
# Store time series plot as png file
dev.copy(png, file = "plot2.png") ## Copy my plot to a PNG file
dev.off() ## Don't forget to close the PNG device!

