## create the Course4Assignment1 directory if it is not present in the working directory
if(!file.exists("Course4Assignment1")) {
    dir.create("Course4Assignment1")
}

## change working directory to Course4Assignment1
setwd("./Course4Assignment1")

## get the zip file if we don't already have it and note the date
if(!file.exists("household_power_consumption.txt")) {
    temp <- tempfile()
    fileURL <- "http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    download.file(fileURL, temp)
    dataFile <- unzip(temp)
    unlink(temp)
    dateDownloaded <- date()
    save(dateDownloaded, file = "./Course4Assignment1/dateDownloaded.txt")
} else {
    dataFile <- "household_power_consumption.txt"
}

## dataFile is household_power_consumption.txt
df <- read.table(dataFile, sep = ";", header = TRUE, stringsAsFactors = FALSE)

#str(df)
# 'data.frame':	2075259 obs. of  9 variables:

## converting the Date variable to the Date class
df$Date <- as.Date(df$Date, format="%d/%m/%Y")

## now subset to get the data we need
pwrDF <- df[(df$Date == "2007-02-01") | (df$Date == "2007-02-02"),]

## remove the original data frame to free up memory
rm(df)

#str(pwrDF)
# 'data.frame':	2880 obs. of  9 variables:

## creating a DateTime object and appending to pwrDF
dateTime <- paste(as.Date(pwrDF$Date), pwrDF$Time)
pwrDF$Datetime <- as.POSIXct(dateTime)

## create plot3.png
png("plot3.png", width = 480, height = 480)
plot(pwrDF$Datetime, pwrDF$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
lines(pwrDF$Datetime, pwrDF$Sub_metering_2, col = "red")
lines(pwrDF$Datetime, pwrDF$Sub_metering_3, col = "blue")
legend("topright", col = c("black","red","blue"), legend = c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"), lty = 1, lwd = 2)
dev.off()
