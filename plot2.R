# Download and unzip Electric power consumption file
if (!file.exists("household_power_consumption.txt")) {
        download.file(url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile = "./household_power_consumption.zip")
        unzip(zipfile = "./household_power_consumption.zip")
}

#Read Electric power consumption file's rows for dates 1/2/2007 and 2/2/2007 and convert the "Date" variables into date format
fpwr <- file("./household_power_consumption.txt")
pwr <- read.table(text = grep("^[1,2]/2/2007", readLines(fpwr), value = TRUE), sep = ";", header = TRUE, col.names = c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
pwr$Date <- as.Date(pwr$Date, format = "%d/%m/%Y")

#Convert dates
Sys.setlocale("LC_TIME", "English")
datetime <- paste(as.Date(pwr$Date), pwr$Time)
pwr$Datetime <- as.POSIXct(datetime)

#Create plot 2
par(mfrow = c(1,1))
plot(pwr$Global_active_power ~ pwr$Datetime, type = "l", ylab = "Global Active Power (kilowatts)", xlab = "", cex.lab = 0.8, cex.axis = 0.8)


#Save the plot in a png file
dev.copy(png, file = "plot2.png", width = 480, height = 480)
dev.off()