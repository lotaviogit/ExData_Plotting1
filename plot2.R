readData <- read.table('household_power_consumption.txt', sep=';', header=T, 
                       colClasses = c('character', 'character', 'numeric',
                                      'numeric', 'numeric', 'numeric',
                                      'numeric', 'numeric', 'numeric'),
                       na.strings='?')
# strip the data time
readData$DateTime <- strptime(paste(readData$Date, readData$Time), 
                              "%d/%m/%Y %H:%M:%S")
# set the data time for the days 1 & 2
readData <- subset(readData, as.Date(DateTime) >= as.Date("2007-02-01") & 
                     as.Date(DateTime) <= as.Date("2007-02-02"))

# open a '.png' file
png("plot2.png", height=500, width=500)

plot(readData$DateTime, readData$Global_active_power,
     pch = NA, xlab='', ylab='Global Active Power (kilowatts)')
lines(readData$DateTime, readData$Global_active_power)

def.off()