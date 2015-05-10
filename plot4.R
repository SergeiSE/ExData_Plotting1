# download date from the internet and unzip it into a text file
download.file(url="https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile="data.zip")
unzip("data.zip")

# read the whole table from the text file
PowerData <- read.table(file="household_power_consumption.txt", sep=";", header=TRUE, na.strings="?", stringsAsFactors=FALSE)

# create a subset of the data from the time period we are interested in
CleanData <- subset (PowerData, subset= PowerData$Date %in% c("1/2/2007", "2/2/2007"))

# glue date and time columns together and reformat the joined field
CleanData$DateTime <- paste(CleanData$Date, CleanData$Time) 
CleanData$DateTime <- strptime(CleanData$DateTime, format = "%d/%m/%Y %H:%M:%S")

# draw the actual plot and save it as a PNG file
png(filename="plot4.png", width=480, height=480, type="cairo")

par(mfcol = c(2,2))

plot(CleanData$DateTime, CleanData$Global_active_power, type="l", xlab="", ylab="Global Active Power")

plot(CleanData$DateTime, CleanData$Sub_metering_1, type="l", col="black", xlab="", ylab="Energy sub metering", ylim=ylimit)
lines(CleanData$DateTime, CleanData$Sub_metering_2, col="red")
lines(CleanData$DateTime, CleanData$Sub_metering_3, col="blue")
legend("topright", names(CleanData[7:9]), lty=1, col=c('black', 'red', 'blue'), bty="n")

plot(CleanData$DateTime, CleanData$Voltage, xlab="datetime", ylab="Voltage", type="l")

plot(CleanData$DateTime, CleanData$Global_reactive_power, xlab="datetime", ylab="Global_reactive_power", type="l", lwd=0.75)

dev.off()
