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


## 1st graphe
png("plot1.png", width = 480, height = 480)

hist(hpc$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power")

dev.off()