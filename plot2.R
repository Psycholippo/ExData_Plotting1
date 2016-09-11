## Creates a plot of Global Active Power between 1/2/2007 and 2/2/2007


## Read data in
data <- read.table("household_power_consumption.txt", header=TRUE, sep=";",
                colClasses=c("character","character","character","character",
                "character","character","character","character","character"),
                skipNul = TRUE)

## subset & Convert
subset <- data[which(data$Date=="1/2/2007" | data$Date=="2/2/2007"),]
subset$Global_active_power <- as.numeric(subset$Global_active_power)
subset$DateTime <- as.POSIXct(paste(subset$Date, subset$Time),
                              format="%d/%m/%Y %H:%M:%S")

## Draw plot
par(mfrow = c(1, 1), mar = c(5,4,4,2) + 0.1, oma = c(2, 2, 2, 2))
plot(subset$DateTime, subset$Global_active_power, type="l",
     ylab="Global Active Power (kilowatts)", xlab="")

## Export plot
dev.copy(png,'plot2.png')
dev.off()
