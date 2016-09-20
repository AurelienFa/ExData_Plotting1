## Read the file and construct the data frame source
file <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(file, "hpc.zip")
unzip("hpc.zip")

require(data.table)

## Determines which lines to import for the exercise
first_day <- c("1/2/2007")
nb_rows <- 1*60*24*2

## Read the data and create a data frame
hpc_names <- fread("household_power_consumption.txt", header = TRUE, nrow = 0, sep = ";")
hpc <- fread("household_power_consumption.txt", header = FALSE, skip = first_day, nrow = nb_rows, sep =";")
names(hpc) <- names(hpc_names)

## Transform the character into Date format
hpc$DateTime <- paste(hpc$Date, hpc$Time)
hpc[[10]] <- strptime(hpc[[10]], "%d/%m/%Y %T")

## 4th graphe
png("plot4.png", width = 480, height = 480)

par(mfcol = c(2,2))

plot(hpc$DateTime, hpc$Global_active_power, "n", xlab ="", ylab ="Global Active Power")
lines(hpc$DateTime, hpc$Global_active_power)

plot(hpc$DateTime, hpc$Sub_metering_1, "n", xlab ="", ylab ="Energy sub metering")
lines(hpc$DateTime, hpc$Sub_metering_1, col = "black")
lines(hpc$DateTime, hpc$Sub_metering_2, col = "red")
lines(hpc$DateTime, hpc$Sub_metering_3, col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = 1, col = c("black", "red", "blue"), bty = "n")

plot(hpc$DateTime, hpc$Voltage, "n", xlab ="datetime", ylab = "Voltage")
lines(hpc$DateTime, hpc$Voltage)

plot(hpc$DateTime, hpc$Global_reactive_power, "n", xlab ="datetime")
lines(hpc$DateTime, hpc$Global_reactive_power)

dev.off()

