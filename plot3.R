
#load raw data
raw_data <- read.csv("~/data_science/household_power_consumption.txt", sep=";", na.strings="?", stringsAsFactors=FALSE)

#delete unnecessary data
data <- subset(raw_data, Date == "1/2/2007" | Date == "2/2/2007")
remove(raw_data)

#Convert date and time colomns to a date/time
temp <- c()

for (i in 1:length(data$Date))
{
  temp <- rbind(temp, strptime(paste(data[i, 1], data[i, 2]), "%d/%m/%Y %H:%M:%S"))
}

data <- cbind(temp, data[c(-1, -2)])

time <- c()


for (i in 1:length(data$min))
{
  time <- rbind(time, as.numeric(data[i, 2]) + as.numeric(data[i, 3]) * 60 + (as.numeric(data[i, 4]) -1) * 24 * 60)
}
colnames(time) <- c("time")
data <- cbind(time, data)

#plot data
#connect to device
png("plot3.png")

#plot data
plot(data$time, data$Sub_metering_1, pch = ".", xaxt='n',  main = "", xlab = "", ylab = "Energy sub metering")
lines(data$time, data$Sub_metering_1)
lines(data$time, data$Sub_metering_3, col= "blue")
lines(data$time, data$Sub_metering_2, col= "red")
axis(1, at=c(0, 1439, 2880), labels=c("Thu", "Fri", "Sat"))
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), pch ="-")

#close device
dev.off()
