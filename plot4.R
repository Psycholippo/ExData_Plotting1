## Creates 4 different exploratory plots from between 1/2/2007 and 2/2/2007


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
subset$Voltage <- as.numeric(subset$Voltage)
subset$Global_reactive_power <- as.numeric(subset$Global_reactive_power)

## Draw plots
par(mfrow = c(2, 2), mar = c(4, 4, 2, 1), oma = c(0, 0, 2, 0))

## Plot 1
plot(subset$DateTime, subset$Global_active_power, type="l",
     ylab="Global Active Power", xlab="")

## Plot 2
plot(subset$DateTime, subset$Voltage, type="l", ylab="Voltage", xlab="datetime")

## Plot 3
with(subset, plot(DateTime, Sub_metering_1, type="l",
                  ylab="Energy sub metering", xlab=""))
with(subset, points(DateTime, Sub_metering_2, type="l", col="red"))
with(subset, points(DateTime, Sub_metering_3, type="l", col="blue"))
legend("topright", lwd=1, col=c("black","red","blue"),
       legend=c("1", "2", "3"))

## Plot 4
plot(subset$DateTime, subset$Global_reactive_power, type="l",
     ylab="Global_reactive_power", xlab="datetime")

## Export plot
dev.copy(png,'plot4.png')
dev.off()
