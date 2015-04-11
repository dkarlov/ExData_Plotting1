
#load raw data
raw_data <- read.csv("~/data_science/household_power_consumption.txt", sep=";", na.strings="?", stringsAsFactors=FALSE)

#delete unnecessary data
data <- subset(raw_data, Date == "1/2/2007" | Date == "2/2/2007")
remove(raw_data)

#Convert date and time colomns to a date/time
temp <- c()
for (i in 1:length(data$Date))
  {
     temp <- rbind(temp, strptime(paste(data[i, 1], data[i, 2]), "%m/%d/%Y %H:%M:%S"))
  }

data <- cbind(temp, data[c(-1, -2)])


#connect to device
png("plot1.png")

#plot data
hist(data$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)",  ylim=c(0,1200))

#close device
dev.off()