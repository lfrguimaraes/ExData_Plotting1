# Set language to English
Sys.setlocale("LC_ALL", "en_GB.UTF-8")

# File URL
url<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

# Check and create directory
if(!file.exists("./data")) dir.create("./data")

# Check and download zip
if(!file.exists("./data/household_power_consumption.zip")) download.file(url, destfile="./data/household_power_consumption.zip", method="curl")

# Check and unzip file
if(!file.exists("./data/household_power_consumption.txt")) unzip(zipfile="./data/household_power_consumption.zip", exdir="./data")

# Tidy data
powerData <- read.table("./data/household_power_consumption.txt", header=TRUE, sep=";", na.strings="?")
powerData$Time <- paste(powerData$Date, powerData$Time)
powerData$Time <- strptime(powerData$Time, "%d/%m/%Y %H:%M:%S")
powerData$Date <- as.Date(powerData$Date, format = "%d/%m/%Y")

startDate <- "01/02/2007"
endDate <- "02/02/2007"

powerData <- powerData[ which(powerData$Date>=as.Date(startDate, format = "%d/%m/%Y") & powerData$Date<=as.Date(endDate, format = "%d/%m/%Y") ),]

# Plot 1

## Create histogram
par(mfrow = c(1, 1))
hist(powerData$Global_active_power, col = "red", breaks=16, main="Global Active Power", xlab = "Global Active Power (kilowatts)" )

## Copy into PNG
dev.copy(png, file = "plot1.png", width = 480, height = 480, units = "px") 
dev.off()
