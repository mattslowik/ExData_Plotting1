# Loading tidyr package for subseting data
library(tidyr) 

#reading date from file and cleaning from NA values
large_data <- read.csv("household_power_consumption.txt", sep = ";", colClasses = c("Date"="character", "Time"="character"), na.strings = "?")
large_data_clean <- na.omit(large_data)

#memory cleanup
rm(large_data)

#converting Data character to POSIXlt class
large_data_clean$Date <- strptime(large_data_clean$Date, format = "%d/%m/%Y")

#subseting data 
graph_data <- subset(large_data_clean, large_data_clean$Date >= '2007-02-01' &  large_data_clean$Date <= '2007-02-02')

#memory cleanup
rm(large_data_clean)

#initializing graphic device
png("plot4.png")

#setting plot layout 2-rows, 2 columns
par(mfrow = c(2,2))

#plotting 1st plot
plot(graph_data$Global_active_power,type = "l", ylab= "Global Active Power (kilowatts)",xlab = "", xaxt="n")
axis(side = 1, at=c(0,1500,2900),labels=c("Thu", "Fri","Sat"))

#plotting 2nd plot
plot(graph_data$Voltage,type = "l", ylab= "Volatge",xlab = "datetime", xaxt="n")
axis(side = 1, at=c(0,1500,2900),labels=c("Thu", "Fri","Sat"))

#plotting 3rd plot
plot(graph_data$Sub_metering_1,type="l",col="brown",ylab= "Energy sub-metering", xlab = "", xaxt="n" )
lines(graph_data$Sub_metering_2,type="l", col="red")
lines(graph_data$Sub_metering_3,type="l", col="blue")
axis(side = 1, at=c(0,1500,2900),labels=c("Thu", "Fri","Sat"))
legend_names <- c("Sub_metering_1", "Sub_metering_2","Sub_metering_3")
legend("topright", legend_names, lty = 1,col = c("brown","red","blue"), y.intersp = 1.5,cex = .7 ,ncol = 1.4)

#plotting 4th plot
plot(graph_data$Global_reactive_power,type = "l",xlab = "datetime", xaxt="n")
axis(side = 1, at=c(0,1500,2900),labels=c("Thu", "Fri","Sat"))

#turning off graphic device
dev.off()
