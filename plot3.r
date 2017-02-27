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
png("plot3.png")

#plotting 1st variable
plot(graph_data$Sub_metering_1,type="l",col="brown",ylab= "Energy sub-metering", xlab = "", xaxt="n" )

#plotting 2nd variable
lines(graph_data$Sub_metering_2,type="l", col="red")

#plotting 3rd varible
lines(graph_data$Sub_metering_3,type="l", col="blue")

#adding x axis 'ticks' and labels
axis(side = 1, at=c(0,1500,2900),labels=c("Thu", "Fri","Sat"))

#creating legend
legend_names <- c("Sub_metering_1", "Sub_metering_2","Sub_metering_3")
legend("topright", legend_names, lty = 1,col = c("brown","red","blue"), y.intersp = 1.5,cex = .7, ncol = 1.4)

#turing off graphic device
dev.off()

