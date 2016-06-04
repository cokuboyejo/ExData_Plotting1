#read data
data  <- read.table("household_power_consumption.txt", header = TRUE,
                    sep = ";", na.strings = "?")

#convert to Date
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")

#subset data 
D1 <- as.Date("2007-02-01")
D2 <- as.Date("2007-02-02")
data_feb <- subset(data, Date %in% c(D1, D2))

## create 'datetime' column
datetime <- paste(as.Date(data_feb$Date), data_feb$Time)
data_feb$datetime <- as.POSIXct(datetime)

#Plot 1
png(filename = "plot1.png", width = 480, height = 480, units = "px")
hist(data_feb$Global_active_power, col = "red", 
     main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.off()