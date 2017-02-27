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

#starting graphic device
png("plot1.png")

#ploting histogram
hist(graph_data$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")

#turning off graphic device
dev.off()
