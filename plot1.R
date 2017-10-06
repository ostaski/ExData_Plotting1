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

## casting pwrDF$Global_active_power to numeric
pwrDF$Global_active_power <- as.numeric(as.character(pwrDF$Global_active_power))

## create plot1.png
png("plot1.png", width = 480, height = 480)
hist(pwrDF$Global_active_power, main = "Global Active Power", xlab = "Global Active Power (kilowatts)", ylab = "Frequency", col = "red")
dev.off()
