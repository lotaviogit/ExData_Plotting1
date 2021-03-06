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

# plot3.png
png("plot3.png", height=500, width=500)

# plot the data
plot(readData$DateTime, readData$Sub_metering_1, pch=NA, 
     xlab="", ylab="Energy sub metering")

# add lines	 
# I'm from Brazil, so the day will be in portuguese.
lines(readData$DateTime, readData$Sub_metering_1)
lines(readData$DateTime, readData$Sub_metering_2, col='red')
lines(readData$DateTime, readData$Sub_metering_3, col='blue')
# add the legends
legend('topright', c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty = c(1,1,1), col = c('black', 'red', 'blue'))

# close the png
dev.off()