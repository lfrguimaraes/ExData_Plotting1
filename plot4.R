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

# Plot 4

## Create graphics device with 2 rows and 2 columns
par(mfrow = c(2, 2))

## Plot 4.1
with(powerData, plot(powerData$Time, powerData$Global_active_power, type = "S", ylab = "Global Active Power (kilowatts)", xlab = NA))

## Plot 4.2
with(powerData, plot(powerData$Time, powerData$Voltage, type = "S", ylab = "Voltage", xlab = "datetime"))

## Plot 4.3
with(powerData, plot(powerData$Time, powerData$Sub_metering_1, type = "S", ylab = "Energy sub metering", xlab = NA))
lines(powerData$Time, powerData$Sub_metering_2, type = "S", col = "red")
lines(powerData$Time, powerData$Sub_metering_3, type = "S", col = "blue")
legend("topright", col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"), lty = 1, cex=0.50)


## Plot 4.4
with(powerData, plot(powerData$Time, powerData$Global_reactive_power, type = "S", ylab = "Global_reactive_power", xlab = "datetime"))

## Copy into PNG
dev.copy(png, file = "plot4.png", width = 480, height = 480, units = "px") 
dev.off()





