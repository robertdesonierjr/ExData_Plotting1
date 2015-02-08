# Course Project 1/ plot4.R
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

# Set up for four plots on single page
par(mfrow = c(2,2))


# Make time series plot for Global Active Power vs dateTime
y_data <- as.numeric(as.character(plotData$Global_active_power))
with(plotData, plot(dateTime, y_data,  
                    type = "l", xlab = "", ylab = "Global Active Power"))


# Make time series plot for Voltage vs dateTime
y_data <- as.numeric(as.character(plotData$Voltage))
with(plotData, plot(dateTime, y_data,  
                    type = "l", xlab = "datetime", ylab = "Voltage"))

# Make time series plot for Engergy sub meter vs dateTime
y_data1 <- as.numeric(as.character(plotData$Sub_metering_1))
y_data2 <- as.numeric(as.character(plotData$Sub_metering_2))
y_data3 <- as.numeric(as.character(plotData$Sub_metering_3))

with(plotData, plot(dateTime, y_data1, type = "l", xlab = "", 
        ylab = "Energy sub meter"))   
lines(dateTime, y_data2, col = 2)
lines(dateTime, y_data3, col = 4)

legend("topright", 
       legend = c("Sub_metering_1", 
                  "Sub_metering_2", 
                  "Sub_metering_3"), 
       col = c("black", "red", "blue"), 
       lwd = .75, 
       cex = .75
)

# Make time series plot for Global_reactive_power vs dateTime
y_data <- as.numeric(as.character(plotData$Global_reactive_power))
with(plotData, plot(dateTime, y_data,  
                    type = "l", xlab = "datetime", ylab = "Global_reactive_power"))

# Store plot as png file
dev.copy(png, file = "plot4.png") ## Copy my plot to a PNG file
dev.off() ## Don't forget to close the PNG device!

