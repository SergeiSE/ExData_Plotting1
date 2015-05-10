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
png(filename="plot2.png", width=480, height=480, type="cairo")
plot(CleanData$DateTime, CleanData$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")
dev.off()
