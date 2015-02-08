library(dplyr)
library(lubridate)
library(tidyr)

data <- tbl_df(read.csv("household_power_consumption.txt", sep = ";", header = TRUE))
data <- mutate(data, datetime = dmy(Date) + hms(Time))
data <- filter(data, Global_active_power != "?")
data <- filter(data, datetime >= ymd("2007-02-01"), datetime < ymd("2007-02-03"))
data <- mutate(data, Global_active_power = as.numeric(as.character(Global_active_power)))
data <- mutate(data, Global_reactive_power = as.numeric(as.character(Global_reactive_power)))
data <- mutate(data, Voltage = as.numeric(as.character(Voltage)))
data <- mutate(data, Global_intensity = as.numeric(as.character(Global_intensity)))
data <- mutate(data, Sub_metering_1 = as.numeric(as.character(Sub_metering_1)))
data <- mutate(data, Sub_metering_2 = as.numeric(as.character(Sub_metering_2)))
data <- mutate(data, Sub_metering_3 = as.numeric(as.character(Sub_metering_3)))

png(filename = "plot4.png", width = 480, height = 480, bg="transparent")
par(mfrow=c(2,2))
# Upper, left plot
plot(data$datetime, data$Global_active_power, type = "n", xlab = "", ylab = "Global Active Power") 
lines(data$datetime, data$Global_active_power)
# Upper, right plot
plot(data$datetime, data$Voltage, type = "n", xlab = "datetime", ylab = "Voltage") 
lines(data$datetime, data$Voltage)
# Lower left plot
plot(data$datetime, data$Sub_metering_1, type = "n", xlab = "", ylab = "Energy sub metering")
lines(data$datetime, data$Sub_metering_1)
lines(data$datetime, data$Sub_metering_2, col = "red")
lines(data$datetime, data$Sub_metering_3, col = " blue")
legend('topright', legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty = c(1, 1, 1), bty = "n")
# Lower right plot
plot(data$datetime, data$Global_reactive_power, type = "n", xlab = "datetime", ylab = "Global_reactive_power") 
lines(data$datetime, data$Global_reactive_power)
dev.off()