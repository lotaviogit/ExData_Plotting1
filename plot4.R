readData <- read.table('household_power_consumption.txt', sep=';', header=T, 
                   colClasses = c('character', 'character', 'numeric',
                                  'numeric', 'numeric', 'numeric',
                                  'numeric', 'numeric', 'numeric'),
                   na.strings='?')

# strip the data time
readData$DateTime <- strptime(paste(readData$Date, readData$Time), 
                          "%d/%m/%Y %H:%M:%S")
# set the data time for the days 1 & 2 of month 02 
readData <- subset(readData, as.Date(DateTime) >= as.Date("2007-02-01") & 
                 as.Date(DateTime) <= as.Date("2007-02-02"))



png("plot4.png", height=500, width=500)

# I'm brazillian, so the days are in portuguese...

# multiplot
par(mfrow=c(2,2))

# global plot
plot(readData$DateTime, readData$Global_active_power, 
	 pch=NA, xlab="", ylab="Global Active Power (kilowatts)")
lines(readData$DateTime, readData$Global_active_power)

# voltage plot
plot(readData$DateTime, readData$Voltage, ylab="Voltage", xlab="datetime", pch=NA)
lines(readData$DateTime, readData$Voltage)

# submetering plot
plot(readData$DateTime, readData$Sub_metering_1, pch=NA, 
     xlab="", ylab="Energy sub metering")
lines(readData$DateTime, readData$Sub_metering_1)
lines(readData$DateTime, readData$Sub_metering_2, col='red')
lines(readData$DateTime, readData$Sub_metering_3, col='blue')
legend('topright', c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty = c(1,1,1), col = c('black', 'red', 'blue'), bty = 'n')

# global reactive plot
with(readData, plot(DateTime, Global_reactive_power, xlab='datetime', pch=NA))
with(readData, lines(DateTime, Global_reactive_power))

# Close PNG file
dev.off()