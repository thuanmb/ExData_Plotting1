# Load data
fileUrl <- "household_power_consumption.txt"
con <- file(fileUrl, 'r')
rm('fileUrl')
data <- read.table(
    con, 
    stringsAsFactors = FALSE,
    header = TRUE,
    sep = ";",
    na.string = "?"
)
data$Date_Time <- strptime(sprintf("%s %s", data$Date, data$Time), "%d/%m/%Y %H:%M:%S")

close(con)
rm('con')

#Filter data
minDate <- as.POSIXct("2007-02-01 00:00:00")
maxDate <- as.POSIXct("2007-02-03 00:00:00")
data = data[data$Date_Time >= minDate & data$Date_Time <= maxDate, ]

# Plot
par(mfrow = c(1, 1))
par(mar=c(0, 0, 0, 0))
globalActivePowerData <- data[complete.cases(data$Global_active_power), ]

with(globalActivePowerData, plot(Date_Time, Sub_metering_1,
                                 main = "",
                                 xlab = "",
                                 ylab = "Energy sub metering",
                                 type = "l",
                                 xaxt="n"
))
with(globalActivePowerData, lines(Date_Time, Sub_metering_2,
                                 col = "red"
))
with(globalActivePowerData, lines(Date_Time, Sub_metering_3,
                                 col = "blue"
))
axis.POSIXct(1, at = seq(
    globalActivePowerData$Date_Time[1],
    globalActivePowerData$Date_Time[length(globalActivePowerData$Date_Time)], "days"), format = "%a")
legend("topright", lty = 1, col = c("black", "red", "blue"),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.copy(png, "plot3.png")
dev.off()

rm('minDate')
rm('maxDate')
rm('globalActivePowerData')
rm('data')