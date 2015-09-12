#Read Electric power consumption file's rows for dates 1/2/2007 and 2/2/2007 and convert the "Date" variables into date format
fpwr <- file("./household_power_consumption.txt")
pwr <- read.table(text = grep("^[1,2]/2/2007", readLines(fpwr), value = TRUE), sep = ";", header = TRUE, col.names = c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
pwr$Date <- as.Date(pwr$Date, format = "%d/%m/%Y")

#Convert dates
Sys.setlocale("LC_TIME", "English")
datetime <- paste(as.Date(pwr$Date), pwr$Time)
pwr$Datetime <- as.POSIXct(datetime)

#Create plot 4
par(mfrow = c(2, 2), mar = c(4, 4, 2, 1), oma = c(0,0,2,0))
with(pwr, {
        plot(Global_active_power ~ Datetime, type = "l", ylab = "Global Active Power", xlab = "", cex.lab = 0.8, cex.axis = 0.8)
        plot(Voltage ~ Datetime, type = "l", cex.axis = 0.8, cex.lab=0.8)
        plot(Sub_metering_1 ~ Datetime, type = "l", ylab = "Energy sub metering", xlab = "", cex.axis = 0.75, cex.lab = 0.75)
        lines(Sub_metering_2 ~ Datetime, type = "l", col = "Red")
        lines(Sub_metering_3 ~ Datetime, type = "l", col = "Blue")
        legend("topright", col = c("Black", "Red", "Blue"), bty="n", lwd = 1, legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), cex = 0.5, y.intersp = 0.5)
        plot(Global_reactive_power ~ Datetime, type = "l", cex.axis = 0.8, cex.lab = 0.8)
})

#Save the plot in a png file
dev.copy(png, file = "plot4.png", width = 480, height = 480)
dev.off()