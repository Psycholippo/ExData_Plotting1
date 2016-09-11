## Creates a plot of different sub metering levels between 1/2/2007 and 2/2/2007


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
subset$Sub_metering_1 <- as.numeric(subset$Sub_metering_1)
subset$Sub_metering_2 <- as.numeric(subset$Sub_metering_2)
subset$Sub_metering_3 <- as.numeric(subset$Sub_metering_3)

## Draw plot
par(mfrow = c(1, 1), mar = c(5,4,4,0) + 0.1, oma = c(2, 2, 2, 2))
with(subset, plot(DateTime, Sub_metering_1, type="l",
                  ylab="Energy sub metering", xlab=""))
with(subset, points(DateTime, Sub_metering_2, type="l", col="red"))
with(subset, points(DateTime, Sub_metering_3, type="l", col="blue"))
legend("topright", lwd=1, col=c("black","red","blue"),
       legend=c("1", "2", "3"))

## Export plot
dev.copy(png,'plot3.png')
dev.off()
