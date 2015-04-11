
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
png("plot2.png")

#plot data
plot(data$time, data$Global_active_power, pch = ".", xaxt='n',  main = "", xlab = "", ylab = "Global Active Power (kilowatts)")
axis(1, at=c(0, 1439, 2880), labels=c("Thu", "Fri", "Sat"))
lines(data$time, data$Global_active_power)

#close device
dev.off()