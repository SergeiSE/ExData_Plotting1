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
png(filename="plot3.png", width=480, height=480, type="cairo")
y_l <- 0
y_l[2] <- max(CleanData$Sub_metering_1, CleanData$Sub_metering_2, CleanData$Sub_metering_3)
plot(CleanData$DateTime, CleanData$Sub_metering_1, type="l", col="black", xlab="", ylab="Energy sub metering", ylim=y_l)
lines(CleanData$DateTime, CleanData$Sub_metering_2, col="red")
lines(CleanData$DateTime, CleanData$Sub_metering_3, col="blue")
legend("topright", names(CleanData[7:9]), lty=1, col=c('black', 'red', 'blue'))
dev.off()
