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
png("plot2.png")

#plotting 
plot(graph_data$Global_active_power,type = "l", ylab= "Global Active Power (kilowatts)",xlab = "", xaxt="n")

#adding x axis 'ticks' and labels
axis(side = 1, at=c(0,1500,2900),labels=c("Thu", "Fri","Sat"))

#turining off graphic device
dev.off()
