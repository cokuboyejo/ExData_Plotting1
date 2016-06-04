#read data
data  <- read.table("household_power_consumption.txt", header = TRUE,
                    sep = ";", na.strings = "?")

#convert to Date 
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")

#subset data 
D1 <- as.Date("2007-02-01")
D2 <- as.Date("2007-02-02")
data_feb <- subset(data, Date %in% c(D1, D2))

## create 'datetime'
datetime <- paste(as.Date(data_feb$Date), data_feb$Time)
data_feb$datetime <- as.POSIXct(datetime)

#plot 4
png(filename = "plot4.png", width = 480, height = 480, units = "px")
par(mfcol = c(2,2))
with(data_feb, plot(datetime, Global_active_power, type = "l", xlab = "",
                    ylab = "Global Active Power (kilowatts)"))
with(data_feb, {
        plot(datetime, Sub_metering_1, type = "l", 
             xlab = "", ylab = "Energy sub metering")
        lines(datetime, Sub_metering_2, type = "l", col = "red")
        lines(datetime, Sub_metering_3, type = "l", col = "blue")
        legend("topright", 
               legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
               lty = 1, col = c("black", "red", "blue"))
})
with(data_feb, plot(datetime, Voltage, type = "l", xlab = "datetime", 
                    ylab = "Voltage"))
with(data_feb, plot(datetime, Global_reactive_power, type = "l", 
                    xlab = "datetime", ylab = "Global_reactive_power"))
dev.off()
